# vimwiki-task
An addon for vimwiki to manage task and todo lists.

It should work with neovim and vim.

I started this project to get into vim plugins, vimscripting, and python programming ... . Still there is hope that it may be useful to manage some of your (small) projects or simply to manage your to do-to list.

## Installation

- Prerequisites: ```vimwiki/vimwiki```
- using vim-plug: ``` plug 'kraxli/vimwiki-task' ```


## Documentation
for ```vimwiki-task folding style```:
``` vim
  let g:vimwiki_folding = 'custom'
```  

### Functions:
``` vim
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
``` vim
<leader>td  " task done, adds the date at which the task was done
<leader>tm  " move task to the botom. My last section is 'completed tasks'
```

### mappings to put to your .vimrc/init.vim file to help simplify things
jump to location (quickfix) list/window and close it:
``` vim
map <c-l> :lopen<cr>
map <leader>l :lopen<cr>
map <leader>lc :lclose<cr>
map <c-q>q :copen<cr>
map <leader>qc :cclose<cr>
```
move down/up the items:
``` vim
noremap <c-s-j> :lne<cr>
noremap <c-k> :lpr<cr>
```

## To-Do's

* [ ] clean up
* [ ] make all functions work
* [ ] use python and vim coding standards
* [ ] much more functionality 
* [ ] your contribution :-) 
 

