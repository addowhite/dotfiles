set-option global makecmd 'make -j4'

# colorscheme solarized-dark-termcolors
colorscheme gruvbox
# colorscheme desertex

# add-highlighter global/ number-lines -relative
# add-highlighter global/ show-whitespaces

hook global InsertChar \t %{ exec -draft -itersel h@ }
set global tabstop 2
set global indentwidth 2

hook global NormalKey y %{ nop %sh{
  printf %s "$kak_main_reg_dquote" | xsel --input --clipboard
}}

hook global InsertChar j %{ try %{
  exec -draft hH <a-k>jj<ret> d
  exec <esc>
}}

map global normal '#' :comment-line<ret>
map global normal <esc> ':w<ret><esc><space>lh'
map global insert <esc> '<esc>:w<ret><esc><space>lh'
map global normal <c-n> ':add-highlighter global/ number-lines -relative<ret>'
map global normal <c-a-n> ':remove-highlighter global/number-lines_-relative<ret>'
