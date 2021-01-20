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
set statusline=2

au! CursorHold
imap <C-l> <Right>
imap <C-k> <Up>
imap <C-j> <Down>
imap <C-h> <Left>
nmap <Esc><Esc> :nohlsearch<CR><Esc>

filetype plugin on
filetype on

autocmd FileType python setlocal completeopt-=preview

highlight Normal ctermbg=none
autocmd ColorScheme * highlight Normal ctermbg=None
autocmd ColorScheme * highlight Comment ctermfg=110 guifg=#00FF00
autocmd ColorScheme * highlight Identifier ctermfg=56 guifg=#00FF00
autocmd ColorScheme * highlight PreProc ctermfg=196 guifg=#00FF00
autocmd ColorScheme * highlight Statement ctermfg=196 guifg=#00FF00
autocmd ColorScheme * highlight String ctermfg=227 guifg=#00FF00
autocmd ColorScheme * highlight Repeat ctermfg=202 guifg=#00FF00
autocmd ColorScheme * highlight Conditional ctermfg=202 guifg=#00FF00
autocmd ColorScheme * highlight Visual ctermfg=White ctermbg=LightBlue
autocmd ColorScheme * highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
syntax on
colorscheme molokai
set t_Co=256
command! SyntaxInfo call s:get_syn_info()

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

if &compatible
  set nocompatible
endif

let s:dein_dir = expand('~/.vim/dein')

let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:toml_dir = expand('~/.vim/rc')
  call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})
  call dein#load_toml(s:toml_dir . '/dein_lazy.toml', {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

call map(dein#check_clean(), "delete(v:val, 'rf')")
