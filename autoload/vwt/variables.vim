
if !exists("g:vwt#variables#dateFormat")
    let  g:vwt#variables#dateFormat =  "\\d{4}-\\d{2}-\\d{2}"
endif   

if !exists("g:vwt#variables#pythonDateFormat")
   let g:vwt#variables#pythonDateFormat = "%Y-%m-%d"
endif

if !exists("g:vwt#variables#dueDateIndicator")
   let g:vwt#variables#dueDateIndicator = "@"
endif    

if !exists("g:vwt#variables#dateRangeSeperator")
   let g:vwt#variables#dateRangeSeperator = "-"
endif


if !exists("g:vwt#variables#tagPattern")
    " let  g:vwt#variables#tagPattern =  "\\m:[a-zA-Z0-9]\\+:" " \#[A-Z]{1,99}
    let  g:vwt#variables#tagPattern =  ":\\S+:" " \#[A-Z]{1,99}
endif   

if !exists("g:vwt#variables#startDatePattern")
    " let  g:vwt#variables#startDatePattern = g:vwt#variables#dueDateIndicator."[0-9".g:vwt#variables#dateRangeSeperator." ]*"
    let  g:vwt#variables#startDatePattern = g:vwt#variables#dueDateIndicator."\\s*".g:vwt#variables#dateFormat."\\s*".g:vwt#variables#dateRangeSeperator."\\s*".g:vwt#variables#dateFormat
endif   

if !exists("g:vwt#variables#startDateSubPattern")
    let  g:vwt#variables#startDateSubPattern = g:vwt#variables#dueDateIndicator."\\s*".g:vwt#variables#dateFormat."\\s*".g:vwt#variables#dateRangeSeperator."\\s*".g:vwt#variables#dateFormat

   " let g:vwt#variables#startDateSubPattern = g:vwt#variables#dueDateIndicator.g:vwt#variables#dateFormat
   "."\\s*".g:vwt#variables#dateRangeSeperator."\\s*".g:vwt#variables#dateFormat
endif

if !exists("g:vwt#variables#endDatePattern")
    " let  g:vwt#variables#endDatePattern = "@[0-9- ]*\\d{4}-\\d{2}-\\d{2}:"
    let  g:vwt#variables#endDatePattern = "@[0-9".g:vwt#variables#dateRangeSeperator." ]*".g:vwt#variables#dateFormat
endif   

if !exists("g:vwt#variables#dueDatePattern")
    let  g:vwt#variables#dueDatePattern = g:vwt#variables#endDatePattern
    "  \[\s*(DD|Due): \d{4}-\d\d-\d\d\s*\]
endif   

if !exists("g:vwt#variables#endDateSubPattern")
    let  g:vwt#variables#endDateSubPattern = g:vwt#variables#dateFormat
    " \d{4}-\d{2}-\d{2}:
endif   

" should only due date be shown by the function ShowPast, ...
if !exists("g:vwt#variables#DueDatesOnly")  
   let g:vwt#variables#dueDatesOnly = 0
endif




