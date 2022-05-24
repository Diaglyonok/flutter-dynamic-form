import 'dart:developer';

import 'package:dglk_flutter_dev_kit/simple_button/simple_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dynamic_form/flutter_dynamic_form.dart';
import 'package:flutter_dynamic_form/model/auto_calculate_field.dart';
import 'package:hello_example/date_formatter.dart';
import 'package:hello_example/theme.dart';
import 'package:jiffy/jiffy.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Field>? fields;
  final key = GlobalKey<DynamicFormState>();

  final Map<String, String> priceTypeTranslations = {
    'night': 'Night',
    'month': 'Month',
  };

  @override
  void initState() {
    final format = DateFormatter.byLocale(context);
    fields = [
      ScreenResultField(
        fieldId: 'screen_res_example',
        label: 'Delayed result',
        extra: ScreenResultExtra(
          getResult: (context) async {
            await Future.delayed(const Duration(seconds: 2));
            return ScreenResultCompositeValue('result', jsonData: {'result': 'result'});
          },
        ),
      ),
      ColorField(
        fieldId: 'color_example',
        initColor: Colors.red,
        label: 'Color Example',
        modifier: (color) {
          return Color.alphaBlend(Colors.white.withOpacity(0.7), color);
        },
      ),
      Field(
        fieldId: 'text_example',
        fieldType: FieldTypes.Text,
        required: true,
        label: 'Simple Required Text',
      ),
      PhoneField(
        initialPrefix: '+7',
        fieldId: 'phone_example',
        label: 'Phone Text',
      ),
      Field(
        fieldId: 'simple_num_fueld',
        fieldType: FieldTypes.Number,
        label: 'Simple Number Field',
      ),
      Field(
        fieldId: 'simple_date_fueld',
        fieldType: FieldTypes.Date,
        label: 'Simple Date Field',
      ),
      Field(
        fieldId: 'plain_text_example',
        fieldType: FieldTypes.PlainText,
        label: 'Plain text',
      ),
      Field(
        fieldId: 'radio_example',
        fieldType: FieldTypes.RadioOptions,
        label: '',
        options: [
          Option(id: 'type0', value: 'Едино-\nразовая'),
          Option(id: 'type1', value: 'Еже-\nнедельная'),
          Option(id: 'type2', value: 'Еже-\nмесячная'),
        ],
      ),
      PeriodField(
        fieldId: 'date_period',
        label: 'Period label 1',
        extra: PeriodExtra(
          secondLabel: 'Period label 2',
          type: CupertinoDatePickerMode.date,
          pickType: PickType.FieldTap,
          format: format,
        ),
      ),
      MultitypeField(
        fieldId: 'price',
        fieldType: FieldTypes.Number,
        label: 'Price',
        types: priceTypeTranslations.keys.toList(),
        translations: priceTypeTranslations,
      ),
      AutoCalculateField(
        calculate: (values) {
          final start = format.safeStrictParse(values?['date_period']?.value);
          final end = format.safeStrictParse(values?['date_period']?.extra);

          if (values == null ||
              start == null ||
              end == null ||
              values['price']?.value == null ||
              values['price']!.value.isEmpty ||
              double.tryParse(values['price']!.value) == null) {
            return null;
          }

          final priceVal = double.tryParse(values['price']!.value)!;

          if (values['price']!.extra == 'night') {
            final days = end.difference(start).inDays;
            return CompositeValue((days * priceVal).toStringAsFixed(2));
          } else if (values['price']!.extra == 'month') {
            final jstart = Jiffy(start, format.pattern);
            final jend = Jiffy(end, format.pattern);

            var startCount = jstart.clone();
            int months = 0;
            while (startCount.isBefore(jend)) {
              months++;
              startCount.add(months: 1);
            }

            return CompositeValue((months * priceVal).toStringAsFixed(2));
          }
          return null;
        },
        fieldId: 'full_price',
        fieldType: FieldTypes.Number,
        label: 'Full price',
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeDataGetter().theme,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Dynamic form example app'),
          ),
          body: DynamicForm(
            key: key,
            fields: fields!,
            submitBtn: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SimpleButton(
                title: 'Validate',
                callback: () {
                  final values = key.currentState?.getValues();
                  log(values.toString());
                },
              ),
            ),
          )),
    );
  }
}
