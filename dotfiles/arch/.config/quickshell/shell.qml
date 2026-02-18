import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

ShellRoot {
    id: root

    // Theme colors
    property color colBg: "#EB1a1b26"
    property color colFg: "#a9b1d6"
    property color colMuted: "#444b6a"
    property color colActive: "#777777"
    property color colInactive: "#333333"

    // Font
    property string fontFamily: "JetBrainsMono Nerd Font"
    property int fontSize: 16

    // Layout properties
    property int radiusContainer: 16
    property int radiusElement: 8
    property int spacing: 8
    property int columnBarMinWidth: 4
    property int columnBarMaxWidth: 80
    property string dateFormat: "ddd, MMM dd - h:mm ap"

    // System info properties
    property string kernelVersion: "Linux"
    property int volumeLevel: 0
    property bool volumeVisible: false
    property int batteryPercentage: 0
    property bool hasBattery: false

    // Workspace properties
    property var workspaces: []
    property int focusedWorkspaceId: -1
    property int focusedWorkspaceIdx: 1

    // Window/column properties
    property var windows: []
    property var columns: []  // Array of {column: num, width: num, isFocused: bool}

    // Function to process windows into column data
    function processColumns() {
        // Filter windows for focused workspace
        var workspaceWindows = windows.filter(function(w) {
            return w.workspace_id === focusedWorkspaceId && !w.is_floating
        })

        if (workspaceWindows.length === 0) {
            columns = [{column: 1, width: 1.0, isFocused: true}]
            return
        }

        // Group by column and get widths
        var columnMap = {}  // column -> max width
        var focusedCol = -1

        for (var i = 0; i < workspaceWindows.length; i++) {
            var win = workspaceWindows[i]
            var col = win.layout.pos_in_scrolling_layout[0]
            var width = win.layout.tile_size[0]

            if (win.is_focused) {
                focusedCol = col
            }

            if (!columnMap[col] || columnMap[col] < width) {
                columnMap[col] = width
            }
        }

        // Create sorted array of columns
        var colNumbers = []
        for (var colNum in columnMap) {
            colNumbers.push(parseInt(colNum))
        }
        colNumbers.sort(function(a, b) { return a - b })

        // Build final columns array
        var cols = []
        var maxWidth = 0
        for (var colNum in columnMap) {
            if (columnMap[colNum] > maxWidth) {
                maxWidth = columnMap[colNum]
            }
        }

        for (var i = 0; i < colNumbers.length; i++) {
            var colNum = colNumbers[i]
            cols.push({
                column: colNum,
                width: columnMap[colNum] / maxWidth,  // Normalize to 0-1
                isFocused: colNum === focusedCol
            })
        }

        // If only one column, make it a single indicator
        if (cols.length === 1) {
            cols = [{column: 1, width: 1.0, isFocused: true}]
        }

        columns = cols
    }

    // Kernel version
    Process {
        id: kernelProc
        command: ["uname", "-r"]
        stdout: SplitParser {
            onRead: data => {
                if (data) kernelVersion = data.trim()
            }
        }
        Component.onCompleted: running = true
    }

    // Volume level (wpctl for PipeWire)
    Process {
        id: volProc
        command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                var match = data.match(/Volume:\s*([\d.]+)/)
                if (match) {
                    volumeLevel = Math.round(parseFloat(match[1]) * 100)
                }
            }
        }
        Component.onCompleted: running = true
    }

    // Volume event listener (pactl subscribe for real-time updates)
    Process {
        id: volEventProc
        command: ["pactl", "subscribe"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                // Trigger volume update on sink events
                if (data.includes("Event 'change' on sink")) {
                    volProc.running = true
                }
            }
        }
        Component.onCompleted: running = true
    }

    // Show volume when it changes
    onVolumeLevelChanged: {
        volumeVisible = true
        volumeHideTimer.restart()
    }

    // Reprocess columns when workspace changes
    onFocusedWorkspaceIdChanged: {
        processColumns()
    }

    // Timer to hide volume after 3 seconds
    Timer {
        id: volumeHideTimer
        interval: 3000
        running: false
        repeat: false
        onTriggered: volumeVisible = false
    }

    // Check if battery exists
    Process {
        id: batteryCheckProc
        command: ["test", "-e", "/sys/class/power_supply/BAT0/capacity"]
        running: true
        onExited: (code, status) => {
            hasBattery = (code === 0)
            if (hasBattery) {
                batteryProc.running = true
            }
        }
    }

    // Battery percentage
    Process {
        id: batteryProc
        command: ["cat", "/sys/class/power_supply/BAT0/capacity"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                batteryPercentage = parseInt(data.trim())
            }
        }
    }

    // Battery update timer (check every 30 seconds)
    Timer {
        id: batteryTimer
        interval: 30000
        running: root.hasBattery
        repeat: true
        onTriggered: batteryProc.running = true
    }

    // Power menu process
    Process {
        id: powerProc
        command: ["sh", "-c", "~/.local/bin/power-menu.sh"]
    }

    // Settings menu process
    Process {
        id: settingsProc
        command: ["sh", "-c", "~/.local/bin/settings-menu.sh"]
    }

    // Get niri workspaces
    Process {
        id: workspacesProc
        command: ["niri", "msg", "--json", "workspaces"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                try {
                    var ws = JSON.parse(data)
                    // Sort workspaces by index
                    ws.sort(function(a, b) { return a.idx - b.idx })
                    root.workspaces = ws
                    // Find focused workspace
                    for (var i = 0; i < ws.length; i++) {
                        if (ws[i].is_focused) {
                            root.focusedWorkspaceId = ws[i].id
                            root.focusedWorkspaceIdx = ws[i].idx
                            break
                        }
                    }
                } catch (e) {
                    console.error("Failed to parse workspaces:", e)
                }
            }
        }
        Component.onCompleted: running = true
    }

    // Listen for workspace events
    Process {
        id: workspaceEventProc
        command: ["niri", "msg", "--json", "event-stream"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                try {
                    var event = JSON.parse(data)
                    // Refresh workspaces on any workspace-related event
                    if (event.WorkspacesChanged || event.WorkspaceActivated) {
                        workspacesProc.running = true
                        windowsProc.running = true
                    }
                    // Refresh windows on window events
                    if (event.WindowsChanged || event.WindowFocusChanged ||
                        event.WindowOpenedOrChanged || event.WindowClosed ||
                        event.WindowLayoutsChanged) {
                        windowsProc.running = true
                    }
                } catch (e) {
                    // Ignore parse errors from event stream
                }
            }
        }
        Component.onCompleted: running = true
    }

    // Get niri windows
    Process {
        id: windowsProc
        command: ["niri", "msg", "--json", "windows"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                try {
                    root.windows = JSON.parse(data)
                    root.processColumns()
                } catch (e) {
                    console.error("Failed to parse windows:", e)
                }
            }
        }
        Component.onCompleted: running = true
    }


    Variants {
        model: Quickshell.screens

        PanelWindow {
            property var modelData
            screen: modelData

            anchors {
                bottom: true
                left: true
                right: true
            }

            implicitHeight: 30
            color: "transparent"

            margins {
                top: 0
                bottom: 0
                left: 0
                right: 0
            }

            Rectangle {
                anchors.fill: parent
                color: "transparent"

                // Power and settings on the left
                Rectangle {
                    id: leftMenuContainer
                    color: root.colBg
                    radius: root.radiusContainer
                    anchors.left: parent.left
                    anchors.leftMargin: 12
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height
                    implicitWidth: leftMenuRow.implicitWidth

                    RowLayout {
                        id: leftMenuRow
                        anchors.fill: parent
                        spacing: 0

                        Item { width: root.spacing }

                        Rectangle {
                            color: powerMouseArea.containsMouse ? Qt.lighter(root.colBg, 1.2) : "transparent"
                            radius: root.radiusElement
                            Layout.preferredWidth: powerText.implicitWidth + 16
                            Layout.preferredHeight: parent.height

                            Text {
                                id: powerText
                                anchors.centerIn: parent
                                text: "⏻ "
                                color: root.colFg
                                font.pixelSize: root.fontSize
                                font.family: root.fontFamily
                                font.bold: true
                            }

                            MouseArea {
                                id: powerMouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    powerProc.running = true
                                }
                            }
                        }

                        Rectangle {
                            color: settingsMouseArea.containsMouse ? Qt.lighter(root.colBg, 1.2) : "transparent"
                            radius: root.radiusElement
                            Layout.preferredWidth: settingsText.implicitWidth + 16
                            Layout.preferredHeight: parent.height

                            Text {
                                id: settingsText
                                anchors.centerIn: parent
                                text: "  "
                                color: root.colFg
                                font.pixelSize: root.fontSize
                                font.family: root.fontFamily
                                font.bold: true
                            }

                            MouseArea {
                                id: settingsMouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    settingsProc.running = true
                                }
                            }
                        }

                        Item { width: root.spacing }
                    }
                }

                // Workspaces and column indicators in the center
                Rectangle {
                    id: centerContainer
                    color: root.colBg
                    radius: root.radiusContainer
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height
                    implicitWidth: centerRow.implicitWidth

                    RowLayout {
                        id: centerRow
                        anchors.fill: parent
                        spacing: 4

                        Item { width: root.spacing }

                        Text {
                            text: root.focusedWorkspaceIdx
                            color: root.colFg
                            font.pixelSize: root.fontSize
                            font.family: root.fontFamily
                            font.bold: true
                        }

                        Item { width: root.spacing }

                        Repeater {
                            id: columnRepeater
                            model: root.columns
                            delegate: Rectangle {
                                id: columnBar
                                property bool isFocused: modelData.isFocused
                                property real colWidth: modelData.width
                                property int columnNum: modelData.column

                                color: isFocused ? root.colActive : root.colInactive
                                radius: root.radiusElement
                                Layout.preferredWidth: Math.max(root.columnBarMinWidth, colWidth * root.columnBarMaxWidth)
                                Layout.preferredHeight: parent.height - (root.spacing * 2)
                                Layout.alignment: Qt.AlignVCenter
                            }
                        }

                        Item { width: root.spacing }
                    }
                }

                // Right side widgets
                Rectangle {
                    id: rightWidgetsContainer
                    color: root.colBg
                    radius: root.radiusContainer
                    anchors.right: parent.right
                    anchors.rightMargin: 12
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height
                    implicitWidth: widgetRow.implicitWidth

                    RowLayout {
                        id: widgetRow
                        anchors.fill: parent
                        spacing: 0

                        Text {
                            text: "   " + volumeLevel + "%"
                            color: root.colFg
                            font.pixelSize: root.fontSize
                            font.family: root.fontFamily
                            font.bold: true
                            Layout.rightMargin: root.spacing
                            Layout.leftMargin: root.spacing
                            visible: root.volumeVisible
                        }

                        Text {
                            text: "   " + batteryPercentage + "%"
                            color: root.colFg
                            font.pixelSize: root.fontSize
                            font.family: root.fontFamily
                            font.bold: true
                            Layout.rightMargin: root.spacing
                            Layout.leftMargin: root.spacing
                            visible: root.hasBattery
                        }

                        Text {
                            id: clockText
                            text: Qt.formatDateTime(new Date(), root.dateFormat)
                            color: root.colFg
                            font.pixelSize: root.fontSize
                            font.family: root.fontFamily
                            font.bold: true
                            Layout.rightMargin: root.spacing
                            Layout.leftMargin: root.spacing

                            Timer {
                                interval: 1000
                                running: true
                                repeat: true
                                onTriggered: clockText.text = " " + Qt.formatDateTime(new Date(), root.dateFormat)
                            }
                        }

                        Item { width: root.spacing }
                    }
                }
            }
        }
    }
}
