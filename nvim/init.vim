cnoreabbrev <expr> ev getcmdtype() == ":" && getcmdline() == "ev" ? "edit ~/.config/nvim/init.vim" : "ev"

if has("nvim")
  :let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
  :let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
endif

" NOT AVAILABLE IN NEOVIM
"
" 自定光标形状（常规模式呈块状不闪烁，插入模式呈线状闪烁）
" 相关插件：http://github.com/sjl/vitality.vim
" 相关插件：https://github.com/jszakmeister/vim-togglecursor
" http://ass.kameli.org/cursor_tricks.html 获取更多相关信息
" if &term =~ "xterm"
"   if exists('$TMUX')
"     let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"     let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
"   else
"     let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"     let &t_EI = "\<Esc>]50;CursorShape=0\x7"
"   endif
" endif
