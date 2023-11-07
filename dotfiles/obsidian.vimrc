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

exmap search obcommand global-search:open
nmap <Space>ff :search

exmap sidebar obcommand app:toggle-left-sidebar
nmap <Space>aa :sidebar
