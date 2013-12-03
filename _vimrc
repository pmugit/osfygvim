set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
"Personal Settings.
"More to be added soon.
""Vundle settings start
filetype off  
set rtp+=C:\Users\Admin\Vim\vimfiles\bundle\vundle
call vundle#rc()
Bundle 'gmarik/vundle'
"Vundle settings end
"Extra Bundles
Bundle 'itchyny/lightline.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'Shougo/neocomplcache.vim'   
Bundle 'c9s/perlomni.vim'

execute pathogen#infect()
filetype plugin indent on
syntax on
"Set the status line options
"set laststatus=2
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
	
"Set Color Scheme and Font Options
colorscheme kolor
set guifont=Consolas:h11

"Set other options such for line numbers, allowing to move through edited
"buffers (files), various search and higlight options etc.
set nu
set hidden
set ignorecase
set incsearch
set smartcase
set showmatch
set autoindent
set ruler
set vb
set noshowmode
set noerrorbells
set viminfo+=n$VIM\\_viminfo
set mouse=a
set history=1000
set undolevels=1000
set virtualedit=all
set cul
"Disable arrows keys.
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

"Press <F3> to disable/enable search highlight
nnoremap <F3> :set hlsearch!<CR>

"NeoComplCache Settings
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 0
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
"====================
" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_omni_patterns.perl = '\h\w*->\|\h\w*->\h\w*\|\h\w*::\|\h\w*::\h\w*'
"Syntastic Settings 
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_check_on_open=1
let g:syntastic_enable_balloons=1
let g:syntastic_always_populate_loc_list=1
let g:syntastic_echo_current_error=1
let g:syntastic_enable_highlighting=1
let g:syntastic_auto_jump=1
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5
"let g:syntastic_perl_lib_path="C:\strawberry\perl\lib"
let g:syntastic_perl_checkers=['perl' , 'perlcritic']
let g:syntastic_id_checkers=1
let g:syntastic_python_checkers=['python', 'pyflakes']
"Enable below in case you want the error line highlighted
highlight SyntasticErrorLine guibg=#6D6968 
highlight SyntasticWarningLine guibg=#6D6968 
"Sytanstic Error Signs"
let g:syntastic_error_symbol="E>"
let g:syntastic_warning_symbol="W>"
"End of Syntastic Settings

"NERDTree Settings
"Open gVim with NERDTree 
autocmd vimenter * if !argc() | NERDTree | endif
"Close NERDTree if the last file is closed.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"Give a nice look to NERDTree
let NERDChristmasTree = 1 
"Show nice arrows instead of +
scriptencoding utf-8
set encoding=utf-8
let NERDTreeDirArrows = 1
