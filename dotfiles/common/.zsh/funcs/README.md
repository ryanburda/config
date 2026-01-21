# ZSH Functions

- Any files in this directory ending in `.sh` will automatically get `source`d. This is configured in `~/.zshrc`.
    - This is useful for files that contain a library of functions/environment variables that should all be brought into scope.
- Any files not ending in `.sh` should be manually `autoload`ed.
    - This is useful for scripts where only the name of the script should be brought into scope.
```sh
autoload -Uz <<filename>>
```
