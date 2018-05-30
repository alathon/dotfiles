" install vim-plug if it is missing
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin('~/.config/nvim/plugged')
" Elixir
" Plug 'slashmili/alchemist.vim'
" Plug 'elixir-lang/vim-elixir'

" Not sure if I actually use these...
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-fugitive'
Plug 'mileszs/ack.vim'
Plug 'sickill/vim-monokai'
Plug 'myusuf3/numbers.vim'
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'takac/vim-hardtime'
Plug 'chrisbra/Recover.vim'
Plug 'w0rp/ale'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'airblade/vim-rooter'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'

" TMUX integration
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'vim-scripts/LargeFile'

" JS/Web plugs
Plug 'heavenshell/vim-jsdoc'
Plug 'alvan/vim-closetag'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'lervag/vimtex'
call plug#end()

" LargeFile
let g:LargeFile = 3

" Ale
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'scss': ['stylelint'],
\   'haskell': ['stack-ghc-mod', 'hlint']
\}

" Latex
let g:vimtex_latexmk_progname = 'nvr'
let g:vimtex_view_method = 'general'
let g:vimtex_view_general_viewer = 'qpdfview'
let g:vimtex_view_general_options
  \ = '--unique @pdf\#src:@tex:@line:@col'
let g:vimtex_view_general_options_latexmk = '--unique'


let mapleader = " "
let maplocalleader = ","

" Visual mode deleting (cutting to the black hole)
xnoremap p "_dP
xnoremap s "_d

" Swap
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//

set background=dark
colorscheme monokai 

set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set showmode            " Show current mode.
set ruler               " Show the line and column numbers of the cursor.
set number              " Show the line numbers on the left side.
set formatoptions+=o    " Continue comment marker in new lines.
set textwidth=120         " Hard-wrap long lines as you type them.
set expandtab           " Insert spaces when TAB is pressed.
set tabstop=2           " Render TABs using this many spaces.
set shiftwidth=2        " Indentation amount for < and > commands.
set noerrorbells        " No beeps.
set modeline            " Enable modeline.
set linespace=0         " Set line-spacing to minimum.
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.
set nostartofline       " Do not jump to first character with page commands.
set display+=lastline   " Show latest command/pressed keys (i think)
if !&scrolloff
  set scrolloff=3       " Show next 3 lines while scrolling.
endif
if !&sidescrolloff
  set sidescrolloff=5   " Show next 5 columns while side-scrolling.
endif
" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set list                " Show problematic characters.
" Also highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
set hlsearch            " Highlight search results.
set ignorecase          " Make searching case insensitive
set smartcase           " ... unless the query has capital letters.
set incsearch           " Incremental search.
set gdefault            " Use 'g' flag by default with :s/foo/bar/.
set magic               " Use 'magic' patterns (extended regular expressions).
set hidden              " Don't unload buffers when they are abandoned
set clipboard^=unnamedplus " System clipboard
set spelllang=en
set spellfile=$HOME/.config/nvim/spell/en.utf-8.add
set timeoutlen=250                  " Shorter timeout length
set notimeout
set cursorline
autocmd InsertEnter * set timeout   " Enable timeout in insert
autocmd InsertLeave * set notimeout " Disable timeout in other modes

" Set vim to search using The Silver Searcher
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --vimgrep
  let g:ackprg = 'ag --vimgrep'
endif

" Bind K to search for word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR><CR>

" Paste mode
map <F10> :set invpaste<CR>
set pastetoggle=<F10>

" Re-indent whole file
map <F7> mzgg=G'z

" Alternate to using <Esc>
imap <S-Space> <Esc>

" Buffergator
" Use right side of screen
let g:buffergator_viewport_split_policy = 'R'
" Own keymappings
let g:buffergator_suppress_keymaps = 1
" Looper buffers
" let g:buffergator_mru_cycle_loop = 1
" Previous buffer
nmap <Leader>h :BuffergatorMruCyclePrev<CR>
" Next buffer
nmap <Leader>l :BuffergatorMruCycleNext<CR>
" List of buffers
nmap <Leader>bl :BuffergatorToggle<CR>
" New buffer
nmap <Leader>bc :enew<CR>
" Quit buffer
nmap <Leader>bq :bp <BAR> bd #<CR>
" Fuzzy finding
nnoremap <Leader>f :FZF<CR>

" NERDTree
" Open when vim starts on a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" Open NERDTree
map <Leader>k :NERDTreeToggle<CR>
map <leader>r :NERDTreeFind<cr>

" vim-airline: Automatically display all buffers when only one tab is open
let g:airline#extensions#tabline#enabled = 1
" automatically populate airline symbols dict with powerline symbols
let g:airline_powerline_fonts = 1

" Ignored directories
set wildignore=*.o,*.obj,.git,node_modules/**,bower_components/**,**/node_modules/**,_build/**,deps/**

" vim-closetag
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.js"

" enable hardtime
let g:hardtime_default_on = 1
let g:hardtime_ignore_quickfix = 1
let g:hardtime_maxcount = 2
nnoremap <leader><S-h> <Esc>:HardTimeToggle<CR>
let g:list_of_normal_keys = ["h", "j", "k", "l"]
let g:list_of_visual_keys = ["h", "j", "k", "l"]
let g:list_of_insert_keys = []
let g:list_of_disabled_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:hardtime_ignore_buffer_patterns = ["undotree*", "NERD.*",".*\.tex","*.\.vim"]

" Close NERDTree if last left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd BufEnter * lcd %:p:h

function! CheckLeftBuffers()
  if tabpagenr('$') == 1
    let i = 1
    while i <= winnr('$')
      if getbufvar(winbufnr(i), '&buftype') == 'help' ||
          \ getbufvar(winbufnr(i), '&buftype') == 'quickfix' ||
          \ exists('t:NERDTreeBufName') &&
          \ exists('t:NERDTreeBufName') &&
          \   bufname(winbufnr(i)) == t:NERDTreeBufName ||
          \ bufname(winbufnr(i)) == '__Tag_List__'
        let i += 1
      else
        break
      endif
    endwhile
    if i == winnr('$') + 1
      qall
    endif
    unlet i
  endif
endfunction
autocmd BufEnter * call CheckLeftBuffers()

" Turn off highlighting from current search
nnoremap <F3> :noh<CR>

" See http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity
" nnoremap <leader>_r :source $MYVIMRC<CR>
" nnoremap <leader>_d :
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Show undotree
nnoremap U :UndotreeShow<CR>:UndotreeFocus<CR>

" Add persistent undo
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif

" Change to current directory from non-project files
let g:rooter_change_directory_for_non_project_files = 'current' 

" JS(X)/Web setup
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.js" " Enable vim-closetag
let g:jsx_ext_required = 0 " Enable vim-jsx for .js files

" Latex
autocmd FileType latex,tex setlocal textwidth=80

" Deoplete setup
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
set completeopt=menuone,noinsert,noselect
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.ocaml = '[^ ,;\t\[()\]]'
au BufRead,BufNewFile *.ml,*.mli compiler ocaml

" Deoplete tab complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <C-c> <C-x><C-o>

" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

" NERDCommenter setup
let g:NERDSpaceDelims = 1            " Add spaces after comment delimiters by default
let g:NERDCompactSexyComs = 1        " Use compact syntax for prettified multi-line comments
let g:NERDDefaultAlign = 'left'      " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDCommentEmptyLines = 1      " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting

" vim-surround setup
xmap s <Plug>VSurround

" Windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <silent> <C-s> :update<CR>
inoremap <silent> <C-s> <C-O>:update<CR>

highlight ColorColumn ctermbg=magenta
autocmd BufNew,BufRead *.tex call matchadd('ColorColumn', '\%82v', 100)
autocmd BufNew,BufRead *.js call matchadd('ColorColumn', '\%122v', 100)
autocmd BufNew,BufRead *.tex setlocal textwidth=79
autocmd BufNew,BufRead *.js setlocal textwidth=119

" OCaml Merlin
 let g:opamshare = substitute(system('opam config var share'), '\n$', '', '''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
execute "set rtp+=" . g:opamshare . "/ocp-indent/vim"

" OCaml vim-slime
let g:slime_target = "tmux"
