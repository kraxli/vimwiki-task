# vimwiki-task
an addon for vimwiki to manage task and todo lists


for vimwiki-task folding style:
  let g:vimwiki_folding = 'custom'

## Functions:
``` vimscript
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
```

## mappings to simplify things
jump to location (quickfix) list/window and close it:
``` vimscript
map <c-l> :lopen<cr>
map <leader>l :lopen<cr>
map <leader>lc :lclose<cr>
map <c-q>q :copen<cr>
map <leader>qc :cclose<cr>
```
move down/up the items:
``` vimscript
noremap <c-s-j> :lne<cr>
noremap <c-k> :lpr<cr>
```

## To Do's

* [ ] clean up
* [ ] make all functions work
* [ ] use python and vim coding standards
 

