import 'dart:math' as math;

/// A block of whole cells in a calendar days grid: [rows] rows starting at
/// [row], columns `[from, to)`.
class GridSpan {
  const GridSpan({required this.row, required this.rows, required this.from, required this.to});

  final int row;
  final int rows;
  final int from;
  final int to;

  @override
  bool operator ==(Object other) =>
      other is GridSpan &&
      other.row == row &&
      other.rows == rows &&
      other.from == from &&
      other.to == to;

  @override
  int get hashCode => Object.hash(row, rows, from, to);

  @override
  String toString() => 'GridSpan(row: $row, rows: $rows, from: $from, to: $to)';
}

/// Pure: the cells `[start, end)` of a grid [perRow] cells wide (indexes run
/// row by row) as the fewest rectangles — a partial first row, a block of
/// full rows, a partial last row.
List<GridSpan> gridSpans(int start, int end, {int perRow = 7}) {
  final spans = <GridSpan>[];
  var i = math.max(start, 0);
  while (i < end) {
    final row = i ~/ perRow;
    final from = i % perRow;
    if (from == 0 && end - i >= perRow) {
      final rows = (end - i) ~/ perRow;
      spans.add(GridSpan(row: row, rows: rows, from: 0, to: perRow));
      i += rows * perRow;
    } else {
      final to = math.min(perRow, from + end - i);
      spans.add(GridSpan(row: row, rows: 1, from: from, to: to));
      i += to - from;
    }
  }
  return spans;
}
