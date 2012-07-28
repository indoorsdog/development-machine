call pathogen#infect() " pathogen vimplugin, auto load plugins in /bundle
syntax on " syntax coloring
set nocompatible 
set incsearch " incremental find-as-you-type searching
set backspace=indent,eol,start
set history=50 " 50 command history buffer
set autoread
let g:solarized_italic=0 " turn off italicizing in solarized
colorscheme solarized " set solarized as colorscheme (pathogen-enabled)
set background=dark " again, for solarized, 'dark' version
set nobackup "no backup on save
set nowb
set noswapfile
set wildmenu
set showcmd
set ruler " show row, column numbers, etc in status bar
set confirm
set noerrorbells " turn off error sounds
set novisualbell " turn off error blinks
set t_vb=
set tm=500
set number " show line numbers
map Y y$ " make 'Y' behave like other capitals 'D' 'C' etc -- yank from cursor to EOL
set hlsearch " highlight search matches
nnoremap <esc> :noh<return><esc> " escape key un-highlights matches
set ls=2
set lines=50 " show 50 rows 
set columns=120 " show 120 columns
set magic
set autoindent " auto-indent
set smartindent
set ignorecase
set smartcase
set infercase
set textwidth=0
set showmatch
au BufWritePre * :%s/\s\+$//e " strip trailing whitespace on save
filetype plugin indent on
set guioptions-=m " turn off menu bar
set guioptions-=T " turn off toolbar
set shiftwidth=4
set softtabstop=4
au FileType html,xhtml,xml,coffee,scss,scala,rb setl sw=2 sts=2
au Filetype coffee setl colorcolumn=80
set smarttab
set lbr
set tw=500
set expandtab
" au BufEnter *.scala setl formatprg=scala\ -cp\ C:/Users/SM010909\Downloads/scalariform_2.8.0-0.0.9.jar\ scalariform.commandline.Main\ --forceOutput
au BufWritePost *.coffee silent CoffeeMake! -b | cwindow
"au vimenter * NERDTree
"au vimenter * if !argc() | NERDTree | endif
"au bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
