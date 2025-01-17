unmap <Space>

set clipboard=unnamed
set tabstop=4

exmap tabnext obcommand workspace:next-tab
nmap <Space>o :tabnext
exmap tabprev obcommand workspace:previous-tab
nmap <Space>i :tabprev

exmap close obcommand workspace:close
nmap <Space>q :close

exmap vsplit obcommand workspace:split-vertical
nmap <Space><C-l> :vsplit

exmap files obcommand file-explorer:open
nmap <Space>ff :files

exmap search obcommand global-search:open
nmap <Space>fg :search

exmap sidebar obcommand app:toggle-left-sidebar
nmap <Space>aa :sidebar

exmap commands obcommand command-palette:open
nmap <Space>c :commands

exmap dailynote obcommand daily-notes
nmap <Space>dd :dailynote

exmap dailynext obcommand daily-notes:goto-next
nmap <Space>dn :dailynext

exmap dailyprev obcommand daily-notes:goto-prev
nmap <Space>dn :dailyprev

exmap deletefile obcommand app:delete-file
nmap <Space>df :deletefile

" Helpful when text wraps.
" Up/Down one display line.
nnoremap k gk
nnoremap j gj
" Beginning/End of display line.
nnoremap 0 g0
nnoremap $ g$
