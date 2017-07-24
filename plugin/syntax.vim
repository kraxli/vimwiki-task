
"""""""""""""""""""""""""""""""""""""""
"  {{{ general syntax / highlighting  "
"""""""""""""""""""""""""""""""""""""""
" see also vim-dway/after/syntax/vimwiki.vim
" http://stackoverflow.com/questions/4097259/in-vim-how-do-i-highlight-todo-and-fixme
" http://stackoverflow.com/questions/1819006/vim-syntax-files-trying-to-undestand-contains
 
" define highlighting
hi hiTodo cterm=bold ctermfg=230 guifg=#FFFF00 gui=bold
" hi hiTodo cterm=bold ctermfg=230 guifg=#faf4c6 gui=bold
hi hiNote cterm=bold ctermfg=148 gui=bold guifg=#b1d631

" define patterns
execute 'syntax match gMatchTodo contained /\(todo\|ToDo\|TODO\):/'
syn match gMatchNote contained /\v(\[A-Z\]|Note|Notes|note|notes):/

" == link color to pattern ==
hi link gMatchTodo MatchParen " Preproc " hiTodo  CursorLineNr MatchParen
hi link gMatchNote Identifier " gui=bold
 
 
" }}} 
