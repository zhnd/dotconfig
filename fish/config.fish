if status is-interactive
    # Commands to run in interactive sessions can go here
    # PATH

    # node bin
    set PATH $HOME/.nvm/versions/node/v18.16.0/bin $PATH

    # autojump
    if test -f /Users/zhued/.autojump/share/autojump/autojump.fish; . /Users/zhued/.autojump/share/autojump/autojump.fish; end
    # cargo
    set PATH $HOME/.cargo/bin $PATH
    
    # neovim
    set PATH $HOME/develop/tools/nvim-macos/bin $PATH
end
# pnpm
set -gx PNPM_HOME "/Users/zhued/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
