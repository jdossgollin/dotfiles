# Python Testing Patterns

## Framework Detection

Look for:

- `pytest.ini` or `pyproject.toml [tool.pytest]` → pytest
- `conftest.py` → pytest with fixtures
- `unittest` imports → unittest

Default to pytest if unclear.

## pytest Patterns

### Basic Test

```python
def test_function_returns_expected():
    result = function(valid_input)
    assert result == expected
```

### Parametrized Tests

```python
@pytest.mark.parametrize("input,expected", [
    (1, 2),
    (2, 4),
    (0, 0),
])
def test_function_variants(input, expected):
    assert function(input) == expected
```

### Expected Exceptions

```python
def test_function_raises_on_invalid():
    with pytest.raises(ValueError):
        function(invalid_input)
```

### Floating Point

```python
def test_function_approx():
    assert function(x) == pytest.approx(expected, rel=1e-6)
```

### Fixtures

```python
@pytest.fixture
def sample_data():
    return create_test_data()

def test_with_fixture(sample_data):
    result = process(sample_data)
    assert result is not None
```

### Async Tests

```python
@pytest.mark.asyncio
async def test_async_function():
    result = await async_function()
    assert result == expected
```

## Test File Location

- `tests/test_<module>.py` (preferred)
- `<module>_test.py` (alternative)
- Mirror source structure in tests/

## Running Tests

```bash
pytest                     # all tests
pytest tests/test_foo.py   # specific file
pytest -k "test_name"      # by name pattern
pytest -x                  # stop on first failure
pytest -v                  # verbose output
```
