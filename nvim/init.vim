if has('nvim')
  :let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
  :let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
endif

cnoreabbrev <expr> so getcmdtype() == ':' && getcmdline() == 'so' ? 'source %' : 'so'
cnoreabbrev <expr> ev getcmdtype() == ':' && getcmdline() == 'ev' ? 'tabedit ~/.config/nvim/init.vim' : 'ev'

" 自动安装插件
if empty(glob('$HOME/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd! VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('$HOME/.config/nvim/plugins')
Plug 'jdkanani/vim-material-theme'
call plug#end()

set background=dark
colorscheme material-theme
