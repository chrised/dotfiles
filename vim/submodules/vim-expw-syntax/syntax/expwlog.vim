if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif


"set syntax=

syn match   expwHost         contained containedin=expwDate ' \(\S\+\)'
syn match   expwApp          ' \(\a[^:" ]\+:\)'
syn match   expwDate         contains=expwHost '^\d\d\d\d\-\d\d\-\d\dT\d\d:\d\d:\d\d+\d\d:\d\d \S\+'

syn match   expwKeyVal       contains=expwText,expwKey,expwUTC '\( Level\)\@!\&\( Module\)\@!\& \S\+=".[^"]\+"'
syn match   expwUTC          contained containedin=expwKeyVal '"\d\d\d\d\-\d\d\-\d\d \d\d:\d\d:\d\d,\d\+"'
syn match   expwText         contained containedin=expwKeyVal '"\(\d\d\d\d\-\d\d\-\d\d \d\d:\d\d:\d\d,\d\+\)\@!\&.[^"]\+"'
syn match   expwKey          contained containedin=expwKeyVal '\S\+='

syn match   expwLevel        contains=expwDebug,expwInfo,expwError,expwWarning  'Level="\u\+":'
syn match   expwLevel        contains=expwDebug,expwInfo,expwError,expwWarning  'Level="\u\+"'
syn match   expwLevel        contains=expwDebug,expwInfo,expwError,expwWarning,expwLevNum  'Level="\d\+"'

syn keyword expwDebug        containedin=expwLevel   DEBUG
syn keyword expwInfo         containedin=expwLevel   INFO
syn keyword expwError        containedin=expwLevel   ERROR FATAL
syn keyword expwWarning      containedin=expwLevel   WARN
syn match expwLevNum         contained containedin=expwLevel   '\d'

syn match   expwModule       display contains=expwModuleMod,expwComStart,expwComMid,expwComEnd 'Module="\S\+"'
syn match   expwModuleMod    contained containedin=expwModule 'Module'
syn match   expwComStart     contained containedin=expwModule 'developer\|network'
syn match   expwComMid       contained containedin=expwModule '\.\l[^\." ]\+'
syn match   expwComEnd       contained containedin=expwModule '\.\l[^\. ]\+"'
syn match   expwComCatch     contained containedin=expwModule '\l[^\. ]\+"'


  "let did_expwlog_syntax_inits = 1
hi link expwDate         Comment
hi link expwUTC          Comment
hi link expwHost         Keyword
hi link expwApp          Type
hi link expwLevNum       Error
hi link expwError        Error
hi link expwWarning      Error
hi link expwDebug        Debug
hi link expwInfo         Comment
hi link expwComStart     Folded
hi link expwComMid       Comment
hi link expwComEnd       rubyFunction
hi link expwComCatch     rubyFunction
hi link expwText         String
hi link expwKey          Keyword
hi link expwModuleMod    Keyword
hi link expwLevel        Keyword

let b:current_syntax="expwlog"
