---
name: profile
description: Profiles code to identify performance bottlenecks. Use when code is slow.
---

# Profile

Identify performance bottlenecks in code.

## When to Use

- Code is slow
- Comparing implementations

## See Also

- `/debug` - if issue is correctness, not performance
- `/refactor` - after identifying bottlenecks
- `/visual-output` - to visualize profiling results

## Safety

- If data is large, create minimal reproduction
- Verify no destructive operations before running

## Process

1. Identify language and profiler
2. Run profiler on target
3. Analyze results
4. Suggest optimizations ranked by impact

## Language-Specific

- **Python**: See [python-profiling.md](python-profiling.md)
- **Julia**: See [julia-profiling.md](julia-profiling.md)

## Output Format

Top time-consumers (ASCII bar chart):

```
function_a  ████████████████ 45%
function_b  ████████         22%
function_c  ██████           15%
```

Present findings. Ask before implementing changes.

> "Found bottleneck in X. Want to refactor? (use `/refactor`)"
