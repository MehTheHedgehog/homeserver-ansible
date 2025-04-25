# install antigen if not exists
if [[ ! -f ~/.antigen/antigen.zsh ]]; then
  set -e
  echo "Antigen not installed, downloading..."
  mkdir -p ~/.antigen
  curl -SL https://github.com/zsh-users/antigen/raw/develop/bin/antigen.zsh -o ~/.antigen/antigen.zsh
  set +e
fi

# Load Antigen
source ~/.antigen/antigen.zsh

# Oh my ZSH plugins
  echo
  echo "=== Useful commands in ZSH ==="
  antigen use oh-my-zsh

  antigen bundle aliases
    echo "als - list aliases"

  antigen bundle ansible # Aliases for ansible
  antigen bundle common-aliases # Common aliases
  antigen bundle command-not-found # Give install hint when there is no given tool in the system
  antigen bundle colored-man-pages # Color the man pages
  antigen bundle dircycle # Cycle thru dirs with arrows
    echo "Navigate dirs with Ctrl + Shift + Arrow"

  antigen bundle encode64
    echo "encode64 - encode base64"

  antigen bundle extract # Provide extract command
    echo "extract - extract popular achives"

  antigen bundle git
  antigen bundle git-auto-fetch
  antigen bundle git-commit
    echo "git <type> <message> - aliases for useful git commit messages"

  antigen bundle gitignore
    echo "gi - show gitignore for given tech"

  antigen bundle history # Aliases for history
  antigen bundle kubectl # Aliases for kubectl
  antigen bundle nmap # Aliases for nmap
  antigen bundle pj # Jump to directory in given directory in PROJECT_PATHS
    echo "pj - jump to directory inside PROJECT_PATHS"

  antigen bundle python
  antigen bundle pip
  antigen bundle pyenv
  antigen bundle safe-paste # Prevent executing pasted commands
  antigen bundle ssh # Completion based on ssh config
  antigen bundle sudo # Shortcut for sudo before last command
    echo "[Esc][Esc] - add sudo before last command"

  antigen bundle supervisor # Aliases for supervisor
  antigen bundle terraform # Aliases for terraform
  antigen bundle tmux # Aliases for tmux
  antigen bundle tmuxinator # Aliases for tmuxinator
  antigen bundle ubuntu # Aliases and autocompletion for ubuntu
  antigen bundle ufw # Aliases for ufw
  antigen bundle universalarchive # Provide universalarchive tool
    echo "ua - compress files into an archive file using given format"

  antigen bundle urltools # Provide urlencode/urldecode
    echo "urlencode/urldecode - encode/decode urls for browser"

  antigen bundle vagrant # Aliases for vagrant
  antigen bundle vscode # Aliases for vscode
  antigen bundle yum # Aliases for yum
  antigen bundle zsh-interactive-cd # Interactive way to change directories in zsh using fzf

  # External Plugin
  antigen bundle zsh-users/zsh-completions
  antigen bundle zsh-users/zsh-autosuggestions
  antigen bundle zsh-users/zsh-history-substring-search

  antigen bundle Tarrasch/zsh-autoenv
  antigen bundle Tarrasch/zsh-bd
    alias cdb='bd'
    echo "cdb - jump back to dir down the stack"

    function list_all() {
        emulate -L zsh
        ls -d | head -n 10 | paste -sd ' ' - | { dirs=$(cat); printf "%s" "$dirs"; [ $(ls -d | wc -l) -gt 10 ] && printf " ..."; echo; }
    }
  chpwd_functions=(${chpwd_functions[@]} "list_all") # Show the first 10 directories check changing directory

  antigen bundle webyneter/docker-aliases.git

    export YSU_MESSAGE_POSITION="after" # Give suggestion after running command
    # export YSU_HARDCORE=1 # Hardcore mode to enforce the use of aliases.
  antigen bundle "MichaelAquilina/zsh-you-should-use"

  antigen bundle zsh-users/zsh-syntax-highlighting # must be last plugin to get effect

  # Load the Jovial theme and plugins
  antigen theme zthxxx/jovial
  antigen bundle zthxxx/jovial

# After all, tell Antigen that you're done, then antigen will start
antigen apply

# Eval autocompletion
if [[ `which task &>/dev/null && $?` == 0 ]]; then
  eval "$(task --completion zsh)"
fi
