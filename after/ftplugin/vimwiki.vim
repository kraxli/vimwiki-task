

if g:vimwiki_folding ==? 'custom'
 
  echo "folding loaded"
  function! VimwikiFoldLevel(lnum) 
    return VimwikiFoldLevelAll(a:lnum)
  endfunction
 
  setlocal foldmethod=expr
  setlocal foldexpr=VimwikiFoldLevelAll(v:lnum)
  setlocal foldtext=VimwikiFoldText() 
endif

