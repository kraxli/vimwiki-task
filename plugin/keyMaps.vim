
nnoremap <leader>li "='* [ ] '<cr>Pa
 
" http://vim.wikia.com/wiki/Insert_current_date_or_time
nnoremap <leader>dt  "='@'.strftime("%Y-%m-%d").':'<CR>P
nnoremap <leader>dr "='@'.strftime("%Y-%m-%d").' - '.strftime("%Y-%m-%d").':'<CR>P


" see my mail for more time maping: https://mail.google.com/mail/u/0/#inbox/1513384ef6a2d516
noremap <leader>td $"=strftime(" [@DONE: %Y-%m-%d]")<CR>P :VimwikiToggleListItem<cr>
" noremap <leader>td $ "=strftime(" <@DONE: %Y-%m-%d>")<CR>P :VimwikiToggleListItem<cr>
nmap <leader>do <leader>td


" move tasked-done (closed folds) to end of file 
" nnoremap <leader>td :.m $<cr>
nnoremap <leader>tm :call MoveFoldToFileEnd()<cr>

" <leader>tm on visual block (but the following is rather messy and extremly slow):
vnoremap <leader>tm :call MoveFoldToFileEnd()<cr> 


"    " Public mappings {{{1
" if  ! g:quicktask_no_mappings && ! exists('b:quicktask_did_mappings')
"     nmap <unique><buffer> <Leader>tv  <Plug>SelectTask
"     nmap <unique><buffer> <Leader>tD  <Plug>TaskComplete
"     let b:quicktask_did_mappings = 1
" endif   "
"   }}}

nnoremap <s-F4> ^"=strftime("%H:%M")."-"<CR>P$ 
" nnoremap <c-F4> ^E"=strftime("%H:%M")<CR>po<esc>^^
nnoremap <c-F4> ^E"=strftime("%H:%M")<CR>po<esc>^^"=strftime("%H:%M")."- "<CR>Pa
" nnoremap <c-F4> :s/\(\d{2}:\d{2}\)/\1"=strftime("%H:%M")<CR>P 

nnoremap <F4> "=strftime("%Y-%m-%d")<CR>p 
inoremap <F4> <C-R>=strftime("%Y-%m-%d")<CR>
