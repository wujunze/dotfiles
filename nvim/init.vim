" 显式设置当前脚本的编码方式以支持多字节字符
scriptencoding utf-8

" 开启 NVIM 专用选项
if has('nvim')
  " 允许真彩显示
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
  " 允许光标变化
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
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

  set statusline=%<                                       " 状态栏开始

  if exists('*SyntasticStatuslineFlag')
    set statusline+=%#ErrorMsg#                           " 插件
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*\                                   " 恢复高亮
  endif

  set statusline+=%.40f                                   " 相对路径的当前文件
  set statusline+=%y                                      " 文件类型
  set statusline+=[%{&ff}]                                " 文件格式
  set statusline+=[%{strlen(&fenc)?&fenc:'none'}]         " 文件编码
  set statusline+=%m                                      " 更改状态
  set statusline+=%h                                      " 帮助标识
  set statusline+=%r                                      " 只读标识
  if exists(':Pencil')
    set statusline+=%<\ %{PencilMode()}                   " 插件
  endif

  set statusline+=%*                                      " 恢复高亮
  set statusline+=%=                                      " 状态栏右边
  set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}
  set statusline+=%4l\ %02c\                              " 行号／列号
  set statusline+=%3p%%\ in\ %-4L                         " 内容长度
endif

" 映射 Enter -> :nohlsearch（仅常规模式）
nnoremap <silent> <CR> :nohlsearch<CR>

" 映射 Option(Alt) + h/j/k/l 在窗口之间跳转
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l

" 映射 Option(Alt) + Shift + h/l 在标签页之间跳转
nnoremap <A-S-h> gT
nnoremap <A-S-l> gt
tnoremap <C-\><C-n><A-S-h> gT
tnoremap <C-\><C-n><A-S-l> gt

" 缩写 :so -> :source % 用于重新加载当前文件
cnoreabbrev <expr> so getcmdtype() == ':' && getcmdline() == 'so' ? 'source %' : 'so'
" 缩写 :ev -> :tabedit PATH/TO/init.vim 用于新开标签页编辑 init.vim 文件
cnoreabbrev <expr> ev getcmdtype() == ':' && getcmdline() == 'ev' ? 'tabedit $MYVIMRC' : 'ev'

" 自动安装插件
if empty(glob('$HOME/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd! VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('$HOME/.config/nvim/plugins')
Plug 'jdkanani/vim-material-theme'                   " Google Material 主题

" investigate.vim 应该是更好的选择，此处仅为备用
" Plug 'thinca/vim-ref'                                " 通用文档查看插件
Plug 'keith/investigate.vim'                         " 多功能文档查看器
let g:investigate_use_dash = 1                       " Mac OS X 下使用 Dash
let g:investigate_dash_for_elixir = 'ex'

" TODO: read deoplete for recommended external plugins
Plug 'Shougo/deoplete.nvim'                          " 异步自动代码补全
let g:deoplete#enable_at_startup = 1                 " 缺省开启自动补全

" NOTE: currently I just don't know how it works...
Plug 'Shougo/neopairs.vim'                           " 自动匹配成对字符

Plug 'Shougo/context_filetype.vim'                   " 依据语境自动切换文档类型

" Elixir
Plug 'elixir-lang/vim-elixir'                        " 语法高亮／缩进
Plug 'awetzel/elixir.nvim'                           " 代码补全／编译运行
let g:elixir_showerror = 1                             " 编译完成提示错误
let g:elixir_autobuild = 0                             " 保存／失焦时自动保存
call plug#end()

set background=dark
colorscheme material-theme

augroup RELOAD_CONFIGURATION
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

augroup TEXT_WRITING
  autocmd!
  autocmd FileType markdown setlocal noexpandtab textwidth=0 colorcolumn=0
augroup END
