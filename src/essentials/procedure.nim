type
  Procedure*[T] = object
    value*: T
    isEmpty*: bool = true

{.experimental: "callOperator".}
template `()`*[T](cb: Procedure[T], args: varargs[untyped]): auto =
  if cb.isEmpty:
    raise newException(ValueError, "Attempting to call an empty Procedure")
  when compiles(cb.value()):
    cb.value()
  else:
    cb.value(args)

proc newProcedure*[T](procValue: T): Procedure[T] =
  result.value = procValue
  result.isEmpty = false