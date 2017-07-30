" vim:tabstop=2:shiftwidth=2:expandtab:foldmethod=marker:textwidth=79

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MY FOLDING {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" != : not equal
" !~ : does not match
" =~ : match with
" =~? : matchs with (non-case sensitive)
" ==# : equal (case sensitive)

function! IndentLevel(lnum) " {{{
    return indent(a:lnum) / &shiftwidth
endfunction  "}}}
 
function! NextNonBlankLine(lnum) " {{{
    let numlines = line('$')
    let current = a:lnum + 1
 
    while current <= numlines
        if getline(current) =~? '\v\S'
            return current
        endif
 
        let current += 1
    endwhile
 
    return -2
endfunction   "}}}
 
function! PrevNonBlankLine(lnum)  "{{{
    let numlines = line('$')
    let current = a:lnum - 1
 
    while current <= numlines - 1
        if getline(current) =~? '\v\S' "\s: blank , \S: non-blank
            return current
        endif
 
        let current += 1
    endwhile
 
    return -2
endfunction   " }}}

function! s:find_list_bw(item_list, lnum) "{{{
  let lnum = a:lnum - 1

  while lnum > 1
    let line = getline(lnum)
    for nI in a:item_list 
      let b_match = 0
      if line =~? nI
        "echo "For loop: "a:lnum lnum line nI
        let b_match = 1 
        break
      endif
    endfor 
    if b_match == 1
      break
    endif 
    let lnum -= 1
  endwhile

  return lnum
endfunction "}}} 

function! s:find_pattern_backw(rx_item, lnum) "{{{
  let lnum = a:lnum - 1

  while lnum > 1
    let line = getline(lnum)
    if line =~ a:rx_item
      "    \ || line =~ '^\S'
      break
    endif
    let lnum -= 1
  endwhile

  return [lnum, getline(lnum)]
endfunction "}}}    

function! s:contains_pattern(item_list, lnum) "{{{

  let line = getline(a:lnum)
  for nI in a:item_list 
    let b_match = 0
    " =~  matches , ? case insensitiv 
    if line =~? nI
      return 1 
    endif
  endfor 

  return 0

endfunction  "}}}

" Folding sections and code blocks using expr fold method. {{{
function! VimwikiFoldLevelAll(lnum) "{{{
  " stop if file has one line only
  if line('$') <= 1
    return -1
  endif

  let line = getline(a:lnum)
  let [pnum, pline] = s:find_backward(g:vimwiki_rxListItem, a:lnum)
  let [n_prev_header, l_prev_header] = s:find_pattern_backw(g:vimwiki_rxHeader, a:lnum) "  
  let [nnum, nline] = s:find_forward(g:vimwiki_rxListItem, a:lnum)   	
  let n_prev_blank = s:find_list_bw(["^ *$"], prevnonblank(a:lnum) + 1)
  " match something which should "not be possible" to find next non empty line
  " let [nxt_non_blank_linenum, nxt_non_blank_line] = s:find_forward([" &%9*ç&)2* "], a:lnum) " match everything wich is non-blank 
  let pre_ind = indent(a:lnum-1) / &sw
  let cur_ind = indent(a:lnum) / &sw
  let nxt_ind = indent(a:lnum+1) / &sw
  let level = s:get_li_level(a:lnum) " cur_ind
  let leveln = s:get_li_level(nnum) 
  let levelp = s:get_li_level(pnum) 
  let pre_line = getline(a:lnum - 1)
  let nxt_line = getline(a:lnum + 1)   

  let l_head_list_pat = [g:vimwiki_rxHeader, g:vimwiki_rxListItem]
  let l_head_list_empty_pat = [g:vimwiki_rxHeader, g:vimwiki_rxListItem, "^ *$", "^\s*$"]

  if  l_prev_header !~ "^\s*$" "or \v\s
    let p_head_fold =  vimwiki#u#count_first_sym(l_prev_header)
  else 
    let p_head_fold = 0
  endif 

  " Header/section folding...
  if line =~ g:vimwiki_rxHeader
    let numsym = vimwiki#u#count_first_sym(line)
    return '>'.numsym " start fold with level x

    " Code block folding...
  elseif line =~ '^\s*'.g:vimwiki_rxPreStart
    return 'a1'
  elseif line =~ '^\s*'.g:vimwiki_rxPreEnd.'\s*$'
    return 's1'

    " list folding 
  elseif line =~ g:vimwiki_rxListItem
    " TO DO: should be done dependent on previous list levels
    return  '>'.(p_head_fold + cur_ind + 1) " -1 in case list should be indented by default

    " does not start with a list item or head item
  elseif  s:contains_pattern(l_head_list_empty_pat, a:lnum) == 0 && s:contains_pattern(["^ *$","^\s*$", "^$", g:vimwiki_rxHeader], a:lnum - 1) == 1
    " >X open fold of level X
    return '>'.(p_head_fold + cur_ind + 1) 

  " assign blank lines to a fold (previous or next??) (matches an empty line) 
  elseif line =~ '^ *$' || line =~ "^\s*$" || line =~ "^$" 

    " if  s:contains_pattern([g:vimwiki_rxHeader], a:lnum + 1)
    if  s:contains_pattern([g:vimwiki_rxHeader], NextNonBlankLine(a:lnum))
      return '>'.(p_head_fold + nxt_ind + 1)  
    else 
     return VimwikiFoldLevelAll(NextNonBlankLine(a:lnum))

    " " added later on (line is empty and previous is list):
    " " TODO: use next non blank line fold (NextNonBlankLine ...)
    " " elseif  s:contains_pattern([g:vimwiki_rxListItem], a:lnum - 1) == 1 
    "   " && s:contains_pattern(["^ *$","^\s*$", g:vimwiki_rxHeader], a:lnum + 1) == 0
    "    return '>'.(p_head_fold + nxt_ind + 1)  
    " elseif s:contains_pattern(l_head_list_empty_pat, a:lnum + 1) == 0  
    "   return '>'.(p_head_fold + nxt_ind + 1)  
    " elseif s:contains_pattern(l_head_list_empty_pat, a:lnum - 1) == 0  
    "   "return '>'.(p_head_fold + pre_ind + 1) 
    "    return "="
    "   "elseif  n_prev_blank > pnum
    "   "  return '>'.(p_head_fold + pre_ind + 1)     
    " else
    "   return VimwikiFoldLevelAll(NextNonBlankLine(a:lnum))
    "   " return "=" "foldlevel(prevnonblank(a:lnum))
    endif   

  else
    " echo a:lnum "else ="
    return "="
  endif

endfunction "}}}   


" s:TaskSearch {{{1
" daterange should be a list - [start, end] where start, end are numbers
" relative to today (0 = today, 1 = tomorrow, -1 = yesterday, -7 = this time
" last week). Use a blank list to not filter by date.
function! s:TaskSearch(daterange, ...)
    " Get comparable versions of the dates
    if a:daterange != []
        let startdate = str2nr(strftime(
                    \"%Y%m%d", localtime() + a:daterange[0] * 86400))
        let enddate = str2nr(strftime(
                    \"%Y%m%d", localtime() + a:daterange[1] * 86400))
    endif
    " Use vimgrep to find any task header lines
    if exists("g:todo_files")
        " Clear any existing list - we're using vimgrepadd
        call setloclist(0, [])
        for f in g:todo_files
            try
                exe 'lvimgrepadd /^\s*[A-Z]\+\s/j '.f
            catch /^Vim(\a\+):E480:/
            endtry
        endfor
    else
        try
            lvimgrep /^\s*[A-Z]\+\s/j %
        catch /^Vim(\a\+):E480:/
        endtry
    endif
    let results = []
    " Now filter these
    for d in getloclist(0)
        let matched = 1
        for pat in a:000
            if match(d.text, pat) == -1
                let matched = 0
            endif
        endfor
        if a:daterange != []
            " Filter by date
            let date = s:ParseDate(matchstr(d.text,
                        \'{\d\{4\}-\d\{1,2\}-\d\{1,2\}}'))
            if date < startdate
                let matched = 0
            endif
            if date > enddate
                let matched = 0
            endif
        endif
        if matched
            call add(results, d)
        endif
    endfor
    " Replace the results with the filtered results
    call setloclist(0, results, 'r')
    lw
endfunction
" 1}}}
" s:ShowDueTasks {{{1
function! s:ShowDueTasks(start, end)
    " Start/end are number of days relative to today
    " 0 == today, 1 == tomorrow, -1 == yesterday
    " Make start/end the same number for a single say search
    " Generate a regex to exclude all done states
    let donere = '^\s*\('.join(s:GetDoneStates(), '\|').'\)\@!'
    call s:TaskSearch([a:start, a:end], donere)
endfunction
"1}}}
"==================================================================     
" End FOLDING }}}
"==================================================================     

""""""""""""""""""""""""""""""""""
"  More own functions by Kraxli  "
""""""""""""""""""""""""""""""""""

function! MoveFoldToFileEnd()
  " author: kraxli
  " date: 2015-11-23
  let line_number = line('.')
  " let fold_level = ??? set foldlevel ??? 

"  if foldclosed(line('.')) == -1
"      silent! normal zc
"  endif

  " move current line / fold to end of file
  execute ".m $<cr>" 
  " or line_number."m $<cr>"
  execute "normal! zM"
  execute line_number
  
  " ========================================================
  " restore fold-level instead of following just opening it:
  
  " see function!)OpenFoldIfClosed() in " vim/bundle/vim-dway/plugin/my_function_collection.vim
  if foldclosed(line('.')) > -1
      execute "silent! normal ".foldlevel(line('.'))."zo"
  endif
  " execute "normal! zo"
  
endfunction



" if g:vimwiki_folding ==? 'custom'
"   " DEBUG
"   echo "entering fodling in after for custom"

"   setlocal foldmethod=expr
"   setlocal foldexpr=VimwikiFoldLevelAll(v:lnum)
"   setlocal foldtext=VimwikiFoldText() "
" endif

