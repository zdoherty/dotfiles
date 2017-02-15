" Bootstrap pathogen from bundle (instead of autoload) and active

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

" Necesary  for lots of cool vim things
set nocompatible

" This shows what you are typing as a command.  I love this!
set showcmd

" Needed for Syntax Highlighting and stuff
filetype on
filetype plugin on
syntax enable
set grepprg=grep\ -nH\ $*

" Who doesn't like autoindent?
set autoindent

" Spaces are better than a tab character
set expandtab
set smarttab

" Set 4 character tab
set shiftwidth=4
set softtabstop=4

" Make backspace work like other apps and traverse linebreaks
set backspace=2

" Enable line numbers
set number

" Ignore case to assist with searches
set ignorecase

" Unless we're specifically searching for capital letters
set smartcase

set incsearch
set nohlsearch

" Set off the other paren
highlight MatchParen ctermbg=4

" Favorite Color Scheme
colorscheme solarized
set background=dark

" Status line gnarliness
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

" Let's highlight undersirable nonsense
set list " we do what to show tabs, to ensure we get them out of my files
set listchars=tab:>-,trail:- " show tabs and trailing whitespace

" Remove default mode indicator, airline already supplies one
set noshowmode

let g:airline_powerline_fonts = 1

let paste_mode = 0 " 0 = normal, 1 = paste

func! Paste_on_off()
   if g:paste_mode == 0
      set paste
      let g:paste_mode = 1
   else
      set nopaste
      let g:paste_mode = 0
   endif
   return
endfunc

" Unfsck C-Left/Right bindings
map <ESC>[5D <C-Left>
map <ESC>[5C <C-Right>
map! <ESC>[5D <C-left>
map! <ESC>[5C <C-Right>

" Map two j's to exit insert mode
inoremap jj <Esc>

" Next Tab
nnoremap <silent> <C-Tab> :tabnext<CR>

" Previous Tab
nnoremap <silent> <C-S-Tab> :tabprevious<CR>

" New Tab
nnoremap <silent> <C-t> :tabnew<CR>

" Paste Mode!  Dang! <F10>
nnoremap <silent> <F10> :call Paste_on_off()<CR>
set pastetoggle=<F10>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Swap ; and :  Convenient.
nnoremap ; :
nnoremap : ;
