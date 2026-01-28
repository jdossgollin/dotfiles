---
name: data-read
description: Figure out how to read/parse a data file
---

# Data Read

Analyze data file and write reading code.

## Available Tools

- `Read` - read file contents (use for inspection)
- `Bash` - for running code

## Safety

- Read ONLY first 100 lines or 10KB, never full file
- If headers suggest PII or credentials, flag immediately

## Process

### 1. Inspect (first 100 lines only)

- Extension, encoding, delimiter
- Header detection
- Format identification

### 2. Identify Format

- CSV/TSV
- JSON/JSONL
- Parquet
- Excel
- Fixed-width
- Custom/binary

### 3. Ask Before Writing Code

- Which columns needed?
- Data types for ambiguous columns?
- Missing value handling?
- Date/time format?

### 4. Write Code (after confirmation)

Default to lazy loading/chunking for unknown sizes:

- Python: `pd.read_csv(..., chunksize=)` or `pl.scan_csv()`
- Julia: `CSV.Rows` or lazy iteration

Include:

- Error handling
- Comments documenting assumptions
- Show first few rows as verification
