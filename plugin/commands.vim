""-----------------------------------------------------------------------------
"" {{{  vimwiki-task-after commands
""-----------------------------------------------------------------------------


command! -range SortByStartDate :call VwtSortByStartDate()
command! -range SortByDueDate :call VwtSortByDueDate()

" command! -range SortDD '<,'>:py SortRangePy("\[\s*(DD|Due): \d{4}-\d\d-\d\d\s*\]",0)
command! -range SortDD :call VimSortDD()
command! -range SortDDRev :call VimSortDDRev()

" command! -range SortTag '<,'>:py SortRangePy("\#[A-Z]{1,99}",0)
command! -range SortTag :call VimSortTag()
command! -range SortTagRev :call VimSortTagRev()
 

" nnoremap <silent> <leader>sw :execute ShowNextWeek()<cr>
" nnoremap <silent> <leader>sm :call ShowNextMonth()<cr>
 
" command! ShowPast :call PyShowPast()
" command! ShowNextWeek :call PyShowNextDays(7)
" command! ShowNextMonth :call PyShowNextDays(31)
" command! -nargs=1 ShowNextDays :call PyShowNextDays(<f-args>)   

command! -nargs=1 ShowNextDays call PyShowNextDays(<f-args>)|normal n
command! ShowPast call PyShowPast()|normal n
" command! -nargs=* ShowPast call PyShowPast()|normal n
command! ShowNextWeek call PyShowNextDays(7)|normal n 
command! ShowNextMonth call PyShowNextDays(31)|normal n  

command! -nargs=* GetTagsFile call GetTagsFile(<f-args>)
command! -nargs=* GetTagsWiki call GetTagsWiki(<f-args>)
command! -nargs=* GetPatternsFile call GetPatternsFile(<f-args>)
command! -nargs=* GetPatternsWiki call GetPatternsWiki(<f-args>)
command! GetPast call GetPast()

command! -nargs=1 GetNextDays call GetNextDays(<f-args>)
command! -nargs=* GetNextDaysWiki call GetNextDaysWiki(<f-args>)
command! -nargs=1 GetHistoryWiki call GetHistoryWiki(<f-args>)


command! -nargs=1  DueDate call DueDate(<f-args>)


" }}}  

" vim:foldmethod=marker:foldlevel=0
 
