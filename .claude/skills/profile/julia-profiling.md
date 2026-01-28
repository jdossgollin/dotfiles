# Julia Profiling

## Quick Timing

```julia
@time function()           # single run with allocations
@elapsed function()        # just time, returns Float64
```

**Note**: First run includes compilation. Run twice, use second result.

## BenchmarkTools (accurate benchmarking)

```julia
using BenchmarkTools

@btime function($x)        # median time, interpolate inputs with $
@benchmark function($x)    # full statistics
```

Always interpolate external variables with `$` to avoid globals.

## Profiling

### Built-in Profiler

```julia
using Profile

@profile function()
Profile.print()            # text output
Profile.clear()            # reset for next profile
```

### ProfileView (visual)

```julia
using ProfileView
@profview function()       # opens flame graph
```

### VS Code

Use Julia extension's `@profview` integration.

## Type Stability

Type instability is the #1 Julia performance issue.

```julia
@code_warntype function(x)   # red = type unstable
```

### JET.jl (static analysis)

```julia
using JET
@report_opt function(x)    # optimization issues
@report_call function(x)   # potential errors
```

## Memory Profiling

```julia
@allocated function()      # bytes allocated
```

For detailed allocation tracking:

```julia
using Profile
Profile.Allocs.@profile function()
```

## Common Bottlenecks

- **Type instability** → add type annotations, use concrete types
- **Global variables** → pass as arguments or use `const`
- **Abstract containers** → use concrete element types `Vector{Float64}` not `Vector{Any}`
- **Allocations in hot loop** → pre-allocate, use `@views`
- **Column-major access** → iterate in column order for arrays

## Optimization Checklist

1. Check `@code_warntype` - no red/yellow
2. Avoid globals in hot paths
3. Use `@views` for array slices
4. Pre-allocate output arrays
5. Consider `@inbounds` for tight loops (after verifying correctness)
