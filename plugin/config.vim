let g:vimwiki_task_root = expand('<sfile>:p:h:h')
set rtp+=g:vimwiki_task_root  

" execute (has('python3') ? 'py3file' : 'pyfile') script_path

function! PyImports()
Py << EOF
import sys, vim 
sys.path.insert(0, vim.eval('g:vimwiki_task_root')) 
from pythonVWT.vimwiki_task import SortRangePy, getHistory, getNextDays, browseWikiDirectory, loadBuffer, getNextDaysFromWiki, getPastDatesFromWiki

EOF
endfunction

if has('python3')
   " py3 import sys; import vim; sys.path.insert(0, vim.eval('g:vimwiki_task_root')) 
   " py3 from pythonVWT.vimwiki_task import SortRangePy, getHistory, getNextDays, browseWikiDirectory, loadBuffer, getNextDaysFromWiki, getPastDatesFromWiki
  command! -nargs=* Py py3 <args>
  call PyImports()
endif

if has('python')
   " python import sys; import vim; sys.path.insert(0, vim.eval('g:vimwiki_task_root')) 
   " python from pythonVWT.vimwiki_task import SortRangePy, getHistory, getNextDays, browseWikiDirectory, loadBuffer, getNextDaysFromWiki, getPastDatesFromWiki
  command! -nargs=* Py python <args>
  call PyImports()
endif

if !has('python') && !has('python3')
   echo "make sure python is supported"
endif


let s:ultisnipVimwikiDir = g:vimwiki_task_root."/UltiSnips"
let s:snippsVimwikiDir = g:vimwiki_task_root."/snippets"


if !exists("g:UltiSnipsSnippetsDir")
	let g:UltiSnipsSnippetsDir = ['UltiSnips', s:ultisnipVimwikiDir]
else
	let g:UltiSnipsSnippetsDir = g:UltiSnipsSnippetsDir + ['UltiSnips', s:ultisnipVimwikiDir]
endif  


let g:neosnippet#snippets_directory = get(g:,'neosnippet#snippets_directory',
      \ '')

      
if empty(g:neosnippet#snippets_directory)
  let g:neosnippet#snippets_directory = [s:snippsVimwikiDir]
  
else
    if type(g:neosnippet#snippets_directory) == 1
      let g:neosnippet#snippets_directory = g:neosnippet#snippets_directory.','.s:snippsVimwikiDir
    elseif  type(g:neosnippet#snippets_directory) == 3
      let g:neosnippet#snippets_directory = add(g:neosnippet#snippets_directory, s:snippsVimwikiDir)
    endif

endif
