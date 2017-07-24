let g:vimwiki_task_root = expand('<sfile>:p:h:h')
set rtp+=g:vimwiki_task_root  

if has('python3')
   py3 import sys; import vim; sys.path.insert(0, vim.eval('g:vimwiki_task_root')) 
   py3 from pythonVWT.vimwiki_task import SortRangePy, getHistory, getNextDays, browseWikiDirectory, loadBuffer, getNextDaysFromWiki, getPastDatesFromWiki
endif

if has('python')
   python import sys; import vim; sys.path.insert(0, vim.eval('g:vimwiki_task_root')) 
   python from pythonVWT.vimwiki_task import SortRangePy, getHistory, getNextDays, browseWikiDirectory, loadBuffer, getNextDaysFromWiki, getPastDatesFromWiki
endif

if !has('python') && !has('python3')
   echo "make sure python is supported"
endif

