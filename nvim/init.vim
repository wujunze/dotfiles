" 设置 {{{
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
set colorcolumn=0

" 自定义拼写检查
set nospell spelllang=en_us
set spellsuggest=best,5

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
set omnifunc=syntaxcomplete#Complete
set complete=.,w,b,u,U,d,t
set completeopt=longest,menuone,preview
set completefunc=syntaxcomplete#Complete

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

" 允许保存 undo 状态
set undofile

" 允许在未保存时切换 buffers
set hidden
" }}}

" 状态栏 {{{
" 自定义状态栏配置
if has('statusline')
  set laststatus=2

  set statusline=%<                                       " 状态栏开始
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
" }}}

" 映射 {{{
" 映射 leader 和 localleader
nnoremap <SPACE> <nop>
let mapleader = "\<SPACE>"
let maplocalleader = "\\"

" 完善有缺陷的默认映射
nnoremap Y y$
nnoremap 0 g0
vnoremap 0 g0
nnoremap ^ g^
vnoremap ^ g^
nnoremap $ g$
vnoremap $ g$
nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk
nnoremap * *N
nnoremap # #N

" 映射一些个人偏好（可选）
inoremap <C-f> <C-o>a
inoremap <C-b> <Esc>i

" 映射 Enter -> :nohlsearch（仅常规模式）
nnoremap <silent> <CR> :nohlsearch<CR>

" 映射 Control(Ctrl) + h/j/k/l 在窗口之间跳转
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" 映射 Option(Alt) + h/l 在标签页之间跳转
nnoremap <A-h> gT
nnoremap <A-l> gt
tnoremap <C-\><C-n><A-h> gT
tnoremap <C-\><C-n><A-l> gt

" 映射更高效的菜单选择
inoremap <expr> <CR>  pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
" }}}

" 缩写 {{{
" 缩写 :so -> :source % 用于重新加载当前文件
cnoreabbrev <expr> so getcmdtype() == ':' && getcmdline() == 'so' ? 'source %' : 'so'
" 缩写 :ev -> :tabedit PATH/TO/init.vim 用于新开标签页编辑 init.vim 文件
cnoreabbrev <expr> ev getcmdtype() == ':' && getcmdline() == 'ev' ? 'tabedit $MYVIMRC' : 'ev'
" 缩写 :ww -> :w !sudo tee % 用于获取 Admin 权限写入文件
cnoreabbrev <expr> ww getcmdtype() == ':' && getcmdline() == 'ww' ? 'w !sudo tee %' : 'ww'
" }}}

" 插件 {{{
if empty(glob('$HOME/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd! VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('$HOME/.config/nvim/plugins')
Plug 'jdkanani/vim-material-theme'                   " Google Material 主题
Plug 'mkarmona/materialbox'                          " 配套浅色主题

Plug 'ctrlpvim/ctrlp.vim'                            " 多功能模糊搜索器
Plug 'sgur/ctrlp-extensions.vim'                     " 扩展集合包
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -g "" --nocolor --nogroup --follow --hidden --smart-case'
else
  let g:ctrlp_user_command = 'cd %s && git ls-files --exclude-standard --others | sort'
endif
let g:ctrlp_cmd = 'exe "CtrlP".get(["", "Buffer", "BookmarkDir", "Cmdline", "Menu", "Yankring"], v:count)'
let g:ctrlp_extensions = ['bookmarkdir', 'changes', 'cmdline', 'menu', 'mixed', 'rtscript', 'yankring']
let g:ctrlp_arg_map             = 1
let g:ctrlp_match_window        = 'bottom,order:btt,min:1,max:30'
let g:ctrlp_mruf_exclude        = '\.git/\*\|\.txt\|\.vimrc'
let g:ctrlp_switch_buffer       = 'EtVH'
let g:ctrlp_tabpage_position    = 'al'
let g:ctrlp_working_path_mode   = 'rw'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_open_multiple_files = '2tjr'

" NOTE: 尽量不要依赖这种以视觉查找为主的插件，效率杀手！
"       我一般在向别人讲解项目结构或者可视化的演示使用
Plug 'scrooloose/nerdtree'                           " 树形文件查看插件
let NERDTreeIgnore              = ['.sass-cache$', 'tmp$']
let NERDTreeSortOrder           = ['\/$', '*']
let NERDTreeWinPos              = 'left'
let NERDTreeWinSize             = 30
let NERDTreeChDirMode           = 2
let NERDTreeDirArrows           = 1
let NERDTreeMinimalUI           = 1
let NERDTreeMouseMode           = 2
let NERDTreeShowHidden          = 0
let NERDTreeQuitOnOpen          = 1
let NERDTreeHijackNetrw         = 1
let NERDTreeSortHiddenFirst     = 1
let NERDTreeAutoDeleteBuffer    = 1
let NERDTreeCaseSensitiveSort   = 1
let NERDTreeHighlightCursorline = 1
nnoremap <F1>         :NERDTreeToggle<CR>
nnoremap <Leader><F1> :NERDTreeFind<CR>
Plug 'Xuyuanp/nerdtree-git-plugin'                   " 为 NERDTree 添加 Git 状态

" TODO: LEARN HOW TO CUSTOMIZE THIS
Plug 'tpope/vim-repeat'                              " 扩展重复命令的应用范围
Plug 'tpope/vim-surround'                            " 增强各种成对字符的操作
Plug 'tpope/vim-commentary'                          " 提供简单的快捷注释功能
Plug 'tpope/vim-unimpaired'                          " 补充成对操作的键位映射

Plug 'kana/vim-textobj-user'                         " 允许用户定义文本对象
Plug 'reedes/vim-pencil'                             " 文本写作辅助工具
Plug 'reedes/vim-textobj-quote'                      " 支持排版格式引号字符
Plug 'reedes/vim-textobj-sentence'                   " 支持更自然的句子对象
Plug 'junegunn/goyo.vim'                             " 提供免干扰的写作环境
" NOTE: Don't know why not works in terminal
" Plug 'junegunn/limelight.vim'                        " 提供当前行／段高对比
" let g:limelight_conceal_ctermfg = 'gray'
" let g:limelight_conceal_ctermfg = 240
" let g:limelight_conceal_guifg   = 'DarkGray'
" let g:limelight_conceal_guifg   = '#777777'

" investigate.vim 应该是更好的选择，此处仅为备用
" Plug 'thinca/vim-ref'                                " 通用文档查看插件

Plug 'keith/investigate.vim'                         " 多功能文档查看器
let g:investigate_use_dash        = 1                " Mac OS X 下使用 Dash
let g:investigate_dash_for_elixir = 'ex'

" TODO: READ DEOPLETE FOR RECOMMENDED EXTERNAL PLUGINS
Plug 'Shougo/deoplete.nvim'                          " 异步自动代码补全
let g:deoplete#enable_at_startup = 1                 " 缺省开启自动补全

Plug 'SirVer/ultisnips'                              " 智能代码片断工具
let g:UltiSnipsSnippetsDir         = $HOME.'/.config/nvim/UltiSnips'
let g:UltiSnipsExpandTrigger       = '<TAB>'
let g:UltiSnipsListSnippets        = '<C-TAB>'
let g:UltiSnipsJumpForwardTrigger  = '<TAB>'
let g:UltiSnipsJumpBackwardTrigger = '<S-TAB>'
let g:UltiSnipsMappingsToIgnore    = ["deoplete"]

" NOTE: currently I just don't know how it works...
Plug 'Shougo/neopairs.vim'                           " 自动匹配成对字符

Plug 'Shougo/context_filetype.vim'                   " 依据语境自动切换文档类型

" TODO: RTFM 😹
Plug 'junegunn/vim-easy-align'                       " 强悍又简约的智能对齐
nmap <Leader>a <Plug>(EasyAlign)
vmap <CR>      <Plug>(EasyAlign)

" TODO: FURTHER INVESTIGATION NEEDED
Plug 'benekastah/neomake'                            " 异步语法检查工具
let g:neomake_error_sign   = {'text': '❌ '}
let g:neomake_warning_sign = {'text': '🚫 '}

" XML
Plug 'othree/xml.vim'

" HTML
Plug 'othree/html5.vim', {'for': ['html', 'html.handlebars']}

" Handlebars
Plug 'mustache/vim-mustache-handlebars', {'for': ['html', 'html.handlebars']}
let g:mustache_abbreviations = 1                     " 内置缩写展开

" Pug (formly known as Jade)
Plug 'digitaltoad/vim-pug'

" CSS
Plug 'hail2u/vim-css3-syntax', {'for': ['css', 'scss']}
Plug 'cakebaker/scss-syntax.vim', {'for': 'scss'}    " Sass 语法增强

" JavaScript
Plug 'othree/yajs.vim', {'for': ['javascript', 'javascript.jsx']}
Plug 'pangloss/vim-javascript', {'for': ['javascript', 'javascript.jsx']}
Plug 'jason0x43/vim-js-indent', {'for': ['javascript', 'javascript.jsx']}
let g:js_indent_typescript  = 1                      " 同时用于 TypeScript
let g:js_indent_flat_switch = 0                      " 展平 switch 结构
Plug 'othree/es.next.syntax.vim', {'for': ['javascript', 'javascript.jsx']}
Plug 'grvcoelho/vim-javascript-snippets', {'for': ['javascript', 'javascript.jsx']}
" NOTE: I'm hold these two below for future candidates
" Plug 'gavocanov/vim-js-indent'

" JSON
Plug 'elzr/vim-json', {'for': 'json'}

" React JSX
Plug 'mxw/vim-jsx', {'for': 'javascript.jsx'}        " React JSX 语法高亮

" Elixir
Plug 'elixir-lang/vim-elixir', {'for': 'elixir'}     " 语法高亮／缩进
Plug 'awetzel/elixir.nvim', {'for': 'elixir'}        " 代码补全／编译运行
let g:elixir_showerror = 1                           " 编译完成提示错误
let g:elixir_autobuild = 0                           " 保存／失焦时自动保存
call plug#end()
" }}}

" 主题 {{{
set background=dark
colorscheme material-theme
" }}}

" 自动命令 {{{
augroup NVIM_SETTINGS
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
  autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup MARKUP_LANGUAGE
  autocmd!
  " autocmd User GoyoEnter Limelight
  " autocmd User GoyoLeave Limelight!
  autocmd FileType markdown setlocal textwidth=72
        \                 | call pencil#init({'wrap': 'soft', 'textwidth': 72})
        \                 | call textobj#quote#init()
        \                 | call textobj#sentence#init()
  autocmd FileType html,html.handlebars setlocal textwidth=0 foldmethod=indent
augroup END

augroup STYLESHEET
  autocmd!
  autocmd FileType css,scss setlocal colorcolumn=80 iskeyword+=- foldmethod=syntax
augroup END

augroup JAVASCRIPT
  autocmd!
  autocmd BufWritePost *.js,*.jsx Neomake
  " NOTE: currently there's a bug on TextChanged event
  " autocmd InsertLeave,TextChanged *.js update | Neomake
  " autocmd InsertLeave *.js update | Neomake
  autocmd FileType javascript,javascript.jsx setlocal iskeyword+=$
        \                                             colorcolumn=80
        \                                             foldmethod=syntax
augroup END

augroup OMNIFUNCS
  autocmd!
  autocmd FileType css             setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html            setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType html.handlebars setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript      setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType ruby            setlocal omnifunc=rubycomplete#Complete
  autocmd FileType xml             setlocal omnifunc=xmlcomplete#CompleteTags
augroup END

augroup CUSTOM_HIGHLIGHT
  autocmd!
  autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO\|NOTE\|FIXME', -1)
augroup END

augroup MISC
  autocmd!
  autocmd FileType conf setlocal foldmethod=marker
augroup END
" }}}
