if exists("g:autoloaded_zoo")
  finish
endif
let g:autoloaded_zoo = 1

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
  call s:zoom_in_new_tab()

  if tabpagenr() != origin_tab
    let t:origin_tab = origin_tab
  endif
endf

func! s:in_cmdline() abort
  return getcmdwintype() != ''
endf

func! s:only_one_window() abort
  return tabpagewinnr(tabpagenr(), '$') == 1
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
