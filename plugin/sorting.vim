"""""""""""""""""""""""
" {{{ Sort Folded Lines  "
"""""""""""""""""""""""   le

function! s:rangeSize() range
    return a:lastline - a:firstline
endfunction

" command! -range SortDD call SortRange("@",0)
function! VimSortDD()
    " py rev = vim.eval("a:bRev")
    '<,'>:py  SortRangePy(vim.eval("g:vwt#variables#dueDatePattern"), bReverse=0, subpattern=vim.eval("g:vwt#variables#dateFormat"))
    execute "silent! normal zm"
    execute "silent! normal zo"
endfunction

function! VimSortDDRev()
    " py rev = vim.eval("a:bRev")
    '<,'>:py  SortRangePy(vim.eval("g:vwt#variables#dueDatePattern"), bReverse=1, subpattern=vim.eval("g:vwt#variables#dateFormat"))
    execute "silent! normal zm"
    execute "silent! normal zo"
endfunction   

function! VimSortTag()
    " py rev = vim.eval("a:bRev")
    '<,'>:py  SortRangePy(vim.eval("g:vwt#variables#tagPattern"), bReverse=0)
    execute "silent! normal zm"
    execute "silent! normal zo"
endfunction

function! VimSortTagRev()
    " py rev = vim.eval("a:bRev")
    ""\#[A-Z]{1,99}"
    '<,'>:py  SortRangePy(vim.eval("g:vwt#variables#tagPattern"), bReverse=1)
    execute "silent! normal zm"
    execute "silent! normal zo"
endfunction

function! VwtSortByStartDate()
    " py rev = vim.eval("a:bRev")
    '<,'>:py SortRangePy(vim.eval("g:vwt#variables#startDatePattern"), bReverse=0, subpattern=vim.eval("g:vwt#variables#startDateSubPattern"))
    " \v\@[0-9- ]*\d{4}-\d{2}-\d{2}\:
    execute "silent! normal zm"
    execute "silent! normal zo"
endfunction

" this is a bit risky as it does not take the initialization '@' into acount
function! VwtSortByDueDate()
    '<,'>:py SortRangePy(vim.eval("g:vwt#variables#endDatePattern"), bReverse=0, subpattern=vim.eval("g:vwt#variables#endDateSubPattern"))
    " '<,'>:py  SortRangePy("\d{4}-\d{2}-\d{2}:", 0)
    execute "silent! normal zm"
    execute "silent! normal zo"
endfunction    


" }}}    