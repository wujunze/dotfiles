if has('nvim')
  :let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
  :let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
endif

" 设置查找文件时使用的路径
set path=.,$HOME/.local/include,/usr/local/include,/usr/include,,

" 让 .\ 在 'tags' 选项里表示相对于当前路径而不是相对于当前文件
set cpoptions+=d

" 插入模式自动补全标签显示更多信息
set showfulltag

" 禁止过长的行回绕（超过屏幕宽度）
set nowrap

" 设置回绕行的视觉提示
set showbreak=↪

" 让水平滚动更加自然
set sidescroll=1
set sidescrolloff=3

" 设置状态栏、代码折叠、垂直分割的视觉提示
set fillchars=diff:⣿,fold:-,vert:│

" 设置空白字符的视觉提示（eol:¬,nbsp:˽,）
set list listchars=extends:❯,precedes:❮,tab:▸\ ,trail:˽

" 设置行宽的视觉提示
set colorcolumn=80

" 自定义拼写检查
set spell spelllang=en_us
set spellsuggest=best,5
set spellfile=~$HOME/.config/nvim/spell.custom.utf-8.add

" 在右边打开新的窗口（垂直分割）
set splitright

" 按键提示（在状态栏下方）
set showcmd

" 显示行号／列号等附加信息（在状态栏右方）
set ruler

" 设置行的最大宽度（如果允许断行的话）
set textwidth=80

" 设置格式化选项
set formatoptions=cjmqrtB

" 设置自动补全选项
set complete=.,w,b,u,U,i,d,t
set completeopt=longest,menuone,preview
set completefunc=syntaxcomplete#Complete
set omnifunc=syntaxcomplete#Complete

" 自动补全候选窗口最大高度
set pumheight=10

" 自动更正自动补全选项的大小写
set infercase

" 设置命令行补全选项
set wildmenu
set wildmode=list:longest,full

" 设置插入成对符号时闪烁指示
set showmatch
set matchtime=1

" 设置缩进相关选项
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab shiftround smartindent

" 自定义状态栏配置
if has('statusline')
  set laststatus=2

  set statusline=%<                                       " status begins

  if exists('*SyntasticStatuslineFlag')
    set statusline+=%#ErrorMsg#                           " syntastic
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*\                                   " restore highlight
  endif

  set statusline+=%.40f                                   " relative filename
  set statusline+=%y                                      " file type
  set statusline+=[%{&ff}]                                " file format
  set statusline+=[%{strlen(&fenc)?&fenc:'none'}]         " file encoding
  set statusline+=%m                                      " modified flag
  set statusline+=%h                                      " help file flag
  set statusline+=%r                                      " read only flag
  if exists(':Pencil')
    set statusline+=%<\ %{PencilMode()}                   " for pencil plugin
  endif

  set statusline+=%*                                      " restore highlight
  set statusline+=%=                                      " right part
  set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}
  set statusline+=%4l\ %02c\                              " line & column
  set statusline+=%3p%%\ in\ %-4L                         " % of total
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
