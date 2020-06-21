"======================================================================
"
" init-plugins.vim -
"
" Created by skywind on 2018/05/31
" Last Modified: 2018/06/10 23:11
"
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :



"----------------------------------------------------------------------
" 默认情况下的分组，可以再前面覆盖之
"----------------------------------------------------------------------
if !exists('g:bundle_group')
	let g:bundle_group = ['basic', 'tags', 'extra', 'filetypes', 'textobj']
	let g:bundle_group += ['airline', 'ale', 'git', 'asynctasks', 'asyncomplete']
	let g:bundle_group += ['fuzzy', 'colors', 'format']
endif


"----------------------------------------------------------------------
" 计算当前 vim-init 的子路径
"----------------------------------------------------------------------
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')

function! s:path(path)
	let path = expand(s:home . '/' . a:path )
	return substitute(path, '\\', '/', 'g')
endfunc


"----------------------------------------------------------------------
" 在 ~/.vim/bundles 下安装插件
"----------------------------------------------------------------------
call plug#begin(get(g:, 'bundle_home', expand(s:home . '/../plugged')))

"----------------------------------------------------------------------
" 基础插件 basic
"----------------------------------------------------------------------
if index(g:bundle_group, 'basic') >= 0

	Plug 'yianwillis/vimcdoc'
	
	" 额外的按键映射
	Plug 'tpope/vim-unimpaired'

	" 快速移动
	Plug 'easymotion/vim-easymotion'
	let g:EasyMotion_do_mapping = 0
	let g:EasyMotion_smartcase = 1
	let g:EasyMotion_use_smartsign_us = 1 " US layout
	"let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
	map <leader>as <Plug>(easymotion-s)
	map <Leader>aa <Plug>(easymotion-overwin-w)
	map <Leader>a. <Plug>(easymotion-repeat)
	map <Leader>al <Plug>(easymotion-bd-w)
	map <leader>a/ <Plug>(easymotion-sn)

	" 注释
	Plug 'tpope/vim-commentary'

	" 支持库，给其他插件用的函数库
	Plug 'xolox/vim-misc'

	" 用于在侧边符号栏显示 marks （ma-mz 记录的位置）
	Plug 'kshenoy/vim-signature'

	" 配对括号和引号自动补全
	Plug 'Raimondi/delimitMate'

	" surround 加减括号/引号/标签
	Plug 'tpope/vim-surround'

	" 调整窗口
	Plug 'dstein64/vim-win'
	let g:win_resize_height = 2
	let g:win_resize_width = 4
	let g:win_disable_version_warning = 1
	let g:win_ext_command_map = {
		\   'c': 'wincmd c',
		\   'C': 'close!',
		\   'w': 'write',
		\   'W': 'write!',
		\   'q': 'quit',
		\   'Q': 'quit!',
		\   '!': 'qall!',
		\   'v': 'wincmd v',
		\   's': 'wincmd s',
		\   'n': 'bnext',
		\   'N': 'bnext!',
		\   'p': 'bprevious',
		\   'P': 'bprevious!',
		\   "\<c-n>": 'tabnext',
		\   "\<c-p>": 'tabprevious',
		\   '=': 'wincmd =',
		\   't': 'tabnew',
		\   'x': 'Win#exit'
		\ }

endif


"----------------------------------------------------------------------
" 增强插件 extra
"----------------------------------------------------------------------
if index(g:bundle_group, 'extra') >= 0

	" 展示开始画面，显示最近编辑过的文件
	Plug 'mhinz/vim-startify'
	let g:startify_disable_at_vimenter = 0

	" 单词下划线
	Plug 'itchyny/vim-cursorword'

	" virtualenv
	Plug 'jmcantrell/vim-virtualenv', { 'on': ['VirtualEnvList', 'VirtualEnvActivate'] }

	" 给不同语言提供字典补全，插入模式下 c-x c-k 触发
	Plug 'asins/vim-dict'

	" 彩色单词
	Plug 'jaxbot/semantic-highlight.vim'
	nnoremap <m-S> :SemanticHighlightToggle<cr>
	inoremap <m-S> <c-o>:SemanticHighlightToggle<cr>

	Plug 'cocopon/vaffle.vim'
	Plug 'preservim/nerdtree'
	" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	let g:NERDTreeMinimalUI = 1
	let g:NERDTreeDirArrows = 1
	let g:NERDTreeHijackNetrw = 0
	map <C-n> :NERDTreeToggle<CR>
	" Plug 'lambdalisue/fern.vim'

	" 文件浏览器，代替 netrw
	" Plug 'justinmk/vim-dirvish'
	"----------------------------------------------------------------------
	" Dirvish 设置：自动排序并隐藏文件，同时定位到相关文件
	" 这个排序函数可以将目录排在前面，文件排在后面，并且按照字母顺序排序
	" 比默认的纯按照字母排序更友好点。
	"----------------------------------------------------------------------
	" function! s:setup_dirvish()
	"	if &buftype != 'nofile' && &filetype != 'dirvish'
	"		return
	"	endif
	"	if has('nvim')
	"		return
	"	endif
	"	" 取得光标所在行的文本（当前选中的文件名）
	"	let text = getline('.')
	"	if ! get(g:, 'dirvish_hide_visible', 0)
	"		exec 'silent keeppatterns g@\v[\/]\.[^\/]+[\/]?$@d _'
	"	endif
	"	" 排序文件名
	"	exec 'sort ,^.*[\/],'
	"	let name = '^' . escape(text, '.*[]~\') . '[/*|@=|\\*]\=\%($\|\s\+\)'
	"	" 定位到之前光标处的文件
	"	call search(name, 'wc')
	"	noremap <silent><buffer> ~ :Dirvish ~<cr>
	"	noremap <buffer> % :e %
	" endfunc

	" augroup MyPluginSetup
	"	autocmd!
	"	autocmd FileType dirvish call s:setup_dirvish()
	" augroup END

	" Diff 增强，支持 histogram / patience 等更科学的 diff 算法
	Plug 'chrisbra/vim-diff-enhanced'

	Plug 'vim/killersheep'
endif


"----------------------------------------------------------------------
" 自动生成 ctags/gtags，并提供自动索引功能
" 不在 git/svn 内的项目，需要在项目根目录 touch 一个空的 .root 文件
" 详细用法见：https://zhuanlan.zhihu.com/p/36279445
"----------------------------------------------------------------------
if index(g:bundle_group, 'tags') >= 0

	" 提供 ctags/gtags 后台数据库自动更新功能
	Plug 'ludovicchabant/vim-gutentags'
	" 提供 GscopeFind 命令并自动处理好 gtags 数据库切换
	Plug 'skywind3000/gutentags_plus'
	noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr>
	noremap <silent> <leader>gg :GscopeFind g <C-R><C-W><cr>
	noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>
	noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
	noremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>
	noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
	noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
	noremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>
	noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>
	noremap <silent> <leader>gz :GscopeFind z <C-R><C-W><cr>
	" 设定项目目录标志：除了 .git/.svn 外，还有 .root 文件
	let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project', '.vscode']
	let g:gutentags_ctags_tagfile = '.tags'
	" 默认生成的数据文件集中到 ~/.cache/tags 避免污染项目目录，好清理
	let g:gutentags_cache_dir = expand('~/.cache/tags')
	" 默认禁用自动生成
	let g:gutentags_modules = []
	" 如果有 ctags 可执行就允许动态生成 ctags 文件
	if executable('ctags')
		let g:gutentags_modules += ['ctags']
	endif
	" 如果有 gtags 可执行就允许动态生成 gtags 数据库
	if executable('gtags') && executable('gtags-cscope')
		let g:gutentags_modules += ['gtags_cscope']
	endif
	" 设置 ctags 的参数
	let g:gutentags_ctags_extra_args = []
	let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
	let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
	let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
	" 使用 universal-ctags 的话需要下面这行，请反注释
	" let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
	" 禁止 gutentags 自动链接 gtags 数据库
	let g:gutentags_auto_add_gtags_cscope = 0
	" change focus to quickfix window after search (optional).
	let g:gutentags_plus_switch = 1

endif


"----------------------------------------------------------------------
" 文本对象 textobj
"----------------------------------------------------------------------
if index(g:bundle_group, 'textobj') >= 0

	" 基础插件：提供让用户方便的自定义文本对象的接口
	Plug 'kana/vim-textobj-user'

	" 一行 l
	Plug 'kana/vim-textobj-line'

	" args 函数参数 a
	Plug 'vim-scripts/argtextobj.vim'

	" indent 缩进 i
	Plug 'kana/vim-textobj-indent'

	" syntax 语法文本对象 y
	Plug 'kana/vim-textobj-syntax'

	" function 函数文本对象 f 支持 c/c++/vim/java
	Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }
	Plug 'haya14busa/vim-textobj-function-syntax', { 'for':['c', 'cpp', 'vim', 'java'] }

	" parameter 参数文本对象 , 包括参数或者列表元素
	Plug 'sgur/vim-textobj-parameter'

	" python 相关文本对象 f表示函数, c表示类
	Plug 'bps/vim-textobj-python', {'for': 'python'}

	" 提供 uri/url 的文本对象 u
	Plug 'jceb/vim-textobj-uri'

	" ruby块  r
	Plug 'rhysd/vim-textobj-ruby', {'for': 'ruby'}

endif


"----------------------------------------------------------------------
" 文件类型扩展 filetypes
"----------------------------------------------------------------------
if index(g:bundle_group, 'filetypes') >= 0

	" 扩展包
	Plug 'sheerun/vim-polyglot'

	" 额外语法文件
	Plug 'justinmk/vim-syntax-extra', { 'for': ['c', 'bison', 'flex', 'cpp'] }

	" vim org-mode
	Plug 'jceb/vim-orgmode', { 'for': 'org' }

	" txt
	Plug 'vim-scripts/txt.vim'

endif


"----------------------------------------------------------------------
" airline
"----------------------------------------------------------------------
if index(g:bundle_group, 'airline') >= 0

	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	let g:airline_left_sep = ''
	let g:airline_left_alt_sep = ''
	let g:airline_right_sep = ''
	let g:airline_right_alt_sep = ''
	let g:airline_powerline_fonts = 0
	let g:airline_exclude_preview = 1
	let g:airline_section_b = '%n'
	let g:airline_theme='deus'
	let g:airline#extensions#branch#enabled = 0
	let g:airline#extensions#syntastic#enabled = 0
	let g:airline#extensions#fugitiveline#enabled = 0
	let g:airline#extensions#csv#enabled = 0
	let g:airline#extensions#vimagit#enabled = 0
	let g:airline#extensions#tabline#enabled = 1
	set updatetime=300

endif


"----------------------------------------------------------------------
" colors
"----------------------------------------------------------------------
if index(g:bundle_group, 'colors') >= 0

	Plug 'joshdick/onedark.vim'
	let g:onedark_termcolors=256
	Plug 'NLKNguyen/papercolor-theme'

endif


"----------------------------------------------------------------------
" 格式化 format
"----------------------------------------------------------------------
if index(g:bundle_group, 'format') >= 0

	" 表格对齐，使用命令 Tabularize
	Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

	" 手动格式化
	Plug 'Chiel92/vim-autoformat'
	"let g:autoformat_autoindent = 0
	"let g:autoformat_retab = 0
	"let g:autoformat_remove_trailing_spaces = 0
	""au BufWrite * :Autoformat
	nnoremap <m-F> :Autoformat<cr>
	inoremap <m-F> <c-o>:Autoformat<cr>
	nnoremap Æ <c-o>:Autoformat<cr>
	"let g:autoformat_verbosemode=1

	Plug 'rbtnn/vim-vimscript_formatter'
	let g:vimscript_formatter_replace_indentexpr = 1

endif


"----------------------------------------------------------------------
" ale：动态语法检查
"----------------------------------------------------------------------
if index(g:bundle_group, 'ale') >= 0

	Plug 'dense-analysis/ale'
	" 设定延迟和提示信息
	let g:ale_completion_delay = 500
	let g:ale_echo_delay = 20
	let g:ale_lint_delay = 500
	let g:ale_echo_msg_format = '[%linter%] %code: %%s'
	" 设定检测的时机：normal 模式文字改变，或者离开 insert模式
	" 禁用默认 INSERT 模式下改变文字也触发的设置，太频繁外，还会让补全窗闪烁
	let g:ale_lint_on_text_changed = 'normal'
	let g:ale_lint_on_insert_leave = 1
	" 在 linux/mac 下降低语法检查程序的进程优先级（不要卡到前台进程）
	if has('win32') == 0 && has('win64') == 0 && has('win32unix') == 0
		let g:ale_command_wrapper = 'nice -n5'
	endif
	" 允许 airline 集成
	let g:airline#extensions#ale#enabled = 1
	" 编辑不同文件类型需要的语法检查器
	let g:ale_linters = {
		\ 'c': ['gcc', 'cppcheck'],
		\ 'cpp': ['gcc', 'cppcheck'],
		\ 'python': ['flake8', 'pylint'],
		\ 'lua': ['luac'],
		\ 'go': ['go build', 'gofmt'],
		\ 'java': ['javac'],
		\ 'javascript': ['eslint'],
		\ }
	" 获取 pylint, flake8 的配置文件，在 vim-init/tools/conf 下面
	function s:lintcfg(name)
		let conf = s:path('tools/conf/')
		let path1 = conf . a:name
		let path2 = expand('~/.vim/linter/'. a:name)
		if filereadable(path2)
			return path2
		endif
		return shellescape(filereadable(path2)? path2 : path1)
	endfunc
	" 设置 flake8/pylint 的参数
	let g:ale_python_flake8_options = '--conf='.s:lintcfg('flake8.conf')
	let g:ale_python_pylint_options = '--rcfile='.s:lintcfg('pylint.conf')
	let g:ale_python_pylint_options .= ' --disable=W'
	let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
	let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
	let g:ale_c_cppcheck_options = ''
	let g:ale_cpp_cppcheck_options = ''
	let g:ale_linters.text = ['textlint', 'write-good', 'languagetool']
	" 如果没有 gcc 只有 clang 时（FreeBSD）
	if executable('gcc') == 0 && executable('clang')
		let g:ale_linters.c += ['clang']
		let g:ale_linters.cpp += ['clang']
	endif

endif


"----------------------------------------------------------------------
" git
"----------------------------------------------------------------------
if index(g:bundle_group, 'git') >= 0

	" 用于在侧边符号栏显示 git/svn 的 diff
	Plug 'mhinz/vim-signify'
	" Git 支持
	Plug 'tpope/vim-fugitive'
	" signify 调优
	let g:signify_vcs_list = ['git', 'svn']
	let g:signify_sign_add               = '+'
	let g:signify_sign_delete            = '_'
	let g:signify_sign_delete_first_line = '‾'
	let g:signify_sign_change            = '~'
	let g:signify_sign_changedelete      = g:signify_sign_change
	" git 仓库使用 histogram 算法进行 diff
	let g:signify_vcs_cmds = {
		\ 'git': 'git diff --no-color --diff-algorithm=histogram --no-ext-diff -U0 -- %f',
		\}

	" 提供 gist 接口
	Plug 'lambdalisue/vim-gista', { 'on': 'Gista' }

endif


"----------------------------------------------------------------------
" fuzzy : 文件模糊匹配，tags/函数名 选择
"----------------------------------------------------------------------
if index(g:bundle_group, 'fuzzy') >= 0

	" fzf
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'

	" 如果 vim 支持 python 则启用  Leaderf
	if has('python') || has('python3')
		if has('win32') || has('win64')
			Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat' }
		else
			Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
		endif
		" f 打开文件模糊匹配
		let g:Lf_ShortcutF = "<leader>ff"
		" b 打开 buffer 模糊匹配
		let g:Lf_ShortcutB = "<leader>fb"
		" h 打开最近使用的文件 MRU，进行模糊匹配
		noremap <leader>fh :LeaderfMru<cr>
		" s 打开函数列表，按 i 进入模糊匹配，ESC 退出
		noremap <leader>fh :LeaderfFunction!<cr>
		" t 打开 tag 列表，i 进入模糊匹配，ESC退出
		noremap <leader>ft :LeaderfBufTag!<cr>
		" b 打开 buffer 列表进行模糊匹配
		noremap <leader>fb :LeaderfBuffer<cr>
		" z 全局 tags 模糊匹配
		noremap <leader>fz :LeaderfTag<cr>
		" 最大历史文件保存 2048 个
		let g:Lf_MruMaxFiles = 2048
		" ui 定制
		let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
		" 如何识别项目目录，从当前文件目录向父目录递归知道碰到下面的文件/目录
		let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git', '.vscode']
		let g:Lf_WorkingDirectoryMode = 'Ac'
		let g:Lf_WindowHeight = 0.30
		let g:Lf_CacheDirectory = expand('~/.vim/cache')
		" 显示绝对路径
		let g:Lf_ShowRelativePath = 0
		" 隐藏帮助
		let g:Lf_HideHelp = 1
		" 模糊匹配忽略扩展名
		let g:Lf_WildIgnore = {
			\ 'dir': ['.svn','.git','.hg'],
			\ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.out','*.so','*.py[co]']
			\ }
		" MRU 文件忽略扩展名
		let g:Lf_MruFileExclude = ['*.so', '*.exe', '*.py[co]', '*.sw?', '~$*', '*.bak', '*.tmp', '*.dll']
		let g:Lf_StlColorscheme = 'powerline'
		" 禁用 function/buftag 的预览功能，可以手动用 p 预览
		let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
		" 使用 ESC 键可以直接退出 leaderf 的 normal 模式
		let g:Lf_NormalMap = {
			\ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
			\ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<cr>']],
			\ "Mru": [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<cr>']],
			\ "Tag": [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<cr>']],
			\ "BufTag": [["<ESC>", ':exec g:Lf_py "bufTagExplManager.quit()"<cr>']],
			\ "Function": [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<cr>']],
			\ }
	endif

endif


"----------------------------------------------------------------------
" asynctasks : 编译运行
"----------------------------------------------------------------------
if index(g:bundle_group, 'asynctasks') >= 0

	Plug 'skywind3000/vim-terminal-help'
	Plug 'skywind3000/asynctasks.vim'
	Plug 'skywind3000/asyncrun.vim'
	let g:asyncrun_open = 6
	let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg', '.vscode']
	noremap <silent><m-3> :AsyncTaskList<cr>
	noremap <silent><m-5> :AsyncTask file-run<cr>
	noremap <silent><m-4> :AsyncTask file-build<cr>
	noremap <silent><m-6> :AsyncTask project-run<cr>
	noremap <silent><m-7> :AsyncTask project-build<cr>
	noremap <silent><m-8> :AsyncTaskMacro<cr>
	let g:asynctasks_term_pos = 'tab'
	let g:asynctasks_term_reuse = 1
	let g:asynctasks_term_focus = 1
	let g:asynctasks_rtp_config = "my-vim/tasks/asynctasks.ini"
	let g:asynctasks_config_name = '.asynctasks'

endif


"----------------------------------------------------------------------
" asyncomplete
"----------------------------------------------------------------------
if index(g:bundle_group, 'asyncomplete') >= 0

	Plug 'prabirshrestha/asyncomplete.vim'
	Plug 'prabirshrestha/async.vim'
	Plug 'prabirshrestha/vim-lsp'
	Plug 'prabirshrestha/asyncomplete-lsp.vim'

	Plug 'prabirshrestha/asyncomplete-buffer.vim'
	Plug 'prabirshrestha/asyncomplete-file.vim'
	Plug 'Shougo/neoinclude.vim'
	Plug 'kyouryuukunn/asyncomplete-neoinclude.vim'
	if executable('flow')
		Plug 'prabirshrestha/asyncomplete-flow.vim'
	endif
	if index(g:bundle_group, 'tags') >= 0
		Plug 'prabirshrestha/asyncomplete-tags.vim'
	endif
	Plug 'hauleth/asyncomplete-pivotaltracker.vim'
	Plug 'Shougo/neco-syntax'
	Plug 'prabirshrestha/asyncomplete-necosyntax.vim'
	Plug 'Shougo/neco-vim'
	Plug 'prabirshrestha/asyncomplete-necovim.vim'
	if has('python3')
		Plug 'SirVer/ultisnips'
		Plug 'honza/vim-snippets'
		Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
	endif
	if executable('clang')
		Plug 'keremc/asyncomplete-clang.vim'
	endif
	Plug 'wellle/tmux-complete.vim'
	Plug 'akemrir/asyncomplete-ruby.vim'

endif

"----------------------------------------------------------------------
" 结束插件安装
"----------------------------------------------------------------------

" Plug 'skywind3000/vim-quickui' --todo

" Plug 'mattn/vim-lsp-settings' --todo

" Plug 'puremourning/vimspector' --todo

" Plug 'Shougo/defx.nvim' --todo

" Plug 'jayli/vim-easycomplete' --todo

" Plug 'liuchengxu/vista.vim' --todo

" Plug 'liuchengxu/vim-clap' --todo

call plug#end()


"----------------------------------------------------------------------
" 补全的注册
"----------------------------------------------------------------------
if index(g:bundle_group, 'asyncomplete') >= 0

	"补全
	inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
	imap <c-space>			<Plug>(asyncomplete_force_refresh)
	let g:asyncomplete_auto_popup = 0

	function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~ '\s'
	endfunction

	inoremap <silent><expr> <TAB>
		\ pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<TAB>" :
		\ asyncomplete#force_refresh()
	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

	" allow modifying the completeopt variable, or it will
	" " be overridden all the time
	let g:asyncomplete_auto_completeopt = 0
	set completeopt=menuone,noinsert,noselect,preview

	let g:UltiSnipsExpandTrigger="<m-q>"

	autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

	if index(g:bundle_group, 'kite') >= 0
		let g:tmuxcomplete#asyncomplete_source_options = {
			\ 'name':      'tmuxcomplete',
			\ 'whitelist': ['*'],
			\ 'blacklist': ['py', 'python'],
			\ 'config': {
			\     'splitmode':      'words',
			\     'filter_prefix':   1,
			\     'show_incomplete': 1,
			\     'sort_candidates': 0,
			\     'scrollback':      0,
			\     'truncate':        0
			\     }
			\ }
		call asyncomplete#register_source(asyncomplete#sources#necosyntax#get_source_options({
			\ 'name': 'necosyntax',
			\ 'whitelist': ['*'],
			\ 'blacklist': ['py', 'python'],
			\ 'completor': function('asyncomplete#sources#necosyntax#completor'),
			\ }))
		call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
			\ 'name': 'buffer',
			\ 'whitelist': ['*'],
			\ 'blacklist': ['go', 'py', 'python'],
			\ 'completor': function('asyncomplete#sources#buffer#completor'),
			\ 'config': {
			\    'max_buffer_size': 5000000,
			\  },
			\ }))
		call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
			\ 'name': 'file',
			\ 'whitelist': ['*'],
			\ 'blacklist': ['py', 'python'],
			\ 'completor': function('asyncomplete#sources#file#completor')
			\ }))
		if has('python3')
			call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
				\ 'name': 'ultisnips',
				\ 'whitelist': ['*'],
				\ 'blacklist': ['py', 'python'],
				\ 'completor': function('asyncomplete#sources#ultisnips#completor'),
				\ }))
		endif
	else
		let g:tmuxcomplete#asyncomplete_source_options = {
			\ 'name':      'tmuxcomplete',
			\ 'whitelist': ['*'],
			\ 'config': {
			\     'splitmode':      'words',
			\     'filter_prefix':   1,
			\     'show_incomplete': 1,
			\     'sort_candidates': 0,
			\     'scrollback':      0,
			\     'truncate':        0
			\     }
			\ }
		call asyncomplete#register_source(asyncomplete#sources#necosyntax#get_source_options({
			\ 'name': 'necosyntax',
			\ 'whitelist': ['*'],
			\ 'completor': function('asyncomplete#sources#necosyntax#completor'),
			\ }))
		call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
			\ 'name': 'buffer',
			\ 'whitelist': ['*'],
			\ 'blacklist': ['go'],
			\ 'completor': function('asyncomplete#sources#buffer#completor'),
			\ 'config': {
			\    'max_buffer_size': 5000000,
			\  },
			\ }))
		call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
			\ 'name': 'file',
			\ 'whitelist': ['*'],
			\ 'completor': function('asyncomplete#sources#file#completor')
			\ }))
		if has('python3')
			call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
				\ 'name': 'ultisnips',
				\ 'whitelist': ['*'],
				\ 'completor': function('asyncomplete#sources#ultisnips#completor'),
				\ }))
		endif
	endif
	call asyncomplete#register_source(asyncomplete#sources#neoinclude#get_source_options({
		\ 'name': 'neoinclude',
		\ 'whitelist': ['cpp', 'c'],
		\ 'refresh_pattern': '\(<\|"\|/\)$',
		\ 'completor': function('asyncomplete#sources#neoinclude#completor'),
		\ }))
	if executable('flow')
		call asyncomplete#register_source(asyncomplete#sources#flow#get_source_options({
			\ 'name': 'flow',
			\ 'whitelist': ['javascript'],
			\ 'completor': function('asyncomplete#sources#flow#completor'),
			\ 'config': {
			\    'prefer_local': 1,
			\    'flowbin_path': expand('~/bin/flow'),
			\    'show_typeinfo': 1
			\  },
			\ }))
	endif
	if index(g:bundle_group, 'tags') >= 0
		call asyncomplete#register_source(asyncomplete#sources#tags#get_source_options({
			\ 'name': 'tags',
			\ 'whitelist': ['c'],
			\ 'completor': function('asyncomplete#sources#tags#completor'),
			\ 'config': {
			\    'max_file_size': 50000000,
			\  },
			\ }))
	endif
	call asyncomplete#register_source({
		\ 'name': 'PivotalTracker',
		\ 'whitelist': ['gitcommit'],
		\ 'completor': function('asyncomplete#sources#pivotaltracker#completor'),
		\ })
	call asyncomplete#register_source(asyncomplete#sources#necovim#get_source_options({
		\ 'name': 'necovim',
		\ 'whitelist': ['vim'],
		\ 'completor': function('asyncomplete#sources#necovim#completor'),
		\ }))
	if executable('clang')
		call asyncomplete#register_source(
			\ asyncomplete#sources#clang#get_source_options())
	endif
	call asyncomplete#register_source(asyncomplete#sources#ruby#get_source_options({
		\ 'name': 'ruby',
		\ 'priority': 1,
		\ 'whitelist': ['ruby'],
		\ 'completor': function('asyncomplete#sources#ruby#completor'),
		\ }))
endif


"----------------------------------------------------------------------
" colors
"----------------------------------------------------------------------
if index(g:bundle_group, 'colors') >= 0
	if has("gui_running")
		set background=light
		colorscheme papercolor
		let g:airline_theme='papercolor'
	else
		colorscheme onedark
		set background=dark
		let g:airline_theme='onedark'
	endif
	if (has("termguicolors"))
		set termguicolors
	endif
endif
