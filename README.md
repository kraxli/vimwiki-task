# vimwiki-task
An addon for vimwiki to manage task and todo lists.

It should work with neovim and vim.

I started this project to get into vim plugins, vimscripting, and python programming ... . Still there is hope that it may be useful to manage some of your (small) projects or simply to manage your to do-to list.

## Installation

- Prerequisites: ```vimwiki/vimwiki``` and ```python2```
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

  InsertDueDate / Idd int   : insert a due date in "int" days like @2017-08-03: (only this impelmentation - not customizable) 
  InsertDueRange int_1 int_2 / Idr . . : insert a the date in "int" date range like @2017-08-04 - 2017-08-09:  (only this impelmentation - not customizable) 
```

### Key mappings
``` vim
<leader>td  " task done, adds the date at which the task was done
<leader>tm  " move task to the botom. My last section is 'Tasks Completed'

<leader>li  " includes * [ ] 
 
<leader>dt  " includes a due date of the form @2017-07-27:
<leader>dr  " inculdes a due date of the form @2017-07-27 - 2017-08-09:
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

<s-F4> (normal mode): inserts current time at the beginning of the line
<c-F4> (normal mode): inserts current time at the end of the current line and at the beginning of the line

<F4> inserts today's date (in normal and insert mode)
```

## To-Do's

* [ ] clean up
* [ ] make all functions work
* [ ] use python and vim coding standards
* [?] for ShowPast / ShowNextDays ... match/highlight only due dates (not start dates) or math the range and not dates displayed only
* [X] SortByStartDate: do not sort due dates only lines -> Solved by pattern and handling emtpy lines with "end" pattern '~~~~'
* [ ] highlight active ranges, highlight past due dates
* [ ] function to show all ranges/acitve tasks for a specific date 
* [ ] ...
* [ ] your contribution :-) 
 

