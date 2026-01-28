# Python Profiling

## Quick Timing

```python
import time
start = time.perf_counter()
result = function()
elapsed = time.perf_counter() - start
print(f"Elapsed: {elapsed:.4f}s")
```

## cProfile (built-in)

### Command Line

```bash
python -m cProfile -s cumtime script.py
python -m cProfile -o output.prof script.py  # save for analysis
```

### In Code

```python
import cProfile
import pstats

profiler = cProfile.Profile()
profiler.enable()
# ... code to profile ...
profiler.disable()

stats = pstats.Stats(profiler)
stats.sort_stats('cumulative')
stats.print_stats(20)  # top 20
```

## line_profiler (line-by-line)

Install: `pip install line_profiler`

```python
# Add @profile decorator to functions
@profile
def function_to_profile():
    ...

# Run with:
# kernprof -l -v script.py
```

## memory_profiler

Install: `pip install memory_profiler`

```python
from memory_profiler import profile

@profile
def function():
    ...
```

Run: `python -m memory_profiler script.py`

## py-spy (sampling profiler)

Install: `pip install py-spy`

No code changes needed:

```bash
py-spy top -- python script.py       # live view
py-spy record -o profile.svg -- python script.py  # flame graph
```

## Common Bottlenecks

- **Loop in Python** → use numpy/vectorization
- **Repeated allocations** → pre-allocate arrays
- **I/O bound** → async or threading
- **CPU bound** → multiprocessing or numba

## Profiler Overhead

cProfile adds ~10-20% overhead. For micro-benchmarks, use `timeit`:

```python
import timeit
timeit.timeit('function()', globals=globals(), number=1000)
```
