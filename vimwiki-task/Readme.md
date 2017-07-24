
for vimwiki-task folding style:
  let g:vimwiki_folding = 'custom'

Functions:
  ShowPast
  ShowNextDays
    :ShowNextDays 5
  ShowNextWeek
  ShowNextMonth
 
  SortByStartDate
  SortByDueDate
  SortDD     ?
  SortDDRev  ?

  SortTag
  SortTagRev

  GetPatternsWiki
    to search all wiki files use:
      :GetPatternsWiki * pattern1 pattern2
  GetPatternsFile

  GetNextDays arg: numberOfDays
  GetPast  


" jump to quickfix or location list/window
map <c-l> :lopen<cr>
map <leader>lc :lclose<cr>
map <c-q>q :copen<cr>
map <leader>qc :cclose<cr>
noremap <c-s-j> :lne<cr>
noremap <c-k> :lpr<cr>
 
