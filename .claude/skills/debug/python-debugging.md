# Python Debugging

## Print Debugging

```python
print(f"DEBUG: {variable=}")  # Python 3.8+ f-string syntax
print(f"DEBUG: x={x}, type={type(x)}")
```

## pdb (built-in debugger)

### Breakpoints

```python
breakpoint()  # Python 3.7+ (or import pdb; pdb.set_trace())
```

### pdb Commands

```
n          next line
s          step into function
c          continue to next breakpoint
p expr     print expression
pp expr    pretty print
l          list source
w          show call stack
q          quit
```

### Post-mortem Debugging

```python
import pdb
try:
    failing_code()
except:
    pdb.post_mortem()
```

Or run script with: `python -m pdb script.py`

## ipdb (enhanced pdb)

Install: `pip install ipdb`

```python
import ipdb; ipdb.set_trace()
```

Better tab completion and syntax highlighting.

## Logging

```python
import logging
logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

logger.debug(f"Processing {item}")
logger.info("Operation completed")
logger.warning("Unexpected state")
logger.error("Failed to process", exc_info=True)
```

## Exception Info

```python
import traceback
import sys

try:
    failing_code()
except Exception as e:
    print(f"Error: {e}")
    print(f"Type: {type(e).__name__}")
    traceback.print_exc()

    # Get exception info
    exc_type, exc_value, exc_tb = sys.exc_info()
```

## Common Python Bugs

- **None where object expected** → check function returns
- **Mutable default argument** → use `None` default, create in function
- **Late binding closures** → use default argument `lambda x=x: ...`
- **Integer division** → use `//` explicitly or check `/` behavior
- **Shallow copy** → use `copy.deepcopy()` for nested structures
