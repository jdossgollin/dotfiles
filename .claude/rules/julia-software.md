---
paths:
  - "**/src/**/*.jl"
  - "**/lib/**/*.jl"
---

# Julia (Software/Package Code)

## Development

- Write tests alongside code
- Use `@testset` blocks
- Incremental development with tests passing

## Structure

- Well-defined struct types with documentation
- Multiple dispatch for extensibility
- Type-stable, parameterized code

## Environment Management

- Separate environments: main Project.toml (use), test/Project.toml (test)
- Use `Pkg.develop()` for local package development
- Keep Manifest.toml in git for reproducibility
