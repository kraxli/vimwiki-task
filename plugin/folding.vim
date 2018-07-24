
""""""""""""""""""""
"  {{{ more functions  "
""""""""""""""""""""

function! CloseFold()
        silent! normal zc
endfunction   
" }}}


" ============================================================================
" QTFoldText(): Provide the text displayed on a fold when closed. {{{1
"
" This is used by the Vim folding system to find the text to display on fold
" headings when folds are closed. We use this to cause the headings to display
" in an indented fashion matching the tasks themselves.
function! QTFoldText()
    let lines = v:foldend - v:foldstart + 1
    return getline(v:foldstart).' ('.lines.')'
    "return substitute(getline(v:foldstart), "\s", '  ', 'g').' ('.lines.')'
endfunction

" ============================================================================
" CloseFoldIfOpen(): Quietly close a fold only if it is open. {{{1
"
" This is used when automatically opening and closing folded tasks based on
" their status.
function! CloseFoldIfOpen()
    if foldclosed(line('.')) == -1
        silent! normal zc
    endif
endfunction

" ============================================================================
" OpenFoldIfClosed(): Quietly open a fold only if it is closed. {{{1
"
" This is used when automatically opening and closing folded tasks based on
" their status.
function! OpenFoldIfClosed()
    if foldclosed(line('.')) > -1
        execute "silent! normal ".foldlevel(line('.'))."zo"
    endif
endfunction

" ============================================================================
" ShowActiveTasksOnly(): Fold all completed tasks. {{{1
"
" The net result is that only incomplete (active) tasks remain open and
" visible in the list.
function! s:ShowActiveTasksOnly()
    let current_line = line('.')
    execute "normal! zR"
    execute "g/DONE\\|HELD/call CloseFoldIfOpen()"
    call cursor(current_line, 0)
endfunction

function! s:ShowTodayTasksOnly()
    execute "normal! zM"
    execute "g/".strftime("%Y-%m-%d")."/call OpenFoldIfClosed()"
    execute "normal! gg"
endfunction


""""""""""""""
"  commands  "
""""""""""""""
command! ShowToday call PyShowNextDays(0)|normal n

" }}}


" vim:foldmethod=marker:foldlevel=0
