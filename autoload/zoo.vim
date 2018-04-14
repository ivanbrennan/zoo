if exists("g:autoloaded_zoo")
  finish
endif
let g:autoloaded_zoo = 1

let s:origin_wins = {}
let s:NULL_ORIGIN = 0

func! zoo#toggle() abort
  if s:is_zoomed()
    call s:zoom_out()
  else
    call s:zoom_in()
  endif
endf

func! s:is_zoomed() abort
  return exists('t:origin_tab')
endf

func! s:zoom_in() abort
  if s:in_cmdline()
    echo 'No zoom in command line window' | return
  endif
  if s:only_one_window()
    echo 'Already only one window' | return
  endif

  let origin_tab = tabpagenr()
  let origin_win = win_getid()

  call s:zoom_in_new_tab()

  if tabpagenr() != origin_tab
    let t:origin_tab = origin_tab
    let s:origin_wins[win_getid()] = origin_win
  endif
endf

func! s:in_cmdline() abort
  return getcmdwintype() != ''
endf

func! s:only_one_window() abort
  return winnr('$') == 1
endf

func! s:zoom_in_new_tab() abort
  let o = &switchbuf
  set switchbuf&
  exec 'tab sbuffer' bufnr('%')
  let &switchbuf = o
endf

func! s:zoom_out() abort
  let origin_tab = t:origin_tab
  tabclose
  if tabpagenr() != origin_tab
    exec 'tabnext ' origin_tab
  endif
endf

augroup Zoo
  au!
  au QuitPre * if s:zoomed_win_only() | call s:quit_origin() | endif
augroup END

func! s:zoomed_win_only() abort
  return s:only_one_window() && s:exists(s:get_origin())
endf

func! s:exists(origin)
  return a:origin != s:NULL_ORIGIN
endf

func! s:get_origin() abort
  return get(s:origin_wins, win_getid(), s:NULL_ORIGIN)
endf

func! s:quit_origin() abort
  let og = s:get_origin()

  if s:exists(og)
    let i = win_getid()
    call win_gotoid(og) | quit
    call win_gotoid(i)
  endif
endf
