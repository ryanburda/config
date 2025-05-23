#!/bin/zsh

regenerate_aichat_config() {
    # Creates the aichat config yaml based off templated values
    LIGHT_OR_DARK=$(envget nvim_background)

    if [[ "$LIGHT_OR_DARK" == "light" ]]; then
        export AICHAT_LIGHT_THEME="true"
    else
        export AICHAT_LIGHT_THEME="false"
    fi

    OPENAI_API_KEY=$(cat $HOME/.openai_api_key)
    FILE_PATH="${XDG_CONFIG_HOME}/aichat/config.yaml"

    if [ ! -f $FILE_PATH ]; then
        mkdir -p $(dirname "$FILE_PATH")
        touch $FILE_PATH
    fi

    envsubst < "${XDG_CONFIG_HOME}/aichat/config.yaml.template" > $FILE_PATH
}
