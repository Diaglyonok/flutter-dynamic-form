import 'dart:developer';

import 'package:dglk_flutter_dev_kit/simple_button/simple_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dynamic_form/flutter_dynamic_form.dart';
import 'package:flutter_dynamic_form/model/auto_calculate_field.dart';
import 'package:hello_example/date_formatter.dart';
import 'package:hello_example/theme.dart';

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

  @override
  void initState() {
    final format = DateFormatter.byContext(context);
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
      PeriodField(
        fieldId: 'date_period',
        label: 'Period Start',
        extra: PeriodExtra(
          secondLabel: 'Period End',
          type: CupertinoDatePickerMode.date,
          pickType: PickType.FieldTap,
          format: format,
        ),
      ),
      MultitypeField(
        fieldId: 'miltiselect_example',
        fieldType: FieldTypes.Number,
        label: 'MultiType Example',
        types: ['type_1', 'type_2'],
        translations: {
          'type_1': 'Type 1',
          'type_2': 'Type 2',
        },
      ),
      AutoCalculateField(
        calculate: (values) {
          if (values?['date_period']?.value == null) {
            return null;
          }
          return CompositeValue('auto result');
        },
        fieldId: 'auto_example',
        fieldType: FieldTypes.Number,
        label: 'Select Multitype (Auto)',
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
            physics: const NeverScrollableScrollPhysics(),
            key: key,
            fields: fields!,
            submitBtn: Padding(
              padding: const EdgeInsets.all(8.0),
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
