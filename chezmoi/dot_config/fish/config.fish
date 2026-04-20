alias ls "ls --human-readable --literal --group-directories-first --color=auto"
# alias ls "eza --group-directories-first"
alias l "ls -l"
alias la "l -a"

alias mkdir "mkdir -p"
alias mv "mv -i"

alias p pacman
alias pU "sudo pacman -U"
alias pq "pacman -Q"
alias pqi "pacman -Qi"
alias pql "pacman -Ql"
alias pr "sudo pacman -Rscn"
alias pss "pacman -Ss"
alias psy "sudo pacman -Sy"
alias psyu "sudo pacman -Syu"

alias pa "pacaur -S"
alias pas "pacaur -Ss"

# flatpak autocomplete is broken with an alias
abbr --add f flatpak
abbr --add fu flatpak update
abbr --add fi flatpak install
abbr --add fiu flatpak install --user

alias c cargo
alias cn "cargo +nightly"

alias sc systemctl
alias scu "systemctl --user"

alias lg lazygit
alias g git
alias ga "git add"
alias gap "git add -p"
alias gau "git add -u"
alias gb "git branch"
alias gbD "git branch -D"
alias gbd "git branch -d"
alias gc "git commit"
alias gca "git commit -a"
alias gcaa "git commit -a --amend"
alias gcam "git commit -am"
alias gch "git checkout"
alias gchb "git checkout -b"
alias gchm "git checkout main"
alias gcm "git commit -m"
alias gd "git diff"
alias gdc "git diff --cached"
alias gf "git fetch"
alias gfo "git fetch origin"
alias gfu "git fetch upstream"
alias gl "git log"
alias glG "git log -G"
alias glo "git log --oneline"
alias gm "git merge"
alias gpul "git pull"
alias gpulo "git pull origin"
alias gpulu "git pull upstream"
alias gpus "git push"
alias gpusf "git push --force-with-lease"
alias gpusu "git push -u"
alias gpusuo "git push -u origin"
alias gr "git rebase"
alias gri "git rebase -i"
alias grm "git remote"
alias grp "git rev-parse"
alias gs "git status"
alias gsh "git show"
alias gsp "git stash pop"
alias gst "git stash"
alias gsu "git submodule update"
alias gsui "git submodule update --init"
alias gsuir "git submodule update --init --recursive"

alias vim nvim
alias vi nvim

# Fix emoji and others rendering
set -g fish_emoji_width 2
set -g fish_cursor_insert line
set -g fish_cursor_replace_one underscore

set -g RUSTUP_DIST_SERVER "https://rsproxy.cn"
set -g RUSTUP_UPDATE_ROOT "https://rsproxy.cn/rustup"

set -g EDITOR nvim

set -gx PATH $PATH ~/.cargo/bin

zoxide init fish | source
starship init fish | source
fish_add_path $HOME/.local/bin
