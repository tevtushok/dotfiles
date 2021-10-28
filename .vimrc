" General "{{{
set fileencoding=utf-8
set encoding=utf-8
set termencoding=utf-8

set nocompatible  " disable vi compatibility.
set history=256  " Number of things to remember in history.
set autowrite  " Writes on make/shell commands
set autoread  
set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay)
set clipboard+=unnamed  " Yanks go on clipboard instead.
set pastetoggle=<F2> "  toggle between paste and normal: for 'safer' pasting from keyboard
set tags=./tags;$HOME " walk directory tree upto $HOME looking for tags
" Modeline
set modeline
set modelines=5 " default numbers of lines to read for modeline instructions
" Backup
set nowritebackup
set nobackup
set directory=/tmp// " prepend(^=) $HOME/.tmp/ to default path; use full path as backup filename(//)
" Buffers
set hidden " The current buffer can be put to the background without writing to disk
" Match and search
set hlsearch    " highlight search
set ignorecase  " Do case in sensitive matching with
set smartcase		" be sensitive when there's a capital letter
set incsearch   "
" "}}}
" Formatting "{{{
" set fo+=o " Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
" set fo-=r " Do not automatically insert a comment leader after an enter
" set fo-=t " Do no auto-wrap text using textwidth (does not apply to comments)

set wrap
set textwidth=0		" Don't wrap lines by default
set wildmode=longest,list " At command line, complete longest common string, then list alternatives.

set backspace=indent,eol,start	" more powerful backspacing
set tabstop=4    " Set the default tabstop
set softtabstop=4
set shiftwidth=4 " Set the default shift width for indents
" set expandtab   " Make tabs into spaces (set by tabstop)
set smarttab " Smarter tab levels

set autoindent
set cindent
set cinoptions=:s,ps,ts,cs
set cinwords=if,else,while,do,for,switch,case

syntax on   " enable syntax
filetype plugin indent on   " Automatically detect file types.
" "}}}
" oo
"
"

" Visual "{{{
set nonumber  " Line numbers off
set showmatch  " Show matching brackets.
set matchtime=5  " Bracket blinking.
set novisualbell  " No blinking
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.
set vb t_vb= " disable any beeps or flashes on error
set ruler  " Show ruler
set showcmd " Display an incomplete command in the lower right corner of the Vim window
set shortmess=atI " Shortens messages
set list " Display unprintable characters f12 - switches
set listchars=tab:>>,trail:·,extends:»,precedes:« " Unprintable chars mapping

set foldenable " Turn on folding
set foldmethod=marker " Fold on the marker
set foldlevel=100 " Don't autofold anything (but I can still fold manually)
set foldopen=block,hor,mark,percent,quickfix,tag " what movements open folds 

set mouse-=a   " Disable mouse
set mousehide  " Hide mouse after chars typed

set splitbelow
set splitright


" "}}}
"
" Command and Auto commands " {{{
" Sudo write
comm! W exec 'w !sudo tee % > /dev/null' | e!

"Auto commands
au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,*.rake,config.ru}     set ft=ruby
au BufRead,BufNewFile {*.md,*.mkd,*.markdown}                         set ft=markdown
au BufRead,BufNewFile {COMMIT_EDITMSG}                                set ft=gitcommit

au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g'\"" | endif " restore position in file
" " }}}
"
" Key mappings " {{{
let maplocalleader = ",,"


" Tabs
nnoremap <silent> <LocalLeader>[ :tabprev<CR>
nnoremap <silent> <LocalLeader>] :tabnext<CR>
" Duplication
vnoremap <silent> <LocalLeader>= yP
nnoremap <silent> <LocalLeader>= YP
" Buffers
nnoremap <silent> <LocalLeader>- :bd<CR>
" Split line(opposite to S-J joining line)
nnoremap <silent> <C-J> gEa<CR><ESC>ew
" show/Hide hidden Chars
map <silent> <F12> :set invlist<CR>

" generate HTML version current buffer using current color scheme
map <silent> <LocalLeader>h :runtime! syntax/2html.vim<CR>
" " }}}
"
"
set runtimepath+=~/.vim/bundle/Vundle.vim/


inoremap <A-h> <Left>
inoremap <A-j> <Down>
inoremap <A-k> <Up>
inoremap <A-l> <Right>

set path+=**
set wildmenu
inoremap jj <Esc>
inoremap JJ <Esc><Right>
set clipboard=unnamedplus
set number
noremap H ^
noremap L $


map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" au VimEnter * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
" au VimLeave * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'
"
" double "quote" a word
nnoremap qw :silent! normal mpea"<Esc>bi"<Esc>`pl
" remove quotes from a word
nnoremap wq :silent! normal mpeld bhd `ph<CR>

nnoremap // :TComment<CR>
vnoremap // :TComment<CR>

if !has('gui_running')
	set t_Co=256
endif


" Plugins " {{{
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-git'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'sheerun/vim-polyglot'
Bundle "python-syntax"
Plugin 'preservim/nerdtree'
Plugin 'tpope/vim-surround'
" load lightline and config
Plugin 'itchyny/lightline.vim'
" Vim syntax and indent plugin for .vue files 
Plugin 'leafOfTree/vim-vue-plugin'
" FuzzyFinder
Bundle "L9"
Bundle "FuzzyFinder"
call vundle#end() " required

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

let g:python_highlight_all = 1
let g:vim_vue_plugin_config = { 
			\'syntax': {
			\   'template': ['html', 'pug'],
			\   'script': ['javascript', 'typescript', 'coffee'],
			\   'style': ['css', 'scss', 'sass', 'less', 'stylus'],
			\   'i18n': ['json', 'yaml'],
			\   'route': 'json',
			\},
			\'full_syntax': ['json'],
			\'initial_indent': ['i18n', 'i18n.json', 'yaml'],
			\'attribute': 1,
			\'keyword': 1,
			\'foldexpr': 1,
			\'debug': 0,
			\}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noshowmode
let g:lightline = {
	\ 'colorscheme': 'wombat',
	\ 'active': {
	\   'left': [
	\				['mode', 'paste'],
	\				['gitbranch', 'readonly', 'filename', 'modified'],
	\				['gitstatus'],
	\			],
	\   'right': [
	\				['lineinfo'],
	\				['percent'],
	\				['fet'],
	\				['filetype'],
	\			],
	\ },
	\ 'component_function': {
	\   'gitbranch': 'LightlineGitBranch',
	\   'fet': 'LightlineFET',
	\   'gitstatus': 'LightlineGitStatus',
	\ },
	\ }


function! LightlineGitStatus()
" M = modified A = added D = deleted R = renamed C = copied U = updated but unmerged
	let branch = FugitiveHead()
	let checkSymbol = "\u2713"
	let middledotSymbol = "\u00B7"
	let errSymbol = "!"
	let fname = expand('%:p')
	let groups = {
				\ "OK": {"code": "OK", "prefix": checkSymbol},
				\ "WARN": {"code": "WARN", "prefix": ""},
				\ "ERR": {"code": "ERR", "prefix": ""},
				\ "NOGIT": {"code": "NOGIT", "prefix": ""}
				\ }
	let group = groups.NOGIT.code

	let groupsMapStatus = {
				\ "":  groups.OK.code,
				\ "M": groups.WARN.code,
				\ "A": groups.WARN.code,
				\ "D": groups.ERR.code,
				\ "R": groups.WARN.code,
				\ "C": groups.WARN.code,
				\ "U": groups.ERR.code,
				\ "?": groups.ERR.code,
				\ }

	if (len(branch) && len(fname))
		let status = get(b:, "git_status", "?")
		let group = get(groupsMapStatus, status, groups.ERR.code)
	endif
	if group == groups.NOGIT.code
		return ""
	elseif group == groups.OK.code
		return checkSymbol
	else
		return status
	endif
endfunction

function! LightlineGitBranch()
	let branch = FugitiveHead()
	let fname = expand('%:p')
	" no git - Display only cross symbol
	" with inialized git display branch glyph and branch name
	let data = ["\u2a2f"]
	if (len(branch))
		call add(data, branch)
		let data[0] = "\uE0A0"
	endif
	return join(data, " ")
endfunction

" e.g. utf-8[unix]
function! LightlineFET()
	let fe = winwidth(0) > 70 ? &fileencoding: ''
	let ff = winwidth(0) > 30 ? ("[" . &fileformat. "]") : ''
	return fe . ff
endfunction

autocmd FileType vue inoremap <buffer><expr> : InsertColon()

function! InsertColon()
	let tag = GetVueTag()

	if tag == 'template'
		return ':'
	else
		return ': '
	endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:polyglot_disabled = ['json']
let g:fuf_modesDisable = [] " {{{
nnoremap <silent> <LocalLeader>h :FufHelp<CR>
nnoremap <silent> <LocalLeader>2  :FufFileWithCurrentBufferDir<CR>
nnoremap <silent> <LocalLeader>1  :FufFile<CR>
nnoremap <silent> <LocalLeader>3  :FufBuffer<CR>
nnoremap <silent> <LocalLeader>4  :FufDirWithCurrentBufferDir<CR>
nnoremap <silent> <LocalLeader>$  :FufDir<CR>
nnoremap <silent> <LocalLeader>5  :FufChangeList<CR>
nnoremap <silent> <LocalLeader>6  :FufMruFile<CR>
nnoremap <silent> <LocalLeader>7  :FufLine<CR>
nnoremap <silent> <LocalLeader>8  :FufBookmark<CR>
nnoremap <silent> <LocalLeader>*  :FuzzyFinderAddBookmark<CR><CR>
nnoremap <silent> <LocalLeader>9  :FufTaggedFile<CR>
" " }}}


augroup gitstatusline
	au!
	autocmd BufEnter,FocusGained,BufWritePost *
\		let b:git_status = trim(system(
\			printf("cd %s && git status --porcelain %s 2>/dev/null",
\				expand('%:p:h:S'),
\				expand('%:p')
\			)
\		))[0:0]
augroup end

let t:is_transparent = 0
function! Toggle_transparent()
    if t:is_transparent == 0
        hi Normal guibg=NONE ctermbg=NONE
        let t:is_transparent = 1
    else
        set background=dark
        let t:is_tranparent = 0
    endif
endfunction
nnoremap <C-t> : call Toggle_transparent()<CR>

colorscheme jellybeans
