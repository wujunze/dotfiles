# 关于 Neovim

[Neovim](https://neovim.io/) 是毋庸置疑的好东西，但凡喜欢 Vim 的开发者都应该换用 Neovim 了。虽说绝大多数 Vim 的配置都能在 Neovim 下即插即用，当还是有一些需要注意或是可以改良的地方。

## 关于配置文件

Vim 的配置文件一般都在 `$HOME/.vimrc` 文件内，而 Neovim 则改为了 `$HOME/.config/nvim/init.vim` 文件。如果你想直接使用原先的 `.vimrc` 文件，则可以创建软链接到 `$home/.config/nvim/init.vim` 去。

## 关于配置选项

值得注意的是，许多 Vim 的配置选项在 Neovim 里都没有必要再定义了，因为 Neovim 尊重大多数人的习惯将它们都缺省设置好了。如果你要知道有哪些事情在 Neovim 里是不需要做的，可以使用命令 `:help vim_diff.txt` 查看细节。

我在本仓库的 [`init.vim`](/nvim/init.vim) 文件内详细注释了每一条设定的意思，当然仅供参考用途，因为这只是我的个人习惯。

## 关于编译时特性

Vim 的一些特性，比如 `+ruby` 等，是需要在编译时指定参数才会有的，但 Neovim 不需要。无论你使用哪种渠道安装 Neovim，它都是包含全部特性的。

然而，Neovim 对于 Python／Python3 的支持需要一些额外的步骤，详情请参考 `:help nvim_python.txt`  文档。记住，这个文档所说的事情最好都照做一遍，因为 Neovim 一些强大的特性需要配置正确的 Python 环境支持，比如下面——

## 关于插件管理

最好的插件管理？[vim-plug](https://github.com/junegunn/vim-plug)！它涵盖了其他各种插件管理所提供的各种功能，并且有着许多迷人的特性，特别是并行安装／更新插件。

vim-plug 对于 Neovim 的支持相当好，但是初始配置项略有差异，由于官网上没有相近说明，所以请务必看清楚本仓库提供的 [`init.vim`](/nvim/init.vim) 文件。

## 关于各种特定语言的特定插件

### Elixir

> Note：我更换了 Elixir 环境下的 vim 配置和插件集合，参见 [nvim/init.vim](nvim/init.vim) 文件的相关内容。新的搭配与下文所述各有千秋，都可以试试。

Vim 下有一些很不错的针对 Elixir 的插件，不过都没有专为 Neovim 开发的 [elixir.nvim](https://github.com/awetzel/elixir.nvim) 好，这货本身就是用 Elixir 开发的！所以想要开发 Vim 插件却苦于没空学习 VimL 或者 Python 的童鞋，你们的福音来了哦。

安装这个插件的过程（可能）会遇到一些麻烦，详情请见 [issue #3](https://github.com/awetzel/elixir.nvim/issues/3)，我在这里详细回答了[我碰到的问题及解决方案](https://github.com/awetzel/elixir.nvim/issues/3#issuecomment-172659714)，虽然没能解决题主的问题，但希望对你有帮助。

请务必细读该插件的文档，否则你不知道它有多好用。另外它推荐的两个插件：`elixir-lang/vim-elixir` 和 `thinca/vim-ref` 也请装上。前者提供代码高亮与缩进，后者提供内置文档预览（通用）。

### JavaScript

#### Neomake 和 ESLint

开启保存时自动 linting 以及输入（和内容改变）时自动 linting 的话，添加以下设置：

	```viml
	augroup JAVASCRIPT
	  autocmd!
	  autocmd BufWritePost *.js Neomake
	  autocmd InsertLeave,TextChanged *.js update | Neomake
	augroup END
	```
