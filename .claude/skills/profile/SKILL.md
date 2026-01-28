---
name: profile
description: Profile code and identify performance bottlenecks
---

# Profile

Profile code to identify performance bottlenecks.

## When to Use

- Code is slow and you want to find out why
- Comparing performance of different implementations

## See Also

- `/debug` - if the issue is incorrect behavior, not performance

## Available Tools

- `Grep` - ripgrep-based search
- `Glob` - fast file pattern matching
- `Read` - read file contents
- `Bash` - for running profilers

## Safety

- If data is large, create minimal reproduction with mock/sample data
- Verify no destructive operations before running

## Process

### 1. Identify Profiler

- Python: cProfile, line_profiler, `py-spy` for sampling
- Julia:
  - Quick timing: `@time`, `@elapsed`
  - Benchmarking: `BenchmarkTools.jl` (`@btime`, `@benchmark`) - more accurate, runs multiple times
  - Profiling: `@profile` with `Profile.print()` or `ProfileView.jl`
  - Type stability: `@code_warntype`, `JET.jl`

### 2. Run Profiler

Run on target function or script.

### 3. Analyze & Visualize

Top 5 time-consumers (ASCII bar chart):

```
function_a  ████████████████ 45%
function_b  ████████         22%
function_c  ██████           15%
```

Also report:

- Memory hotspots
- Type instability (Julia)
- Note if profiler overhead may skew results on small functions

### 4. Suggest Optimizations

Rank by impact:

- Quick wins (easy fixes, big impact)
- Algorithmic improvements
- Trade-offs to consider

## Output

Present findings. Ask before implementing changes.
