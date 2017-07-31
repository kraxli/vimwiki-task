import vim
from collections import OrderedDict
import re
import datetime as dt
import os


def SortRangePy(pattern, bReverse=0, subpattern=None):
    """TODO: Docstring for SortRangePy.

    :arg1:  ...
        subpattern="\d{4}-\d\d-\d\d"
    :returns: ...

    """

    buf = vim.current.buffer
    # ra = vim.current.range
    raMin = vim.current.range.start
    raMax = vim.current.range.end

    indentStruc = getIndents(rangeStart=raMin, rangeEnd=raMax)
    minIndent = min(indentStruc.values())
    sortingDic = subitemHandler(indentStruc, minIndent)

    linePatternDict = getLineNumberAndMatch(sortingDic, buf, pattern, subpattern)
    linePatternDict = list(OrderedDict(sorted(list(linePatternDict.items()), key=lambda t: t[1].lower())).items())
    # print(linePatternDict)

    if bReverse:
        linePatternDict.reverse()

    newLineOrder = []
    sortedLines = [i[0] for i in linePatternDict]

    [x for x in sortedLines if newLineOrder.extend(sortingDic[x])]

    lineMapping = dict(list(zip(list(range(raMin, raMax + 1)), newLineOrder)))

    lines = {}
    [ll for ll in range(raMin, raMax + 1) if lines.update({ll: buf[ll]})]

    for orgL, newL in lineMapping.items():
        buf[orgL] = lines[newL]

    pass

#######################################################
# Helper Functions
#######################################################


def getSubpattern(search1, subpattern, element=-1):
    # search2 = re.search(subpattern, search1.group())
    searchResultsList = re.findall(subpattern, search1.group())
    # print (searchResultsList)

    if searchResultsList is None or searchResultsList == []:
      search2 = search1.group()
    else:
      # get element (last element: -1)
      search2 = searchResultsList[element]

    # print("search2: ", search2)
    return(search2)


def getLineNumberAndMatch(sortingDic, buf, pattern, subpattern=None):

    linePatternDict = {}
    emptyLines = {}
    defautlString = "{}"

    # .. sort the lines in lines2sort given the sorting pattern
    for ll in list(sortingDic.keys()):
      search1 = re.search(pattern, buf[ll])  # , re.IGNORECASE
      # print("search1: ", search1)

      if (search1 is not None) and (subpattern is not None):
        search2 = getSubpattern(search1, subpattern)
        # print("search2: ", search2)

      elif (search1 is not None) and (subpattern is None):
        search2 = search1.group()

      elif (search1 is None) and (buf[ll] is ""):
        # import string; sorted(list(string.printable))
        # hopefully this is the last ascii character!
        emptyLines.update({ll: "~~~~~~"})
        next
      else:
        search2 = defautlString

      linePatternDict.update({ll: search2})

    linePatternDict.update(emptyLines)
    # print(linePatternDict)
    return linePatternDict


def getIndents(rangeStart, rangeEnd):

    indentStruc = {}
    nL = rangeStart + 1

    while nL <= rangeEnd + 1:
       currentIndent = vim.eval("indent(" + str(nL) + ")")
       indentStruc.update({int(nL)-1: int(currentIndent)})
       nL = nL + 1

    return indentStruc


def subitemHandler(indentStruc, indent2SortOn):

    sortingDic = {}
    nonsortedLines = []
    itemList = []

    for lineNumber, indent in indentStruc.items():
       if indent == indent2SortOn:
          itemList = [lineNumber]
       elif indent > indent2SortOn:
          itemList.append(lineNumber)
       else:
          nonsortedLines = nonsortedLines.append(lineNumber)

       if lineNumber == itemList[0]:
           sortingDic.update({lineNumber: itemList})

    return sortingDic


def getHistory(dateFormat, buffer, vimTaskDate, vimDatePattern):

    today = dt.datetime.today().date()
    pastDates = []

    vim.command("execute 'normal! zM'")

    # collect historical/past dates
    # TODO: search multiple files/buffers: buffer as function argument to cycle over differnt
    #       buffers/files
    for i, line in enumerate(buffer):
      search_res = re.search(vimTaskDate, line)
      if search_res is not None:
        dd_date_bracket = search_res.group()
        date_list = re.findall(vimDatePattern, dd_date_bracket)

        for dd_date in date_list:
          date_object = dt.datetime.strptime(dd_date, dateFormat).date()

          if date_object < today:
            pastDates.append(str(date_object))

    return pastDates


def getNextDays(numDays, buffer, dateFormat, vimTaskDate, vimDatePattern):

    today = dt.datetime.today().date()
    ref_date = today + dt.timedelta(int(numDays))
    vim.command("execute 'normal! zM'")
    # vim.command("%foldclose")

    dateSequence = []

    # collect future dates
    # TODO: search multiple files/buffers: buffer as function argument to cycle over differnt
    #       buffers/files
    for i, line in enumerate(buffer):
      search_res = re.search(vimTaskDate, line)
      if search_res is not None:
        dd_date_bracket = search_res.group()
        dd_date = re.search(vimDatePattern, dd_date_bracket).group()
        date_object = dt.datetime.strptime(dd_date, dateFormat).date()

        if date_object <= ref_date and date_object >= today:
          dateSequence.append(str(date_object))

    return dateSequence


def browseWikiDirectory(filePattern):
    # x = os.path.dirname(__file__)
    vimwikiList = vim.eval("g:vimwiki_list")
    vimwikiPath = vimwikiList[0]["path"]

    if filePattern is "*" or filePattern is "all":
      textFiles = os.listdir(vimwikiPath)

    else:
      textFiles = [f for f in os.listdir(vimwikiPath) if filePattern in f]

    return vimwikiPath, textFiles


def loadBuffer(file):
    buf = ""
    with open(file, "r") as f:
        buf = f.read()

    return buf


# not working: see getPastDatesFromWiki
def getNextDaysFromWiki(numDays, filePattern, dateFormat, vimTaskDate, vimDatePattern):

    filePathList = _getFilePathList(filePattern)
    dateList = []

    for f in filePathList:
      buf = loadBuffer(f)
      dateList.append(getNextDays(numDays, buf, dateFormat, vimTaskDate, vimDatePattern))

    return dateList


def getPastDatesFromWiki(filePattern, dateFormat, vimTaskDate, vimDatePattern):
    today = dt.datetime.today().date()
    # ref_date = today + dt.timedelta(int(numDays))
    dateList = []
    # lengthDatePattern = len(vimDatePattern)

    filePathList = _getFilePathList(filePattern)

    for f in filePathList:
      buf = loadBuffer(f)
      datesOfBuffer = re.findall(vimTaskDate, buf)
      dateList += datesOfBuffer

    # TODO: get only due date dates ...
    # dateList = [d if len(d) < 2 * lengthDatePattern else d.split(" - ")[1] for d in dateList]

    dateList = "//".join(dateList)
    dateList = list(set(re.findall(vimDatePattern, dateList)))

    hist = lambda d: dt.datetime.strptime(d, dateFormat).date() < today
    pastDates = list(filter(hist, dateList))

    return pastDates


def _getFilePathList(filePattern):
    vimwikiPath, textFiles = browseWikiDirectory(filePattern)
    filePathList = [vimwikiPath + f for f in textFiles]
    return filePathList


def get_date_from_today_on(num):

    import datetime as dt

    date = dt.datetime.today() + dt.timedelta(days=num)
    # date_str = date.strftime(dateFormat)
    day = '%02d' % date.day
    month = '%02d' % date.month # date.strftime('%m')
    year = date.strftime('%Y')

    return year, month, day

