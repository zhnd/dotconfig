if status is-interactive
    # Commands to run in interactive sessions can go here
    # PATH

    # node bin
    set PATH $HOME/.nvm/versions/node/v18.16.0/bin $PATH

    # autojump
    [ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

    # cargo
    set PATH $HOME/.cargo/bin $PATH
end