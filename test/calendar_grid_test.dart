import 'package:flutter_dynamic_form/utils/calendar_grid.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('empty range gives no spans', () {
    expect(gridSpans(3, 3), isEmpty);
  });

  test('cells inside one row', () {
    expect(gridSpans(2, 5), [const GridSpan(row: 0, rows: 1, from: 2, to: 5)]);
  });

  test('partial first row, full rows block, partial last row', () {
    expect(gridSpans(1, 24), [
      const GridSpan(row: 0, rows: 1, from: 1, to: 7),
      const GridSpan(row: 1, rows: 2, from: 0, to: 7),
      const GridSpan(row: 3, rows: 1, from: 0, to: 3),
    ]);
  });

  test('range ending on a row edge', () {
    expect(gridSpans(0, 14), [const GridSpan(row: 0, rows: 2, from: 0, to: 7)]);
    expect(gridSpans(5, 7), [const GridSpan(row: 0, rows: 1, from: 5, to: 7)]);
  });
}
