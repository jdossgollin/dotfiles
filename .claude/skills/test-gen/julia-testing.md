# Julia Testing Patterns

## Framework

Julia uses the stdlib `Test` module. No external dependencies needed.

```julia
using Test
```

## Basic Patterns

### Test Sets (grouping)

```julia
@testset "Function Name" begin
    @test function(1) == expected
    @test function(2) == expected2
end
```

Test sets can be nested for organization.

### Assertions

```julia
@test expr                      # boolean assertion
@test a == b                    # equality
@test a ≈ b                     # floating point (isapprox)
@test a ≈ b atol=1e-6           # with tolerance
@test a ≈ b rtol=1e-3           # relative tolerance
```

### Expected Exceptions

```julia
@test_throws DomainError function(invalid)
@test_throws ArgumentError function(bad_arg)
```

### Log Output

```julia
@test_logs (:warn, "message") function_that_warns()
@test_logs (:info,) min_level=Logging.Info function()
```

### Known Failures

```julia
@test_broken function(x) == wrong_expected  # known bug
@test_skip function(x)                       # skip entirely
```

### Type Stability

```julia
@inferred function(x)           # fails if return type not inferred
@inferred Type function(x)      # check specific return type
```

## Test File Location

- `test/runtests.jl` - main entry point
- `test/test_<module>.jl` - per-module tests
- Include from runtests.jl: `include("test_module.jl")`

## Project Setup

```julia
# In test/runtests.jl
using MyPackage
using Test

@testset "MyPackage" begin
    include("test_feature1.jl")
    include("test_feature2.jl")
end
```

## Running Tests

```julia
# From REPL
] test

# From command line
julia --project -e 'using Pkg; Pkg.test()'
```
