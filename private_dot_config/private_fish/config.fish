if status is-interactive
# Commands to run in interactive sessions can go here
starship init fish | source

alias vim="nvim"
alias ls="lsd -l"
#alias cat="bat"
alias fd="fdfind"
alias zel="zellij"

ssh-add $HOME/.ssh/golden-finch

# opencode
fish_add_path /home/maximo/.opencode/bin
fish_add_path /usr/local/cuda/bin
fish_add_path $HOME/build/llama.cpp/build/bin
set -x LD_LIBRARY_PATH /usr/local/cuda/lib64 $LD_LIBRARY_PATH

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)"

end


set -gx PATH "/home/maximo/.pixi/bin" $PATH

if status is-interactive
    atuin init fish | source
end
