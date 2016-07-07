" Vim syntax file
" Language:     JavaScript
" Maintainer:   Kao Wei-Ko(othree) <othree@gmail.com>
" Last Change:  2015-08-05
" Version:      0.1
" Changes:      Go to https://github.com/othree/es.next.syntax.vim for recent changes.


if version >= 508 || !exists("did_javascript_syn_inits")
  let did_javascript_hilink = 1
  if version < 508
    let did_javascript_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
else
  finish
endif

" decorator
syntax match   javascriptDecorator             /@/ containedin=javascriptClassBlock nextgroup=javascriptDecoratorFuncName
syntax match   javascriptDecoratorFuncName     contained /\<[^=<>!?+\-*\/%|&,;:. ~@#`"'\[\]\(\)\{\}\^0-9][^=<>!?+\-*\/%|&,;:. ~@#`"'\[\]\(\)\{\}\^]*/ nextgroup=javascriptDecoratorFuncCall,javascriptDecorator,javascriptClassMethodName skipwhite skipempty
syntax region  javascriptDecoratorFuncCall     contained matchgroup=javascriptDecoratorParens start=/(/ end=/)/ contains=@javascriptExpression,@javascriptComments nextgroup=javascriptDecorator,javascriptClassMethodName skipwhite skipempty

" class property initializer
syntax match   javascriptClassProperty         contained containedin=javascriptClassBlock /[a-zA-Z_$]\k*\s*=/ nextgroup=@javascriptExpression skipwhite skipempty
syntax keyword javascriptClassStatic           contained static nextgroup=javascriptClassProperty,javascriptMethodName,javascriptMethodAccessor skipwhite

" async await
syntax keyword javascriptAsyncFuncKeyword      async nextgroup=javascriptFuncKeyword,javascriptArrowFuncDef skipwhite
syntax keyword javascriptAsyncFuncKeyword      await nextgroup=@javascriptExpression skipwhite

syntax cluster javascriptExpression            add=javascriptAsyncFuncKeyword

syntax match   javascriptOpSymbol              contained /\(::\)/ nextgroup=@javascriptExpression,javascriptInvalidOp skipwhite skipempty " 1

" Flow
syntax region  flowBlockTypeAnnotation      contained start=/:/ end=/{/me=s-1 contains=@flowType,flowColon nextgroup=javascriptBlock skipwhite skipempty
syntax cluster flowType                     contains=flowKeyword,javascriptIdentifierName,flowPolymorphicType
syntax match   flowColon                    contained /:/
syntax match   flowBrackets                 contained /[<>]/
syntax region  flowPolymorphicType          contained matchgroup=flowBrackets start=/</ end=/>/ contains=@flowType
syntax keyword flowKeyword                  contained any boolean mixed number string void
syntax match   flowClassProperty            contained containedin=javascriptClassBlock /[a-zA-Z_$]\k*:\s*/ nextgroup=@flowType,@javascriptExpression skipwhite skipempty

syntax region  javascriptFuncArg            contained matchgroup=javascriptParens start=/(/ end=/)/ contains=javascriptFuncKeyword,javascriptFuncComma,javascriptDefaultAssign,@javascriptComments nextgroup=flowBlockTypeAnnotation,javascriptBlock skipwhite skipwhite skipempty

if exists("did_javascript_hilink")
  HiLink javascriptDecorator           Statement
  HiLink javascriptDecoratorFuncName   Statement
  HiLink javascriptDecoratorFuncCall   Statement
  HiLink javascriptDecoratorParens     Statement

  HiLink javascriptClassProperty       Normal

  HiLink javascriptAsyncFuncKeyword    Keyword

  " Flow
  HiLink flowBrackets                  Operator
  HiLink flowColon                     Operator
  HiLink flowKeyword                   Keyword
  HiLink flowClassProperty             Normal 

  HiLink flowFuncArg                   Normal 

  delcommand HiLink
  unlet did_javascript_hilink
endif
