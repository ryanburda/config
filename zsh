#################
# Bluetooth reset
#################
alias bt='sudo kextunload -b com.apple.iokit.BroadcomBluetoothHostControllerUSBTransport; sudo kextload -b com.apple.iokit.BroadcomBluetoothHostControllerUSBTransport'
