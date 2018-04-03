This is just a stripped down version of zoomwintab, refactored to suit my tastes.
Only a single function is exposed: `zoo#toggle`.
No mappings are set, but a Normal mode `<Plug>(zoo)` map is provided.
I like to bind it like this:
``` vim
" toggle zoom
nmap     <C-W><C-O> <Plug>(zoo)
nmap     <C-W>o     <Plug>(zoo)

" really kill other windows
nnoremap <C-W>O     <C-W>o
```
