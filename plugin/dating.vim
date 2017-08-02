

""""""""""""""""""""""
" {{{  functions  "
""""""""""""""""""""""
"
" {{{ s:buildSearchString
function! s:buildSearchString(dates2search, addonPattern)
  let dates2search = a:dates2search

  " " worked on unix:
  " let searchString = "\\c\\(\* \\[X\\].\*\\)\\@<!\\(@\[0-9- \]*\\)\\<\\(".a:dates2search."\\)\\>".a:addonPattern."\\(.\*DONE\\)\\@!"
  let searchString = "\\c\\(\* \\[X\\].\*\\)\\@<!\\(@\[0-9- \]*\\)\\<\\(".a:dates2search."\\):*\\>".a:addonPattern."\\(.\*DONE\\)\\@!"

  " if has("unix")
  "  let searchString = "\\c\\(\* \\[X\\].\*\\)\\@<!\\(@\[0-9- \]*\\)\\<\\(".a:dates2search."\\):*\\>".a:addonPattern."\\(.\*DONE\\)\\@!"
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

Py << EOF
dateSequence = getNextDays(
						   numDays = vim.eval("a:numDays"), 
						   buffer = vim.current.buffer,
						   dateFormat = vim.eval("g:vwt#variables#pythonDateFormat"),
						   vimTaskDate = vim.eval("g:vwt#variables#endDatePattern"),
						   vimDatePattern = vim.eval("g:vwt#variables#dateFormat")
						  )

vim.command("let dateSequence = join(" + str(dateSequence) + ", '\|')")  # or \\|

EOF

 
" elseif (has("win64") || has("win32") || has("win16")) 
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
 
let l:dueDatePattern = ""

" if g:vwt#variables#dueDatesOnly
"   let l:dueDatePattern = ":"
" else
"   let l:dueDatePattern = ""
" endif        

Py << EOF
pastDates = getHistory(	
					   buffer = vim.current.buffer,
					   dateFormat=vim.eval("g:vwt#variables#pythonDateFormat"), 
					   vimTaskDate=vim.eval("g:vwt#variables#endDatePattern"),
           			   vimDatePattern=vim.eval("g:vwt#variables#dateFormat")
					  )

vim.command("let date_seq = join(" + str(pastDates) + ", '\|')")  # or \\|
# if sys.platform.lower().startswith('win'):
#     vim.command("let date_seq = join(" + str(pastDates) + ", '\\|')")      
#     # vim.command("let date_seq = join([date_seq_mswin, '" + str(date_object) + "'], '\\|')")      
# else:
#     vim.command("let date_seq = join(" + str(pastDates) + ", '\|')")  # or \\|


EOF

" elseif (has("win64") || has("win32") || has("win16")) 
let l:searchString = s:buildSearchString(date_seq, l:dueDatePattern)
call s:executeSearch(l:searchString)

endfunction   
" }}} end PyShowPast

 
" {{{  InsertDueDate
function! InsertDueDate(num)

Py << EOF

dateFormat= vim.eval("g:vwt#variables#pythonDateFormat")
# date_1 = datetime.datetime.strptime(start_date, "%m/%d/%y")

num = float(vim.eval("a:num"))
year, month, day = get_date_from_today_on(num)

vim.command("let l:day = " + day)
vim.command("let l:month = " + month)
vim.command("let l:year = " + year)
# vim.command('exe ":normal i "' + year +  "-" + "printf('%04d'," + month + ")" + "-" + day)

EOF

exe ":normal i @" . l:year . "-" . printf('%02d', l:month) . "-" . printf('%02d', l:day) . ":"

" https://unix.stackexchange.com/questions/8101/how-to-insert-the-result-of-a-command-into-the-text-in-vim 
" call feedkeys("i". l:date)
" exe '"=strftime('%c')<C-M>p'
" :call feedkeys("i". strftime("%c"))

endfunction
" }}}
                
" {{{  InsertDueRange
function! InsertDueRange(num1, num2)

Py << EOF

num1 = float(vim.eval("a:num1"))
num2 = float(vim.eval("a:num2"))

year1, month1, day1 = get_date_from_today_on(num1)
year2, month2, day2 = get_date_from_today_on(num2)

vim.command("let l:day1 = " + day1)
vim.command("let l:month1 = " + month1)
vim.command("let l:year1 = " + year1)

vim.command("let l:day2 = " + day2)
vim.command("let l:month2 = " + month2)
vim.command("let l:year2 = " + year2) 

EOF

exe ":normal i @" . l:year1 . "-" . printf('%02d', l:month1) . "-" . printf('%02d', l:day1) .  " - " . l:year2 . "-" . printf('%02d', l:month2) . "-" . printf('%02d', l:day2) . ":"

" https://unix.stackexchange.com/questions/8101/how-to-insert-the-result-of-a-command-into-the-text-in-vim 
" call feedkeys("i". l:date)
" exe '"=strftime('%c')<C-M>p'
" :call feedkeys("i". strftime("%c"))

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


