# vimwiki-task
an addon for vimwiki to manage task and todo lists.

I started this project to get into vim plugin and python programming ... . Still there is hope that it may be useful for you to manage some of your (small) project or simply your to do to list,

## Documentation
for vimwiki-task folding style:
  let g:vimwiki_folding = 'custom'

### Functions:
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

### Key mappings
<leader>td : task done, adds the date at which the task was done
<leader>tm : move task to the botom. My last section is "completed tasks"


### mappings to put to your .vimrc/init.vim file to help simplify things
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

### To Do's

* [ ] clean up
* [ ] make all functions work
* [ ] use python and vim coding standards
* [ ] and much more (please contribute! :-) )
 

