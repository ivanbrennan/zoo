if exists("g:loaded_zoo")
  finish
endif
let g:loaded_zoo = 1

nnoremap <silent> <Plug>(zoo)  :call zoo#toggle()<CR>
