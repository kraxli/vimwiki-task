
function! s:buildSeparatedList(list, sep1, sepStart, sepEnd)
  let tagsSeparated = join(a:list, a:sep1)
  let tagsSeparated = a:sepStart.tagsSeparated.a:sepEnd
  return tagsSeparated

endfunction


function! s:ExecuteList(list, file)
  execute "lvim ".a:list." ".a:file 
  " lopen
  
  lw " open only if search successful

endfunction


function! GetTagsFile(...)
  let tagList = a:000
  " let tagsSeparated = s:buildSeparatedList(tagList, ":\\|:", ":", ":")
  let tagsSeparated = s:buildSeparatedList(tagList, "\\>:\\|:\\<", ":\\<", "\\>:")
  call s:ExecuteList(tagsSeparated, "%")

endfunction


function! GetTagsWiki(...)
  let tagList = a:000
  " let tagsSeparated = s:buildSeparatedList(tagList, ":\\|:", ":", ":")
  let tagsSeparated = s:buildSeparatedList(tagList, "\\>:\\|:\\<", ":\\<", "\\>:")

  let files = expand('<sfile>:p:h')."/*.wiki"
  call s:ExecuteList(tagsSeparated, files)

endfunction   


function! GetPatternsFile(...)
  let tagList = a:000
  " let tagsSeparated = s:buildSeparatedList(tagList, "\\|", "", "")
  let tagsSeparated = s:buildSeparatedList(tagList, "\\>\\|\\<", "\\<", "\\>")
  call s:ExecuteList(tagsSeparated, "%")

endfunction


function! GetPatternsWiki(files2search, ...)
  let files2search = a:files2search
  let tagList = a:000
  " let tagsSeparated = s:buildSeparatedList(tagList, "\\>\\|\\<", "\\<", "\\>")
  let tagsSeparated = s:buildSeparatedList(tagList, "\\|", "", "")
  echo tagsSeparated


  if files2search == "*"
    " let files = expand('<sfile>:p:h')."/*.wiki"
    let files = g:vimwiki_list[0]["path"]."*.wiki"
  else
    let files = expand('<sfile>:p:h')."/*".files2search."*.wiki"
  endif

  call s:ExecuteList(tagsSeparated, files)

endfunction    


function! GetPast()

py << EOF
# getHistory is only for the open file and so is GetPast
pastDates = getHistory(	
											 dateFormat=vim.eval("g:vwt#variables#pythonDateFormat"), 
											 buffer = vim.current.buffer,
											 vimTaskDate=vim.eval("g:vwt#variables#endDatePattern"),
           						 vimDatePattern=vim.eval("g:vwt#variables#dateFormat")
											)
vim.command("let datesSeparated = join(" + str(pastDates) + " , '\|')")  # or \\|
EOF
 
call s:ExecuteList(datesSeparated, "%")

endfunction  


function! GetNextDays(numDays)

py << EOF
dateSequence = getNextDays(
											numDays = vim.eval("a:numDays"), 
											buffer = vim.current.buffer,
											dateFormat = vim.eval("g:vwt#variables#pythonDateFormat"),
											vimTaskDate = vim.eval("g:vwt#variables#endDatePattern"),
											vimDatePattern = vim.eval("g:vwt#variables#dateFormat")
										)

vim.command("let datesSeparated = join(" + str(dateSequence) + ", '\|')")  # or \\|
EOF
           
call s:ExecuteList(datesSeparated, "%")
endfunction


function! BrowseWikiDirectory(...)
  let tagList = a:000
  " let tagsSeparated = s:buildSeparatedList(tagList, ":\\|:", ":", ":")
  let tagsSeparated = s:buildSeparatedList(tagList, "\\>:\\|:\\<", ":\\<", "\\>:")

  let files = expand('<sfile>:p:h')."/*.wiki"
  call s:ExecuteList(tagsSeparated, files)

endfunction   
 

function! GetNextDaysWiki(numDays, filePattern)

py << EOF
dateSequence = getNextDaysFromWiki(
											numDays = vim.eval("a:numDays"), 
                      filePattern = vim.eval("a:filePattern"),
											dateFormat = vim.eval("g:vwt#variables#pythonDateFormat"),
											vimTaskDate = vim.eval("g:vwt#variables#endDatePattern"),
											vimDatePattern = vim.eval("g:vwt#variables#dateFormat")
										)

vim.command("let datesSeparated = join(" + str(dateSequence) + ", '\|')")  # or \\|
EOF
           
call s:ExecuteList(datesSeparated, "%")
endfunction
 

function! GetHistoryWiki(filePattern)

py << EOF
dateSequence = getPastDatesFromWiki(
                      filePattern = vim.eval("a:filePattern"),
											dateFormat = vim.eval("g:vwt#variables#pythonDateFormat"),
											vimTaskDate=vim.eval("g:vwt#variables#endDatePattern"),
           						vimDatePattern=vim.eval("g:vwt#variables#dateFormat")
										)

vim.command("let datesSeparated = join(" + str(dateSequence) + ", '\|')")  # or \\|
EOF
           
call s:ExecuteList(datesSeparated, "%")
endfunction
 
