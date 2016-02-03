" filetype.vim
"
" 运行于 `filetype on` 之后，用于为那些无法通过文件名辨识文件类型的情况下。
"
" 注意：此文件必须优先加载，所以请不要放置在其他子目录下。并且不会被覆盖。

if exists('g:did_load_custom_filetypes') | finish | endif
let g:did_load_custom_filetypes = 1

augroup CUSTOM_FILETYPES
  autocmd BufRead,BufNewFile,BufFilePre .babelrc  setfiletype json
  autocmd BufRead,BufNewFile,BufFilePre .bowerrc  setfiletype json
  autocmd BufRead,BufNewFile,BufFilePre .eslintrc setfiletype yaml
  autocmd BufRead,BufNewFile,BufFilePre .jscsrc   setfiletype json
  autocmd BufRead,BufNewFile,BufFilePre .jshintrc setfiletype json
augroup END
