""-----------------------------------------------------------------------------
"" {{{  vimwiki-task-after commands
""-----------------------------------------------------------------------------


command! -range VwtSortByStartDate :call VwtSortByStartDate()
command! -range VwtSortByDueDate :call VwtSortByDueDate()

" command! -range SortDD '<,'>:py SortRangePy("\[\s*(DD|Due): \d{4}-\d\d-\d\d\s*\]",0)
command! -range VwtSortDD :call VimSortDD()
command! -range VwtSortDDRev :call VimSortDDRev()

" command! -range SortTag '<,'>:py SortRangePy("\#[A-Z]{1,99}",0)
command! -range VwtSortTag :call VimSortTag()
command! -range VwtSortTagRev :call VimSortTagRev()
 

" nnoremap <silent> <leader>sw :execute ShowNextWeek()<cr>
" nnoremap <silent> <leader>sm :call ShowNextMonth()<cr>
 
" command! ShowPast :call PyShowPast()
" command! ShowNextWeek :call PyShowNextDays(7)
" command! ShowNextMonth :call PyShowNextDays(31)
" command! -nargs=1 ShowNextDays :call PyShowNextDays(<f-args>)   

command! -nargs=1 VwtShowNextDays call PyShowNextDays(<f-args>)|normal n
command! VwtShowPast call PyShowPast()|normal n
" command! -nargs=* ShowPast call PyShowPast()|normal n
command! VwtShowNextWeek call PyShowNextDays(7)|normal n 
command! VwtShowNextMonth call PyShowNextDays(31)|normal n  

command! -nargs=* VwtGetTagsFile call GetTagsFile(<f-args>)
command! -nargs=* VwtGetTagsWiki call GetTagsWiki(<f-args>)
command! -nargs=* VwtGetPatternsFile call GetPatternsFile(<f-args>)
command! -nargs=* VwtGetPatternsWiki call GetPatternsWiki(<f-args>)
command! VwtGetPast call GetPast()

command! -nargs=1 VwtGetNextDays call GetNextDays(<f-args>)
command! -nargs=* VwtGetNextDaysWiki call GetNextDaysWiki(<f-args>)
command! -nargs=1 VwtGetHistoryWiki call GetHistoryWiki(<f-args>)


command! -nargs=1  InsertDueDate call InsertDueDate(<f-args>)
command! -nargs=1  Idd call InsertDueDate(<f-args>)
command! -nargs=*  InsertDueRange call InsertDueRange(<f-args>)
command! -nargs=*  Idr call InsertDueRange(<f-args>)


" }}}  

" vim:foldmethod=marker:foldlevel=0
 
