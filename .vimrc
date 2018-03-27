let mapleader=","
set relativenumber
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
set backspace=2
au! CursorHold
filetype plugin on
filetype on
""colorscheme molokai
highlight Normal ctermbg=none

imap <C-l> <Right>
imap <C-k> <Up>
imap <C-j> <Down>
imap <C-h> <Left>
nmap <Esc><Esc> :nohlsearch<CR><Esc>

autocmd FileType python setlocal completeopt-=preview

set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

autocmd ColorScheme * highlight Normal ctermbg=None
autocmd ColorScheme * highlight Comment ctermfg=110 guifg=#00FF00
autocmd ColorScheme * highlight Identifier ctermfg=208 guifg=#00FF00
autocmd ColorScheme * highlight String ctermfg=227 guifg=#00FF00
syntax on
""set g:molokai_original = 1
colorscheme molokai
set t_Co=256

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
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/neomru.vim')
call dein#add('scrooloose/nerdcommenter')
call dein#add('tpope/vim-surround')
call dein#add('simeji/winresizer')
call dein#add('cohama/lexima.vim')


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
 inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

 let g:neosnippet#snippets_directory='~/.vim/my_snippet'
                    
 if has('conceal')
     set conceallevel=2 concealcursor=i
 endif

autocmd FileType python setlocal omnifunc=jedi#completions

function! s:get_syn_id(transparent)
    let synid = synID(line("."), col("."), 1)
    if a:transparent
        return synIDtrans(synid)
    else
        return synid
    endif
endfunction
function! s:get_syn_attr(synid)
    let name = synIDattr(a:synid, "name")
    let ctermfg = synIDattr(a:synid, "fg", "cterm")
    let ctermbg = synIDattr(a:synid, "bg", "cterm")
    let guifg = synIDattr(a:synid, "fg", "gui")
    let guibg = synIDattr(a:synid, "bg", "gui")
    return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction
function! s:get_syn_info()
    let baseSyn = s:get_syn_attr(s:get_syn_id(0))
    echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
    let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
    echo "link to"
    echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()
