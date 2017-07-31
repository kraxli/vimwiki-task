"""""""""""""""""""""""
" {{{ Sort Folded Lines  "
"""""""""""""""""""""""   le

function! s:rangeSize() range
    return a:lastline - a:firstline
endfunction

" command! -range SortDD call SortRange("@",0)
function! VimSortDD()
    " py rev = vim.eval("a:bRev")
    " '<,'>:Py  SortRangePy(vim.eval("g:vwt#variables#dueDatePattern"), bReverse=0, subpattern=vim.eval("g:vwt#variables#dateFormat"))
    execute "'<,'>"g:_python.'SortRangePy(vim.eval("g:vwt#variables#dueDatePattern"), bReverse=0, subpattern=vim.eval("g:vwt#variables#dateFormat"))'
    execute "silent! normal zm"
    execute "silent! normal zo"
endfunction

function! VimSortDDRev()
    " py rev = vim.eval("a:bRev")
    " '<,'>:Py  SortRangePy(vim.eval("g:vwt#variables#dueDatePattern"), bReverse=1, subpattern=vim.eval("g:vwt#variables#dateFormat"))
    execute "'<,'>".g:_python.'SortRangePy(vim.eval("g:vwt#variables#dueDatePattern"), bReverse=1, subpattern=vim.eval("g:vwt#variables#dateFormat"))'
    execute "silent! normal zm"
    execute "silent! normal zo"
endfunction   

function! VimSortTag()
    " py rev = vim.eval("a:bRev")
    " '<,'>:Py  SortRangePy(vim.eval("g:vwt#variables#tagPattern"), bReverse=0)
    execute "'<,'>".g:_python.'SortRangePy(vim.eval("g:vwt#variables#tagPattern"), bReverse=0)'
    execute "silent! normal zm"
    execute "silent! normal zo"
endfunction

function! VimSortTagRev()
    " py rev = vim.eval("a:bRev")
    ""\#[A-Z]{1,99}"
    " '<,'>:Py  SortRangePy(vim.eval("g:vwt#variables#tagPattern"), bReverse=1)
    execute "'<,'>".g:_python.'SortRangePy(vim.eval("g:vwt#variables#tagPattern"), bReverse=1)'
    execute "silent! normal zm"
    execute "silent! normal zo"
endfunction

function! VwtSortByStartDate() 
    " py rev = vim.eval("a:bRev")
    " '<,'>:Py SortRangePy(vim.eval("g:vwt#variables#startDatePattern"), bReverse=0, subpattern=None)
    " '<,'>:Py SortRangePy(vim.eval("g:vwt#variables#startDatePattern"), bReverse=0, subpattern=vim.eval("g:vwt#variables#startDateSubPattern"))
    " \v\@[0-9- ]*\d{4}-\d{2}-\d{2}\:

    " execute "'<,'>".g:_python.'SortRangePy(vim.eval("g:vwt#variables#startDatePattern"), bReverse=0, subpattern=None)'
    execute "'<,'>".g:_python.'SortRangePy(vim.eval("g:vwt#variables#startDatePattern"), bReverse=0, subpattern=vim.eval("g:vwt#variables#startDateSubPattern"))'
    execute "silent! normal zm"
    execute "silent! normal zo"
endfunction

" this is a bit risky as it does not take the initialization '@' into acount
function! VwtSortByDueDate()
    " '<,'>:Py  SortRangePy("\d{4}-\d{2}-\d{2}:", 0)
    " '<,'>:Py SortRangePy(vim.eval("g:vwt#variables#endDatePattern"), bReverse=0, subpattern=vim.eval("g:vwt#variables#endDateSubPattern"))
    execute "'<,'>".g:_python."SortRangePy(vim.eval(".'"g:vwt#variables#endDatePattern"'."), bReverse=0, subpattern=vim.eval(".'"g:vwt#variables#endDateSubPattern"'."))"

    execute "silent! normal zm"
    execute "silent! normal zo"
endfunction    


" }}}    
