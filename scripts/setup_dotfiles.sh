git init --bare ~/.dotfiles.git
alias dot='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
dot config status.showUntrackedFiles no
