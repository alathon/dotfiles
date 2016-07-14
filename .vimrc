set shell=zsh

execute pathogen#infect()
syntax on
filetype plugin indent on

" Remap leader to ,
let mapleader=","

" Enable mouse (n = normal mode, a = all, i = insert mode)
set mouse=a
" Disable left/right-click
map <LeftMouse> <nop>
map <RightMouse> <nop>

" Set vim to search using The Silver Searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Bind K to search for word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Use Ag instead of grep.
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" Use/switch to tabs when switching buffer.
set switchbuf+=usetab,newtab
autocmd FileType qf nnoremap <buffer> <Enter> <C-W><Enter><C-W>T

" javascript-libraries-syntax
let g:used_javascript_libs = 'react'

" Tab indentation.
set tabstop=2
set shiftwidth=2
set expandtab
set number

" System clipboard
set clipboard^=unnamedplus

" Solarized
set nocompatible
set t_Co=256
set background=" dark | light "
colorscheme solarized
call togglebg#map("<F5>")
set cursorline
set colorcolumn=120

" Paste stuff.
map <F10> :set invpaste<CR>
set pastetoggle=<F10>

" Reindent whole file
map <F7> mzgg=G`z

" Tabs
map <Leader><Right> :tabn<CR>
map <Leader><Left> :tabp<CR>
nmap <Tab> :tabn<CR>

" vim-closetag
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.js"

" Close NERDTree if only thing left.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd BufEnter * lcd %:p:h

function! CheckLeftBuffers()
  if tabpagenr('$') == 1
    let i = 1
    while i <= winnr('$')
      if getbufvar(winbufnr(i), '&buftype') == 'help' ||
          \ getbufvar(winbufnr(i), '&buftype') == 'quickfix' ||
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
" NERDTree binding
nnoremap <Space>k :NERDTreeToggle<CR>

" CtrlP
" Binding
map <C-p> :CtrlP
" Ignores
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = { 'dir': '\v[\/]\.(git)|node_modules$', }
" Stable cache dir
let g:ctrlp_cache_dir = $HOME . './cache/ctrlp'

" vim-jsx
let g:jsx_ext_required = 0

" Syntastic
" set statusline+=%wwarningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%{ObsessionStatus()}

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = '/home/alathon/.npm/bin/eslint-d'
let g:syntastic_loc_list_height=3

" Neocomplete
let g:neocomplete#enable_at_startup = 1
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"
autocmd FileType javascript set omnifunc=tern#Complete
" let g:neocomplete#sources#omni#functions.javascript = 'tern#Complete'
" let g:neocomplete#sources#omni#input_patterns.javascript = '\h\w*\|[^. \t]\.\w*'

" Override eslint with local version where necessary.
let local_eslint = finddir('node_modules', '.;') . '/.bin/eslint'
if matchstr(local_eslint, "^\/\\w") == ''
  let local_eslint = getcwd() . "/" . local_eslint
endif
if executable(local_eslint)
  let g:syntastic_javascript_eslint_exec = local_eslint
endif
