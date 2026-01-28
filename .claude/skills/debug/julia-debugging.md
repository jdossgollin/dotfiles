# Julia Debugging

## Print Debugging

```julia
@show variable        # prints "variable = value"
@info "message" x y   # structured logging with variables
println("DEBUG: x=$x, type=$(typeof(x))")
```

## Debugger.jl

```julia
using Debugger

@enter function(args)    # step into function
@run function(args)      # run with breakpoints
```

### Debugger Commands

```
n          next line
s          step into
c          continue
o          step out
bt         backtrace
fr N       go to frame N
q          quit
```

### Breakpoints

```julia
@bp          # in code
breakpoint(function, line)  # programmatic
```

## Infiltrator.jl (lightweight)

```julia
using Infiltrator

function buggy()
    x = compute()
    @infiltrate       # drops into REPL here
    process(x)
end
```

## Logging

```julia
using Logging

@debug "detailed info" x y
@info "operation completed"
@warn "unexpected state"
@error "failed" exception=(err, catch_backtrace())

# Set log level
ENV["JULIA_DEBUG"] = "Main"  # enable @debug for Main module
```

## Exception Handling

```julia
try
    failing_code()
catch e
    @error "Failed" exception=(e, catch_backtrace())
    # or
    showerror(stderr, e, catch_backtrace())
end
```

## Type Debugging

```julia
typeof(x)             # concrete type
supertype(typeof(x))  # parent type
@code_warntype f(x)   # check type stability
```

## Common Julia Bugs

- **Type instability** → `@code_warntype` shows red/yellow
- **Global variables in hot code** → pass as arguments
- **Array bounds** → use `@boundscheck` or check indices
- **Nothing where value expected** → check for `isnothing()`
- **Method ambiguity** → check `methods(function)` for conflicts
- **World age** → function defined after its use in another function
