# Skinny

 A skinny (> 70 LOC) script manager and helper for your shell

## Installation
Add this to your shell's rc:
```sh
# If you don't export a specific path for skinny,
# it will use ~/.local/share/skinny
export SKINNY_PATH=~/.skinny

if [ ! -d $SKINNY_PATH ]; then
  mkdir -p $SKINNY_PATH
  curl https://raw.githubusercontent.com/arcticlimer/skinny/master/skinny.sh \
    -o $SKINNY_PATH/skinny.sh
fi

source $SKINNY_PATH/skinny.sh
```

## Usage
Skinny can download and source for you scripts from GitHub repositories, gists, other remote hosts and local files.

Example .bashrc using skinny:
```sh
# Download and source a gist
skinny gist junegunn/f4fca918e937e6bf5bad

# Download a specfic script from a GitHub repository
skinny github lincheney/fzf-tab-completion/master/bash/fzf-bash-completion.sh
bind -x '"\t": fzf_bash_completion'

# You can also specify the commmit hash on the url
skinny github \
  lincheney/fzf-tab-completion/blob/53eb325f573265a6105c9bd0aa56cd865c4e14b7/bash/fzf-bash-completion.sh

# Download a script from other remote
skinny remote https://path/to/raw/script

# Source local files only if they exist
fzf_path=/usr/share/fzf
skinny src $fzf_path/key-bindings.bash
skinny src $fzf_path/completion.bash
skinny src ~/aliases.sh

# Checks if a command exists
skinny cmd zoxide && eval "$(zoxide init bash)"
```

## Dependencies
  - curl (if you want to use remote scripts)

## TODO
- [ ] Support git repositories
- [ ] Test support on other shells
