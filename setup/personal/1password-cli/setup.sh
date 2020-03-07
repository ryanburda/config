#!/usr/bin/env bash
brew cask install 1password-cli

eval $(op signin https://my.1password.com ryan.burda@gmail.com)
