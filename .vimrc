set number
set hlsearch
set virtualedit=onemore
set cursorline
set showmatch
set ignorecase
set display=lastline
set tabstop=4
set autoindent
set expandtab
set shiftwidth=4
set softtabstop=0
set noswapfile
au! CursorHold

:py3(sys.path.append('/home/hirochika/.pyenv/versions/3.5.2/lib/python3.5/site-packages'))

autocmd FileType python setlocal completeopt-=preview

set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

let g:molokai_original = 1
syntax on


"dein Scripts-----------------------------
if &compatible
    set nocompatible               " Be iMproved
endif

let s:dein_path = expand('~/.vim/dein')
let s:dein_repo_path = s:dein_path . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github からclone
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_path)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_path
    endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_path, ':p')
endif

if dein#load_state(s:dein_path)
    call dein#begin(s:dein_path)

    let g:config_dir  = expand('~/.vim/userconfig')
    let s:toml        = g:config_dir . '/plugins.toml'
    let s:lazy_toml   = g:config_dir . '/plugins_lazy.toml'

    " TOML 読み込み
    call dein#load_toml(s:toml,      {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})

    call dein#end()
    call dein#save_state()
endif

call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})
call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/neosnippet')


" Required:
filetype plugin indent on
syntax enable

" インストールされていないプラグインがあればインストールする
" If you want to install not installed plugins on startup.
if dein#check_install()
    call dein#install()
endif
"End dein Scripts-------------------------

"------------------------------------
" neocomplete.vim
"------------------------------------
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
 let g:acp_enableAtStartup = 0
 " Use neocomplete.
 let g:neocomplete#enable_at_startup = 1
 " Use smartcase.
 let g:neocomplete#enable_smart_case = 1
 " Set minimum syntax keyword length.
 let g:neocomplete#sources#syntax#min_keyword_length = 3
 let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
 " Plugin key-mappings.
 inoremap <expr><C-g>     neocomplete#undo_completion()
 inoremap <expr><C-l>     neocomplete#complete_common_string()

 " Recommended key-mappings.
 " <CR>: close popup and save indent.
 inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
 function! s:my_cr_function()
    return neocomplete#close_popup() . "\<CR>"
     " For no inserting <CR> key.
       " return pumvisible() ? neocomplete#close_popup() : "\<CR>"
       endfunction

       " <TAB>: completion.
       inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
       " <C-h>, <BS>: close popup and delete backword char.
       inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
       inoremap <expr><CR>  pumvisible() ? "\<C-n>" . neocomplete#close_popup() : "\<CR>"
       " inoremap <expr><C-y>  neocomplete#close_popup()
       " inoremap <expr><C-e>  neocomplete#cancel_popup()

       " autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

autocmd FileType python setlocal omnifunc=jedi#completions
" let g:jedi#completions_enabled = 0
" let g:jedi#auto_vim_configuration = 0

" if !exists('g:neocomplete#force_omni_input_patterns')
"     let g:neocomplete#force_omni_input_patterns = {}
" endif

" let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'
