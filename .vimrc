" Vimrc Config - Tested on OS X
syntax on
set backspace=indent,eol,start
set fileencodings=ucs-bom,utf-8,default,latin1
set hlsearch
set helplang=en
set indentkeys=o,O,*<Return>,<>>,{,},0),0],o,O,!^F,=end,=else,=elsif,=rescue,=ensure,=when
set langmenu=none
set mouse=a
set printexpr=system('open\ -a\ Preview\ '.v:fname_in)\ +\ v:shell_error
set runtimepath=~/.vim,~/.vim/bundle/NERD_tree,~/.vim/bundle/fuzzyfinder,~/.vim/bundle/gundo,~/.vim/bundle/l9,~/.vim/bundle/loremipsum,~/.vim/bundle/matchit,~/.vim/bundle/ragtag,~/.vim/bundle/vim-surround,/Applications/MacVim.app/Contents/Resources/vim/vimfiles,/Applications/MacVim.app/Contents/Resources/vim/runtime,/Applications/MacVim.app/Contents/Resources/vim/vimfiles/after,~/.vim/after
set termencoding=utf-8
set window=45

" Source: http://stackoverflow.com/a/9528322/26860
" Save your backups to a less annoying place than the current directory.
" If you have .vim-backup in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/backup or . if all else fails.
if isdirectory($HOME . '/.vim/backup') == 0
  :silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/backup/
set backupdir^=./.vim-backup/
set backup

" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

" Write to swap every 2 seconds
set updatetime=2000


"
" viminfo stores the the state of your previous editing session
set viminfo+=n~/.vim/viminfo

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif

" Show matching brackets when text indicator is over them
set showmatch

" Tabs
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Line Numbers
set nu

" Colors
set background=dark
colorscheme neon-dark

" Debugging 
let g:vdebug_options= {
\   "port" : 9000,
\   "server" : "",
\   "path_maps" : {"/var/www/apps/tumblr" : "/Users/jasonseney/src/tumblr"}
\}

" Load Plugins
call pathogen#infect()
call pathogen#runtime_append_all_bundles()

" Detect file types
filetype on
filetype plugin indent on

au BufRead,BufNewFile *.tpl set filetype=php 

" Tabs for specific filetypes
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Disable auto comment continuation
" http://vim.wikia.com/wiki/Disable_automatic_comment_insertion
" autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Nerdtree
let NERDTreeShowHidden=1
let NERDTreeChDirMode=2
command NT NERDTreeToggle

" Tag Bar
command TB Tagbar

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_max_files = 0
au VimEnter,VimResized * let g:ctrlp_max_height = &lines
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Marked.app support
:nnoremap <leader>m :silent !open -a Marked.app '%:p'<cr>
command! Marked silent !open -a "Marked.app" "%:p"

" For opening GUI File Browser
command! Finder silent !open %:p:h
command! FinderCurrentDir silent !open .

" Open new Terminal window in the current directory
command! Terminal silent !open -a Terminal `pwd`
command Term Terminal

" cd to current file's directory
command! CdHere cd %:p:h

" Encrypt buffer and save to file
command -nargs=1 WriteEncrypted w !gpg -c -o <q-args>

" Find text in current directory
command -nargs=1 -bar FindText vimgrep /<args>/gj ./**/*.* | copen

" Run matchit for matching XML/HTML tags (use % when on tag)
runtime macros/matchit.vim

" Shortcut for writing file then syncing
command Gs w | !git-sync -y
command Go w | !gulp && git-sync 

command Gist %y+ | !`gist -P -f %:t | pbcopy`

" Gui
if has('gui_running')
    set guifont=Menlo:h18
    set guioptions=egmrLt
    set guitablabel=%M%t
    set guioptions-=T           " remove the toolbar
    set lines=50                " 40 lines of text instead of 24,
    set columns=140
    set transparency=20         " Make the window slightly transparent
else
    " terminal vim here
endif
