import macros

import options
export options

type Optional*[T] = Option[T]
template `?`*[T](opt: Option[T]): bool =
  opt.isSome
template `?`*[T](opt: Optional[T]): bool =
  opt.isSome
template `!`*[T](opt: Option[T]): untyped =
  opt.get
template `!`*[T](nonOpt: T): untyped =
  some[T](nonOpt)


macro `$!`*(expr: untyped): untyped =
 if expr.kind == nnkDotExpr:
   let base = expr[0]
   let field = expr[1]
   quote do:
     $(`base`.get).`field`
 else:
   quote do:
     $(`expr`.get)
macro `?!`*(expr: untyped): untyped =
  quote do:
    `expr`.isSome and `expr`.get