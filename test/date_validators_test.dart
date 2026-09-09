import 'package:flutter/material.dart';
import 'package:flutter_dynamic_form/i18n/strings.g.dart';
import 'package:flutter_dynamic_form/logic/dynamic_form_validators.dart';
import 'package:flutter_dynamic_form/model/dynamic_form_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('ar');
  });

  Future<BuildContext> pumpContext(WidgetTester tester) async {
    late BuildContext ctx;
    // TranslationProvider нужен для error-путей валидаторов (context.dfl).
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          home: Builder(
            builder: (context) {
              ctx = context;
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
    return ctx;
  }

  testWidgets('dateValidator accepts value produced by ar-locale format object',
      (WidgetTester tester) async {
    final context = await pumpContext(tester);
    final validators = DynamicFormValidators(null, context);

    // ar-локаль: useNativeDigits == true по умолчанию -> Eastern Arabic digits.
    final arFormat = DateFormat('dd.MM.yyyy', 'ar');
    final input = arFormat.format(DateTime(2026, 1, 31));

    final error = validators.dateValidator(
      input,
      CompareDate.AllDates,
      arFormat.pattern,
      format: arFormat,
    );

    expect(error, isNull);
  });

  testWidgets('datePeriodValidator accepts period produced by ar-locale format object',
      (WidgetTester tester) async {
    final context = await pumpContext(tester);
    final validators = DynamicFormValidators(null, context);

    final arFormat = DateFormat('dd.MM.yyyy', 'ar');
    final start = arFormat.format(DateTime(2026, 1, 1));
    final end = arFormat.format(DateTime(2026, 1, 15));

    final error = validators.datePeriodValidator(
      '$start - $end',
      pattern: arFormat.pattern,
      format: arFormat,
    );

    expect(error, isNull);
  });

  testWidgets('pattern-only calls keep working (backward compatibility)',
      (WidgetTester tester) async {
    final context = await pumpContext(tester);
    final validators = DynamicFormValidators(null, context);

    expect(
      validators.dateValidator('01/31/2026', CompareDate.AllDates, 'MM/dd/yyyy'),
      isNull,
    );
    expect(
      validators.datePeriodValidator('01/01/2026 - 01/15/2026', pattern: 'MM/dd/yyyy'),
      isNull,
    );
    expect(
      validators.datePeriodValidator('rubbish', pattern: 'MM/dd/yyyy'),
      isNotNull,
    );
  });
}
