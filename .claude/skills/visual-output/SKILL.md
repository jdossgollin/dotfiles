---
name: visual-output
description: Generates interactive HTML visualizations from data. Use when user wants charts, diagrams, or visual reports.
---

# Visual Output

Generate interactive HTML visualizations from data or analysis results.

## When to Use

- User wants a chart or graph
- Presenting analysis results visually
- Creating a dashboard or report
- Visualizing data from `/data-read` output

## See Also

- `/data-read` - parse data files before visualizing
- `/doc-gen` - if visualization is part of documentation
- `/profile` - if visualizing performance data

## Available Tools

- `Read` - read data files
- `Write` - create HTML output
- `Bash` - for opening in browser

## Output Location

Write visualizations to: `.claude/output/` (gitignored)

```bash
mkdir -p .claude/output
```

## Approach

Generate standalone HTML with embedded JavaScript. No external dependencies required (use CDN links).

## Libraries (via CDN)

### Charts: Chart.js

```html
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
```

Simple, clean charts for most needs.

### Complex Visualizations: D3.js

```html
<script src="https://d3js.org/d3.v7.min.js"></script>
```

For custom, interactive visualizations.

### Tables: DataTables

```html
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.7/css/jquery.dataTables.min.css">
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
```

For sortable, searchable data tables.

### Diagrams: Mermaid

```html
<script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
```

For flowcharts, sequence diagrams, etc.

## Template: Basic Chart

```html
<!DOCTYPE html>
<html>
<head>
    <title>Visualization</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { font-family: system-ui, sans-serif; margin: 2rem; }
        .chart-container { max-width: 800px; margin: 0 auto; }
    </style>
</head>
<body>
    <h1>Title</h1>
    <div class="chart-container">
        <canvas id="chart"></canvas>
    </div>
    <script>
        const ctx = document.getElementById('chart');
        new Chart(ctx, {
            type: 'bar', // or 'line', 'pie', 'scatter', etc.
            data: {
                labels: ['A', 'B', 'C'],
                datasets: [{
                    label: 'Values',
                    data: [10, 20, 30]
                }]
            }
        });
    </script>
</body>
</html>
```

## Template: Interactive Table

```html
<!DOCTYPE html>
<html>
<head>
    <title>Data Table</title>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.7/css/jquery.dataTables.min.css">
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
</head>
<body>
    <table id="data" class="display">
        <thead><tr><th>Col1</th><th>Col2</th></tr></thead>
        <tbody>
            <tr><td>A</td><td>1</td></tr>
        </tbody>
    </table>
    <script>
        $(document).ready(function() {
            $('#data').DataTable();
        });
    </script>
</body>
</html>
```

## Template: Mermaid Diagram

```html
<!DOCTYPE html>
<html>
<head>
    <title>Diagram</title>
    <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
</head>
<body>
    <div class="mermaid">
    graph TD
        A[Start] --> B{Decision}
        B -->|Yes| C[Action]
        B -->|No| D[Other]
    </div>
    <script>mermaid.initialize({startOnLoad:true});</script>
</body>
</html>
```

## Process

### 1. Understand the Data

- What data are we visualizing?
- Use `/data-read` if needed to parse the source

### 2. Choose Visualization Type

| Data Type | Visualization |
|-----------|---------------|
| Categories + values | Bar chart |
| Trends over time | Line chart |
| Proportions | Pie/donut chart |
| Correlations | Scatter plot |
| Hierarchies | Tree/sunburst |
| Flows/processes | Mermaid diagram |
| Tabular data | DataTables |

### 3. Generate HTML

Write to `.claude/output/<name>.html`

### 4. Offer to Open

```bash
# macOS
open .claude/output/<name>.html

# Linux
xdg-open .claude/output/<name>.html
```

## Output

After generating:

> "Created `.claude/output/<name>.html`. Open it in a browser to view. Want me to open it?"

## Integration Notes

When receiving data from `/data-read`:

> "I've parsed the data. Want me to visualize it? Options: bar chart, line chart, table..."

When creating documentation with `/doc-gen`:

> "Want to include an interactive chart? I can generate a linked HTML visualization."

For performance data from `/profile`:

> "I can visualize these profiling results as a flame graph or bar chart. Which would help?"
