---
paths:
  - "**/*.jl"
  - "**/Project.toml"
  - "**/Manifest.toml"
---

# Julia

## Package Management

- NEVER edit Project.toml or Manifest.toml manually
- Always use Pkg: `Pkg.add()`, `Pkg.rm()`, `Pkg.update()`, `Pkg.compat()`

## Code Style

- Use JuliaFormatter.jl (run via CLI, not manual edits)
- Use Makie.jl for plotting unless explicitly instructed otherwise

## Variable Naming

- Unicode is fine (α, β, Δ) when meaning is obvious from context
- For functions with many arguments or non-obvious parameters: use descriptive names
- OK: `α` in `exponential_decay(t, α)` where α is clearly the rate
- Better: `learning_rate` or `decay_constant` when context is ambiguous

## Type Stability & Generics

- Write type-stable code: output type depends only on input types
- Use parametric types with constraints: `MyStruct{T<:AbstractFloat}`
- Combine abstract and parametric: `function foo(x::AbstractVector{T}) where T<:Real`
- Avoid hardcoding `Float64` - use `AbstractFloat` or type parameters
- Check stability with `@code_warntype` and `JET.jl`

## Performance

- Avoid kwargs in performance-critical internal functions (use positional args)
- Avoid `Any` in struct fields - always specify types
- Avoid global variables in hot paths
- Use `@views` for array slices when not copying

## Best Practices

- Leverage multiple dispatch instead of if-else on types
- Prefer immutable structs when state doesn't change
- Use `joinpath()`, `dirname()`, `basename()` for file paths
- Ask about preferred packages (DataFrames vs alternatives, etc.)
