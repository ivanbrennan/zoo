if exists("g:loaded_zoo")
  finish
endif
let g:loaded_zoo = 1

nnoremap <silent> <Plug>(zoo)  :call zoo#toggle()<CR>

augroup Zoo
  au!
  au QuitPre * if zoo#zoomed_win_only() | call zoo#quit_origin() | endif
augroup END
