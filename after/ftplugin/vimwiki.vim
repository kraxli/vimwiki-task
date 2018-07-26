

if g:vimwiki_folding ==? 'custom' || g:vimwiki_folding ==? 'customAll'

  setlocal foldmethod=expr
  setlocal foldtext=VimwikiFoldText()
endif

if g:vimwiki_folding ==? 'custom'

  function! VimwikiFoldLevel(lnum)
    return VimwikiFoldHeaderIndent(a:lnum)
  endfunction

  setlocal foldexpr=VimwikiFoldHeaderIndent(v:lnum)
endif

if g:vimwiki_folding ==? 'customAll'

  function! VimwikiFoldLevel(lnum)
    return VimwikiFoldLevelAll(a:lnum)
  endfunction

  setlocal foldexpr=VimwikiFoldLevelAll(v:lnum)
endif

