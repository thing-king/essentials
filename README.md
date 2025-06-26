# essentials

Essential patterns and utilities.

## Modules

### `optional`

Shorthand and syntax sugar for working with `Option` types:

```nim
 ? opt    ## returns true if opt is Some
 ! opt    ## unwraps opt, errors if None
$! opt.field  ## stringifies an unwrapped field
?! opt    ## returns true if opt is Some, unwraps
```

---

### `procedural`

Wrapper type for holding procedures in **untyped macros**, where direct procedure literals are rejected during macro parsing. This allows deferring procedure definition while still storing it as part of a macro call.

#### Example

In Nim, even within an `untyped` macro, you *cannot* write:

```nim
aCommand something: proc(a: int, b: int): int
```

because `proc` syntax isn’t valid as a direct AST node during parsing.

Instead, use:

```nim
aCommand something: Procedure[proc(a: int, b: int): int]
```

You can set the procedure value later:

```nim
let cb = newProcedure(proc(a: int, b: int): int = a + b)
echo cb(1, 2)
```

Calling an unset `Procedure` raises an error.
