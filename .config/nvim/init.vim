call plug#begin()
" Gruvbox theme
Plug 'morhetz/gruvbox'

" Automatic close parens
Plug 'jiangmiao/auto-pairs'

" Javascript syntax highlighting
Plug 'pangloss/vim-javascript'

" Typescript syntax highlighting
Plug 'leafgarland/typescript-vim'

" Vue.js syntax highlighting
Plug 'posva/vim-vue'

" EditorConfig plugin for Vim 
Plug 'editorconfig/editorconfig-vim'

" Web development auto-completion
Plug 'mattn/emmet-vim'

" Fuzzy finding and buffer management
Plug 'Shougo/denite.nvim'

" Status bar plugin: vim-airline with themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Nerd Tree plugin
Plug 'scrooloose/nerdtree'

" gcc Code comments uncomments by gcc combo
Plug 'b3nj5m1n/kommentary'

" Intellisense code engine, auto-completion, linting, code fixing
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install() }}
call plug#end()

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p


" Vimsentials
set nocompatible
set autoindent
set autoread
set backspace=indent,eol,start
set hidden
set incsearch
set number
set nohlsearch
filetype indent plugin on
syntax on

" Default tab settings
set shiftwidth=4 tabstop=4 expandtab

" Wildmenu
set wildmenu
set wildignore+=**/node_modules/**

" Colorscheme
set termguicolors
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
hi! link javaScript             GruvboxBlue
hi! link jsExportDefault        GruvboxBlue
hi! link jsImport               GruvboxBlue
hi! link jsFrom                 GruvboxBlue
hi! link jsObjectKey            GruvboxBlue
hi! link jsObjectProp           GruvboxBlue
hi! link jsExport               GruvboxRedBold
hi! link jsObjectFuncName       GruvboxBlueBold
hi! link jsFuncCall             GruvboxBlueBold
hi! link jsVariableDef          GruvboxFg1
hi! link jsDestructuringBlock   GruvboxFg1
hi! link jsObjectShorthandProp  GruvboxFg1
hi! link jsFuncArgs             GruvboxFg1
hi! link htmlH2                 GruvboxFg1
hi! link jsBrackets             GruvboxFg4
hi! link jsObjectBraces         GruvboxFg4
hi! link jsFuncBraces           GruvboxFg4
hi! link Normal                 GruvboxFg4
hi! link Noise                  GruvboxFg4

" Key mapping
inoremap jj <Esc>
cnoremap $t <cr>:t''<cr>
nnoremap Y y$

" Fuzzy file searching
set path+=**

" C tags setup
command! MakeTags !ctags -R .

" Auto-pairs settings
let g:AutoPairsFlyMode=0

" Denite settings
nmap ; :Denite buffer -split=floating -winrow=1<CR>
nmap <leader>t :Denite file/rec -split=floating -winrow=1<CR>
nnoremap <leader>g :<C-u>Denite grep:. -no-empty -mode=normal<CR>
nnoremap <leader>j :<C-u>DeniteCursorWord grep:. -mode=normal<CR>

" Coc settings
nmap <silent> <leader>dd <Plug>(coc-definition)
nmap <silent> <leader>dr <Plug>(coc-references)
nmap <silent> <leader>dj <Plug>(coc-implementation)

" Avoid cached files littering up filesystem
let g:netrw_home=$XDG_CACHE_HOME . '/vim'

" Functions
function! SynGroup()                                                            
  let l:s = synID(line('.'), col('.'), 1)                                       
  echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
"
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
