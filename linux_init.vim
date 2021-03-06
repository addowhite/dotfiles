"set ff=unix
set nocompatible              " be iMproved, required
filetype off                  " required
syntax on

map <C-b> :NERDTreeToggle<CR>

nmap <C-_> <plug>NERDCommenterInvert

set tabstop=2 shiftwidth=2
set softtabstop=2 expandtab smarttab
set cindent nofoldenable foldmethod=indent

set number relativenumber

set updatetime=100

set termguicolors
set mouse=a
"set mouse=

set tags=./tags,/usr/include/tags

"let g:falcon_lightline = 1
"let g:lightline.colorscheme = 'falcon'
"let g:falcon_airline = 1
"let g:airline_theme = 'falcon'

"let g:neosolarized_contrast = "high" " low/normal/high
"let g:neosolarized_visibility = "normal" " Whitespace visibility
"let g:neosolarized_vertSplitBgTrans = 0
"let g:neosolarized_bold = 1
"let g:neosolarized_underline = 1
"let g:neosolarized_italic = 0
"colorscheme NeoSolarized
"colorscheme slate
"colorscheme torte
"colorscheme falcon

set background=dark
colorscheme solarized

"let g:lightline = { 'colorscheme': 'solarized_dark' }
"colorscheme OceanicNext

"let g:lightline = { 'colorscheme': 'one' }
"colorscheme onedark

"colorscheme 256_noir

"set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
                  "\,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
                  "\,sm:block-blinkwait175-blinkoff150-blinkon175
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
                  \,a:Cursor/lCursor
                  \,sm:block

inoremap jj <Esc>

"nnoremap <F5> :buffers<CR>:buffer<Space>
nnoremap <F5> :w<Enter> :! sbuild %<Enter>
"nnoremap <F5> :w<Enter> :! make test<Enter>

nmap <silent> gd :w<Enter><C-]>
nmap <silent> <F12> :w<Enter><C-]>
"nmap <C-_> <C-t>
"nmap <C-N> :set number! relativenumber!<Enter>

nnoremap <C-p> :CtrlP<CR>

nnoremap <C-h> :tabp<CR>
nnoremap <C-j> :tabc<CR>
nnoremap <C-l> :tabn<CR>

nnoremap <C-n> :tabnew<CR>

" Exit terminal mode
tnoremap <Esc> <C-\><C-n>

"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>
"nnoremap <C-H> <C-W><C-H>

function FormatBuffer()
  if &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';'))
    let cursor_pos = getpos('.')
    :%!clang-format
    call setpos('.', cursor_pos)
  endif
endfunction

autocmd BufWritePre *.h,*.hpp,*.c,*.cpp,*.vert,*.frag :call FormatBuffer()

