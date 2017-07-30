

""""""""""""""""""""""
" {{{  functions  "
""""""""""""""""""""""
"
" {{{ s:buildSearchString
function! s:buildSearchString(dates2search, addonPattern)
  let dates2search = a:dates2search

  " if has("unix")
	let searchString = "\\c\\(\* \\[X\\].\*\\)\\@<!\\(@\[0-9- \]*\\)\\<\\(".a:dates2search."\\)\\>".a:addonPattern."\\(.\*DONE\\)\\@!"

  " elseif (has("win64") || has("win32") || has("win16"))
  "    let searchString = "\\c\\(\* \\[X\\].\*\\)\\@<!\\(@\[0-9- \]*\\)\\<\\(".a:dates2search."\\)\\>".a:addonPattern."\\(.\*DONE\\)\\@!"
  " endif                         

  return searchString
endfunction
" }}}


" {{{ s:executeSearch
function! s:executeSearch(searchString)
  if exists("a:searchString")
    let @/ = a:searchString
    execute "silent g/".a:searchString."/call OpenFoldIfClosed()"
  else
    echo "no past dates found"
  endif

endfunction
" }}}
 

" {{{ PyShowNextDays
function! PyShowNextDays(numDays)

py << EOF
dateSequence = getNextDays(
											numDays = vim.eval("a:numDays"), 
											buffer = vim.current.buffer,
											dateFormat = vim.eval("g:vwt#variables#pythonDateFormat"),
											vimTaskDate = vim.eval("g:vwt#variables#endDatePattern"),
											vimDatePattern = vim.eval("g:vwt#variables#dateFormat")
										)

vim.command("let dateSequence = join(" + str(dateSequence) + ", '\|')")  # or \\|
EOF

if exists("dateSequence")
  let l:searchString = s:buildSearchString(dateSequence, "")
  call s:executeSearch(l:searchString)
else 
   return
endif

endfunction
"}}}



" {{{ PyShowPast
function! PyShowPast()

if g:vwt#variables#dueDatesOnly
  let l:dueDatePattern = ":"
else
  let l:dueDatePattern = ""
endif        

py << EOF
pastDates = getHistory(	
											dateFormat=vim.eval("g:vwt#variables#pythonDateFormat"), 
											buffer = vim.current.buffer,
											vimTaskDate=vim.eval("g:vwt#variables#endDatePattern"),
           						vimDatePattern=vim.eval("g:vwt#variables#dateFormat")
											)

vim.command("let date_seq_unix = join(" + str(pastDates) + ", '\|')")  # or \\|
EOF

if has("unix") 
  let l:searchString = s:buildSearchString(date_seq_unix, l:dueDatePattern)

elseif (has("win64") || has("win32") || has("win16")) 
  let l:searchString = s:buildSearchString(date_seq_unix, l:dueDatePattern)

endif

call s:executeSearch(l:searchString)

endfunction   
" }}} end PyShowPast

 
" {{{  DueDate
function DueDate(num)

py << EOF

import datetime as dt
import vim

dateFormat= vim.eval("g:vwt#variables#pythonDateFormat")
# date_1 = datetime.datetime.strptime(start_date, "%m/%d/%y")
num = float(vim.eval("a:num"))
date = dt.datetime.today() + dt.timedelta(days=num)
date = date.strftime(dateFormat)


vim.command("let s:date = " + date)
vim.command('exe ":normal i "' + date)

EOF

" https://unix.stackexchange.com/questions/8101/how-to-insert-the-result-of-a-command-into-the-text-in-vim 
" exe '"=strftime('%c')<C-M>p'
" :call feedkeys("i". strftime("%c"))

" exe ":normal i " . s:date
" call feedkeys("i". s:date)

endfunction
" }}}
                

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ shorter mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function!  ShowNextWeek() 
   execute PyShowNextDays(7) 
endfunction

function!  ShowNextMonth() 
   execute PyShowNextDays(30) 
endfunction

" }}} 

" vim:foldmethod=marker:foldlevel=0


