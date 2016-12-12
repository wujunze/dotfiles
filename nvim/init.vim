" 设置 {{{
" 显式设置当前脚本的编码方式以支持多字节字符
scriptencoding utf-8

" 开启 NVIM 专用选项
if has('nvim')
  " 允许真彩显示
  " let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
  set termguicolors
  " 允许光标变化
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
endif

" 设置查找文件时使用的路径
set path=.,$HOME/.local/include,/usr/local/include,/usr/include,,

" 让 ./ 在 'tags' 选项里表示相对于当前路径而不是相对于当前文件
set cpoptions+=d
" set cpoptions+=n

" 插入模式自动补全标签显示更多信息
set showfulltag

" 禁止过长的行回绕（超过屏幕宽度）
set nowrap

" 让水平滚动更加自然
set sidescroll=1
set sidescrolloff=3

" 设置空白字符的视觉提示（eol:¬,nbsp:˽,）
set list listchars=extends:❯,precedes:❮,tab:▸\ ,trail:˽

" 消除碍眼的文字
set shortmess+=I

" 设置行宽的视觉提示
set colorcolumn=0

" 自定义拼写检查
set nospell spelllang=en_us
set spellfile=$HOME/.config/nvim/spell/en.utf-8.add
set spellsuggest=best,5

" 在右边打开新的窗口（垂直分割）
set splitright

" 在下边打开新的窗口（水平分割）
set splitbelow

" 扩大预览窗口的高度
set previewheight=24

" 模式切换（在状态栏左下方）
set noshowmode

" 按键提示（在状态栏右下方）
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
" if has('statusline')
"   set laststatus=2

"   set statusline=%<                                       " 状态栏开始
"   set statusline+=%.40f                                   " 相对路径的当前文件
"   set statusline+=%y                                      " 文件类型
"   set statusline+=[%{&ff}]                                " 文件格式
"   set statusline+=[%{strlen(&fenc)?&fenc:'none'}]         " 文件编码
"   set statusline+=%m                                      " 更改状态
"   set statusline+=%h                                      " 帮助标识
"   set statusline+=%r                                      " 只读标识
"   if exists(':Pencil')
"     set statusline+=%<\ %{PencilMode()}                   " 插件
"   endif

"   set statusline+=%*                                      " 恢复高亮
"   set statusline+=%=                                      " 状态栏右边
"   set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}
"   set statusline+=%4l\ %02c\                              " 行号／列号
"   set statusline+=%3p%%\ in\ %-4L                         " 内容长度
" endif
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
vnoremap * y:let @/=@"<CR>
nnoremap # #N
vnoremap # #N

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

" 映射 Option(Alt) + j/k x3 倍速上下移动
nnoremap <A-j> 3j
nnoremap <A-k> 3k
vnoremap <A-j> 3j
vnoremap <A-k> 3k

" 映射 Option(Alt) + h/l 在标签页之间跳转
nnoremap <A-[> gT
nnoremap <A-]> gt
tnoremap <C-\><C-n><A-h> gT
tnoremap <C-\><C-n><A-l> gt

" 映射更高效的菜单选择
inoremap <expr> <CR>  pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" 开启内置 Terminal 模式
nnoremap <silent> <Leader>: :below 10sp term://$SHELL<CR>A
tnoremap <C-[> <C-\><C-n>

" NERDTree 映射
nnoremap <silent><Leader><F1> :NERDTreeFind<CR>
nnoremap <silent><F1>         :NERDTreeToggle<CR>

" EasyAlign 映射
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" Fugitive 映射
nnoremap <silent><Leader>gb :Gblame<CR>
nnoremap <silent><Leader>gd :Gvdiff<CR>
nnoremap <silent><Leader>gf :Gfetch<CR>
nnoremap <silent><Leader>gp :Gpush<CR>
nnoremap <silent><Leader>gs :Gstatus<CR>
nnoremap <silent><Leader>gv :GV<CR>
nnoremap <silent><Leader>gw :Gwrite<CR>
" }}}

" 缩写 {{{
" 缩写 :so -> :source % 用于重新加载当前文件
cnoreabbrev <expr> so getcmdtype() == ':' && getcmdline() == 'so' ? 'source %' : 'so'
" 缩写 :sw -> :w !sudo tee % 用于获取 Admin 权限写入文件
cnoreabbrev <expr> sw getcmdtype() == ':' && getcmdline() == 'sw' ? 'w !sudo tee %' : 'sw'
" 缩写 :ev -> :tabedit PATH/TO/init.vim 用于新开标签页编辑 init.vim 文件
cnoreabbrev <expr> ev getcmdtype() == ':' && getcmdline() == 'ev' ? 'tabedit $MYVIMRC' : 'ev'
" 缩写 :ue -> :UltiSnipsEdit 用于编辑 UltiSnips
cnoreabbrev <expr> ue getcmdtype() == ':' && getcmdline() == 'ue' ? 'UltiSnipsEdit' : 'ue'
" }}}

" 插件 {{{
if empty(glob('$HOME/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd! VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('$HOME/.config/nvim/plugins')
" Plug 'dracula/vim'                                   " 暗色伯爵主题
Plug 'jdkanani/vim-material-theme'                   " Google Material 主题
" Plug 'mkarmona/materialbox'                          " 配套浅色主题

Plug 'rking/ag.vim'                                  " the_silver_searcher
let g:ag_working_path_mode="r"

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
let g:ctrlp_line_prefix         = ' 🎐 '
let g:ctrlp_match_window        = 'bottom,order:btt,min:1,max:30'
let g:ctrlp_mruf_exclude        = '\.git/\*\|\.txt\|\.vimrc'
let g:ctrlp_switch_buffer       = 'EtVH'
let g:ctrlp_tabpage_position    = 'al'
let g:ctrlp_working_path_mode   = 'rw'
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_open_multiple_files = '2tjr'

" NOTE: 尽量不要依赖这种以视觉查找为主的插件，效率杀手！
"       我一般在向别人讲解项目结构或者可视化的演示使用
Plug 'scrooloose/nerdtree'                           " 树形文件查看插件
let NERDTreeIgnore                    = ['.sass-cache$', 'tmp$']
let NERDTreeSortOrder                 = ['\/$', '*']
let NERDTreeWinPos                    = 'left'
let NERDTreeWinSize                   = 30
let NERDTreeChDirMode                 = 2
let NERDTreeDirArrows                 = 1
let NERDTreeMinimalUI                 = 1
let NERDTreeMouseMode                 = 2
let NERDTreeShowHidden                = 0
let NERDTreeQuitOnOpen                = 0
let NERDTreeHijackNetrw               = 1
let NERDTreeSortHiddenFirst           = 1
let NERDTreeAutoDeleteBuffer          = 1
let NERDTreeCaseSensitiveSort         = 1
let NERDTreeHighlightCursorline       = 1
let NERDTreeDirArrowExpandable        = '▸'
let NERDTreeDirArrowCollapsible       = '▾'
let NERDTreeCascadeSingleChildDir     = 0
let NERDTreeCascadeOpenSingleChildDir = 1

Plug 'rbgrouleff/bclose.vim'
Plug 'francoiscabrol/ranger.vim'                     " 整合 Ranger

Plug 'AndrewRadev/splitjoin.vim'                     " 智能分行或连接行
Plug 'HeroicEric/vim-tabline'                        " 显示更友好的文件名
Plug 'itchyny/lightline.vim'                         " 轻量级状态栏优化插件
let g:lightline = {
      \   'colorscheme': 'wombat',
      \   'active': {
      \     'left': [ ['mode', 'paste'],
      \               ['readonly', 'filename', 'modified', 'fugitive'] ]
      \   },
      \   'component': {
      \     'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \   },
      \   'component_visible_condition': {
      \     'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \   }
      \ }

" TODO: READ DEOPLETE FOR RECOMMENDED EXTERNAL PLUGINS
" deoplete init for vim-plug
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
" 异步自动代码补全
Plug 'Shougo/deoplete.nvim', {'do': function('DoRemote')}
let g:deoplete#enable_at_startup = 1                 " 缺省开启自动补全
" <CR> 直接换行而不执行 deoplete 的默认行为
inoremap <silent> <CR> <C-r>=<SID>return_without_deoplete()<CR>
function! s:return_without_deoplete() abort
  return deoplete#mappings#close_popup() . "\<CR>"
endfunction
Plug 'Konfekt/FastFold'                              " 削减代码折叠对性能的影响
Plug 'Shougo/context_filetype.vim'                   " 提供插件切换文档类型能力

Plug 'benekastah/neomake'
let g:neomake_error_sign   = {'text': '😡 '}
let g:neomake_warning_sign = {'text': '😠 '}

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'  " 智能代码片断工具
Plug 'SirVer/ultisnips'                              " 智能代码片断工具
let g:UltiSnipsSnippetsDir         = $HOME.'/.config/nvim/UltiSnips'
let g:UltiSnipsExpandTrigger       = '<TAB>'
let g:UltiSnipsListSnippets        = '<A-TAB>'
let g:UltiSnipsJumpForwardTrigger  = '<TAB>'
let g:UltiSnipsJumpBackwardTrigger = '<S-TAB>'
let g:UltiSnipsMappingsToIgnore    = ["deoplete"]

Plug 'editorconfig/editorconfig-vim'                 " Editor Config 配置插件
let g:EditorConfig_exec_path        = '/usr/local/bin/editorconfig'
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" Git 整合
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

" Plug 'junegunn/vim-peekaboo'                         " 预览注册器的内容

" TODO: RTFM 😹
Plug 'junegunn/vim-easy-align'                       " 强悍又简约的智能对齐
Plug 'easymotion/vim-easymotion'                     " 快速跳转

Plug 'chrisbra/unicode.vim'                          " 增强 Unicode 的使用

Plug 'tpope/vim-repeat'                              " 扩展重复命令的应用范围
Plug 'tpope/vim-surround'                            " 增强各种成对字符的操作
Plug 'tpope/vim-commentary'                          " 提供简单的快捷注释功能
Plug 'tpope/vim-unimpaired'                          " 补充成对操作的键位映射

Plug 'kana/vim-textobj-user'                         " 允许用户定义文本对象
Plug 'reedes/vim-pencil'                             " 文本写作辅助工具
Plug 'reedes/vim-textobj-quote'                      " 支持排版格式引号字符
Plug 'reedes/vim-textobj-sentence'                   " 支持更自然的句子对象
Plug 'junegunn/goyo.vim'                             " 提供免干扰的写作环境
Plug 'junegunn/limelight.vim'                        " 配合 Goyo 提供行聚焦

" Markdown
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
let g:vim_markdown_toc_autofit      = 1
let g:vim_markdown_frontmatter      = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_folding_disabled = 1

" XML
Plug 'othree/xml.vim', {'for': ['html', 'xml']}

" HTML
Plug 'othree/html5.vim', {'for': ['html', 'xml']}

" Handlebars
Plug 'mustache/vim-mustache-handlebars'
let g:mustache_abbreviations = 1                     " 内置缩写展开
Plug 'joukevandermaas/vim-ember-hbs'
Plug 'dustinfarris/vim-htmlbars-inline-syntax'       " 行内 Handlebars 语法

" CSS
Plug 'JulesWang/css.vim', {'for': ['css', 'less', 'scss']}
Plug 'hail2u/vim-css3-syntax', {'for': ['css', 'less', 'scss']}
Plug 'othree/csscomplete.vim', {'for': ['css', 'less', 'scss']}
Plug 'genoma/vim-less', {'for': 'less'}
Plug 'cakebaker/scss-syntax.vim', {'for': 'scss'}
Plug 'stephenway/postcss.vim', {'for': 'css'}

" JavaScript
Plug 'pangloss/vim-javascript', {'for': ['javascript', 'javascript.jsx']}
let g:javascript_enable_domhtmlcss    = 1
let g:javascript_ignore_javaScriptdoc = 1
" let g:javascript_conceal_function       = "𝛌"
" let g:javascript_conceal_null           = "𝛈"
" let g:javascript_conceal_this           = "𝛎"
" let g:javascript_conceal_return         = "𝛇"
" let g:javascript_conceal_undefined      = "𝛘"
" let g:javascript_conceal_NaN            = "𝛆"
" let g:javascript_conceal_prototype      = "𝛕"
" let g:javascript_conceal_static         = "𝛓"
" let g:javascript_conceal_super          = "𝛍"
" let g:javascript_conceal_arrow_function = "⇒"
Plug 'jason0x43/vim-js-indent', {'for': ['javascript', 'javascript.jsx', 'typescript']}
Plug 'othree/jsdoc-syntax.vim', {'for': ['javascript', 'javascript.jsx']}
Plug '1995eaton/vim-better-javascript-completion', {'for': ['javascript', 'javascript.jsx']}
let g:vimjs#chromeapis    = 1
let g:vimjs#smartcomplete = 1

" JSX
Plug 'mxw/vim-jsx', {'for': 'javascript.jsx'}

" JSON
Plug 'elzr/vim-json', {'for': 'json'}

" TypeScript
Plug 'Quramy/tsuquyomi', {'for': 'typescript'}
Plug 'leafgarland/typescript-vim', {'for': 'typescript'}

" TOML
Plug 'cespare/vim-toml', {'for': 'toml'}

" Elixir
Plug 'elixir-lang/vim-elixir', {'for': ['elixir', 'eelixir']}
Plug 'slashmili/alchemist.vim', {'for': ['elixir', 'eelixir']}
Plug 'powerman/vim-plugin-AnsiEsc'                   " 处理 ansi escape sequences

" Docker
Plug 'ekalinin/Dockerfile.vim', {'for': 'docker'}

" SQL
Plug 'shmup/vim-sql-syntax', {'for': 'sql'}

call plug#end()
" }}}

" 主题 {{{
set background=dark
colorscheme material-theme

" TODO: 设置内置终端的颜色
let g:terminal_color_0  = '#282a36'
let g:terminal_color_1  = '#ff5555'
let g:terminal_color_2  = '#50fa7b'
let g:terminal_color_3  = '#f1fa8c'
let g:terminal_color_4  = '#bd93f9'
let g:terminal_color_5  = '#ff79c6'
let g:terminal_color_6  = '#8be9fd'
let g:terminal_color_7  = '#50fa7b'
let g:terminal_color_8  = '#555753'
let g:terminal_color_9  = '#ef2929'
let g:terminal_color_10 = '#8ae234'
let g:terminal_color_11 = '#fce94f'
let g:terminal_color_12 = '#729fcf'
let g:terminal_color_13 = '#ad7fa8'
let g:terminal_color_14 = '#00f5e9'
let g:terminal_color_15 = '#eeeeec'
" }}}

" 自动命令 {{{
augroup NVIM_SETTINGS
  autocmd!
  autocmd FileType conf,vim setlocal foldmethod=marker
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

augroup MARKUP_LANGUAGE
  autocmd!
  autocmd User GoyoEnter Limelight
  autocmd User GoyoLeave Limelight!
  autocmd FileType markdown setlocal conceallevel=2 formatoptions+=aM spell
        \                 | call pencil#init({'wrap': 'soft', 'textwidth': 72})
        \                 | call textobj#quote#init()
        \                 | call textobj#sentence#init()
        \                 | setlocal nolinebreak
  autocmd FileType html,html.handlebars setlocal textwidth=0
augroup END

augroup STYLESHEET
  autocmd!
  autocmd FileType css setlocal filetype=less
  autocmd FileType css,less,scss setlocal colorcolumn=80 iskeyword+=-
augroup END

augroup JAVASCRIPT
  autocmd!
  autocmd FileType javascript,javascript.jsx setlocal colorcolumn=80 conceallevel=2 iskeyword+=$
augroup END

augroup ELIXIR
  autocmd!
  autocmd FileType elixir setlocal colorcolumn=80 foldmethod=syntax foldlevel=1 foldnestmax=2
augroup END

augroup OMNIFUNCS
  autocmd!
  autocmd FileType css             setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType scss            setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html            setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType html.handlebars setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript      setlocal omnifunc=js#CompleteJS
  autocmd FileType javascript.jsx  setlocal omnifunc=js#CompleteJS
  autocmd FileType ruby            setlocal omnifunc=rubycomplete#Complete
  autocmd FileType xml             setlocal omnifunc=xmlcomplete#CompleteTags
augroup END

augroup CUSTOM_HIGHLIGHT
  autocmd!
  autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO:\s\|NOTE:\s\|FIXME:\s\|ISSUE:\s\|REVIEW:\s', -1)
augroup END

augroup MISC
  autocmd!
  " 总是在新标签页打开帮助文档，见：HelpInNewTab()
  autocmd FileType help call HelpInNewTab()

  " 插入模式下切换只当前文件路径以便自动路径补全
  autocmd InsertEnter * let saved_cwd = getcwd() | set autochdir
  autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(saved_cwd)

  " 保存时自动创建不存在的目录
  autocmd BufWritePre,FileWritePre * call <SID>mkdir_on_save()
augroup END
" }}}

" 辅助函数 {{{
" 使用新的 Tab 打开帮助文档
function! HelpInNewTab()
  if &buftype == 'help' | execute "silent normal \<C-w>T" | endif
endfunction

" 保存时创建不存在的目录
function! <SID>mkdir_on_save()
  let s:directory = expand('<afile>:p:h')
  if !isdirectory(s:directory)
    call mkdir(s:directory, 'p')
  endif
endfunction
" }}}
