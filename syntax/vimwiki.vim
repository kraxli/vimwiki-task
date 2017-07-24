" =======================================================
"
" =======================================================

let vwtProjectPrefix = '+'
let vwtTagPattern = '/:[A-Za-z0-9]+:/'

" define colors

" http://alvinalexander.com/linux/vi-vim-editor-color-scheme-syntax
hi hiFolks guifg=#80a0ff ctermfg=9  " PreProc Statement hiFolks PemenuSel  Special
hi hiMe gui=underline,bold guifg=#80a0ff cterm=underline,bold ctermfg=9
hi hiToday gui=underline,bold guifg=#ff9800 cterm=underline,bold ctermfg=208
hi hi4TaskDone gui=italic guifg=#928374 cterm=italic ctermfg=242  " ctermfg=245


syn match VimwikiTaskTaskDone /^\s*\* \[X\].*$/
hi link VimwikiTaskTaskDone hi4TaskDone

syn match VimwikiDateAdded /\v\[.*:\s*\d{4}-\d\d-\d\d\]/
" syn match VimwikiDateAdded /\v\[\d{4}-\d\d-\d\d\]/
syn match VimwikiDateAdded /\v\d{4}-\d\d-\d\d/
hi link VimwikiDateAdded Special
" DiffChange Identifier VimwikiHeader4 CursorLineNr WarningMsg Special Keyword Constant
" VimwikiHeader4/6  / ColorColumn / lCursorLine / MatchParen / DiffChange /

syntax match vimwikiTag /\v\#[A-Za-z0-9]+/
execute 'syntax match vimwikiTag '.vwtTagPattern
hi link vimwikiTag CursorLineNr

execute 'syntax match vimwikiProject /\v\'.vwtProjectPrefix.'[A-Za-z0-9_]+/'
hi link vimwikiProject Include
" pandocHeading  Title                             

" Timing needs to come after Project!
syn match VimwikiTaskTiming  /\v\d{2}:\d\d/
syn match VimwikiTaskTiming  /\v\d{4}-\d\d-\d{2}/
syn match VimwikiTaskTiming  /\v\d:\d\d/
syn match VimwikiTaskTiming  /\v\d:\d\d-/
syn match VimwikiTaskTiming  /\v\d{2}:\d\d-/
syn match VimwikiTaskTiming  /\v\d{2}:\d\d-\d{2}:\d\d/
syn match VimwikiTaskTiming  /\v\@\d{4}-\d\d-\d\d/
syn match VimwikiTaskTiming  /\v\@\d{4}-\d\d-\d\d\:/
syn match VimwikiTaskTiming  /\v\@\d{4}-\d\d-\d\d\s*-\s*\d{4}-\d\d-\d\d\:/
hi link VimwikiTaskTiming Special 
" DiffChange VimwikiHeader4

syntax match vimwikiTaskItem  /\v\#[A-Za-z0-9]+/
hi link vimwikiTaskItem CursorLineNr 

" stream swim-line / stream
syntax match vimwikiTaskStream  /\v\>\>[A-Za-z0-9]+/
hi link vimwikiTaskStream Type


" DiffDelete      

" [\s,]*
" syntax match vimwikiTaskFolk /\v\&[A-Za-z][a-z]+/
syntax match vimwikiTaskFolk /\v\s\&\S{2,}/ " \{2,}: at least two \S (capital S): non white space characters changed 2017-06-25
hi link vimwikiTaskFolk hiFolks 


" vimwikiTaskMe needs to come after vimwikiTaskFolk
" syntax match vimwikiTaskMe /\c\(\me\|&ME\|&Me\)/ " \c: not casesensitive
syntax match vimwikiTaskMe /\c\<&me\>/ " \c: not casesensitive
hi link vimwikiTaskMe hiMe

syntax match vimwikiTaskFootNote  /\v\[\^\d+\]:*/
hi link vimwikiTaskFootNote SignColumn

syntax match vimwikiTaskMilestone /\v\~[A-Za-z]+/
hi link vimwikiTaskMilestone pandocDefinitionTerm
" Special, DiffChange, DiffAdd , DiffDelete

" syn match VimwikiHeader2Date /\v\d{4}-\d\d-\d\d( \d\d:\d\d)?/ contained containedin=VimwikiHeader2
" syn match VimwikiHeader3Date /\v\d{4}-\d\d-\d\d( \d\d:\d\d)?/ contained containedin=VimwikiHeader3
"  syn match VimwikiHeader4Date /\v\d{4}-\d\d-\d\d( \d\d:\d\d)?/ contained containedin=VimwikiHeader4
" =======================================================
function! Check4TaskedStatus()
py << EOF
import vim, re
lnum = int(vim.eval("line('.')"))
sw = vim.eval("&sw")
indent_level = vim.eval("(indent(" + str(lnum) + ") / " + sw + ")")

check = 1
nL = 0

pattern0 = "\*\s\[(?!\s+)\]"
pattern1 = "\*\s\[\s+\]"

while check == 1:
   nL = nL + 1
   indent = vim.eval("(indent(" + str(lnum - nL) + ") / " + sw + ")")
   if indent < indent_level:

      line = vim.eval("getline(" + str(lnum - nL) +")")

      if re.search(pattern0, line) is not None:
         check = 0
         vim.command("return 1")

      elif re.search(pattern1, line) is not None: 
         vim.command("return 2")
         # vim.command("return 0")

      else:
         vim.command("return 3")
         # vim.command("return 0")

   if nL > 20:
      break 
 
EOF
endfunction 
"
execute 'syntax match vimwikiToday /' .strftime("%Y-%m-%d"). '/'
execute 'syntax match vimwikiToday /\[DD: *' .strftime("%Y-%m-%d"). '\]/'
execute 'syntax match vimwikiToday /@'.strftime("%Y-%m-%d").'/'
execute 'syntax match vimwikiToday / \='.strftime("%Y-%m-%d").':/'
execute 'syntax match vimwikiToday /\s\='.strftime("%Y-%m-%d").':/'
execute 'syntax match vimwikiToday /\v\@'.strftime("%Y-%m-%d").'\s=[-]\s=\d{4}-\d\d-\d\d\s=\:/'
execute 'syntax match vimwikiToday /\v\@\d{4}-\d\d-\d\d\s=[-]\s='.strftime("%Y-%m-%d").'\s=\:/'
" execute 'syntax match vimwikiToday /\v-\s*'.strftime("%Y-%m-%d").'\:/'
hi link vimwikiToday hiToday 
" CursorLineNr WarningMsg Special Keyword Constant
" highlight vimwikiToday guibg=yellow guifg=black gui=bold
"
syn match VimwikiDone /\v\<\@DONE.*\d{4}-\d\d-\d\d\>/
" \\@\d{4}-\d\d-\d\d\
hi link VimwikiDone Type
"Type VimwikiHeader4


" execute 'syntax match vimwikiTodos /\v[A-Z]{2,33}:/'
execute 'syntax match vimwikiTodos /\(todo\|To Do\|to do\|TODO\|TO DO\|ToDo\):*/'

" == link color to pattern ==
hi link vimwikiTodos Todo
hi link Todo hiTodo

 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" section highlighting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" You can set up different colors for each header level: >
hi VimwikiHeader1 guifg=Red gui=underline,bold ctermfg=Red cterm=underline,bold
hi VimwikiHeader2 guifg=Red gui=underline,bold ctermfg=Red cterm=underline
hi VimwikiHeader3 guifg=Red ctermfg=Red
hi VimwikiHeader4 guifg=LightRed gui=underline,bold ctermfg=LightRed cterm=underline,bold
hi VimwikiHeader5 guifg=LightRed gui=underline ctermfg=LightRed cterm=underline
hi VimwikiHeader6 guifg=LightRed ctermfg=LightRed
" hi VimwikiHeader1 guifg=#FF0000 ctermfg=LightRed cterm=underline,bold
" hi VimwikiHeader2 guifg=DarkCyan  " #00FF00 DarkCyan  #427b58 GruvboxBlueSign GruvboxBlue

