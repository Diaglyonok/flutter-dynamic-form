import 'dart:async';

import 'package:dglk_simple_button/dglk_simple_button.dart';
import 'package:flutter/material.dart';

import '../../flutter_dynamic_form.dart';
import '../../i18n/dynamic_form_localizations.g.dart' as locale;
import '../field_widgets/bottom_pick_button.dart';

const countryPhoneCodes = <String, String>{
  'AA': '+',
  'AF': '+93',
  'AL': '+355',
  'DZ': '+21',
  'AS': '+684',
  'AD': '+376',
  'AO': '+244',
  'AI': '+1',
  'AG': '+1',
  'AM': '+374',
  'AR': '+54',
  'AU': '+61',
  'AT': '+43',
  'AZ': '+994',
  'BS': '+1',
  'BH': '+973',
  'BD': '+880',
  'BB': '+1',
  'BY': '+375',
  'BE': '+32',
  'BZ': '+501',
  'BJ': '+229',
  'BM': '+1',
  'BO': '+591',
  'BA': '+387',
  'BW': '+267',
  'BR': '+55',
  'VG': '+1',
  'BN': '+673',
  'BG': '+359',
  'BF': '+226',
  'BI': '+257',
  'KH': '+855',
  'CM': '+237',
  'CA': '+1',
  'CV': '+238',
  'KY': '+1',
  'CF': '+236',
  'TD': '+235',
  'CL': '+56',
  'CN': '+86',
  'CX': '+672',
  'CC': '+672',
  'CO': '+57',
  'KM': '+269',
  'CG': '+242',
  'CK': '+682',
  'CR': '+506',
  'HR': '+385',
  'CU': '+53',
  'CY': '+357',
  'CZ': '+420',
  'DK': '+45',
  'DG': '+246',
  'DJ': '+253',
  'DM': '+1',
  'DO': '+1',
  'TL': '+62',
  'EC': '+593',
  'EG': '+20',
  'SV': '+503',
  'GQ': '+240',
  'EE': '+372',
  'ET': '+251',
  'FO': '+298',
  'FK': '+500',
  'FJ': '+679',
  'FI': '+358',
  'FR': '+33',
  'BL': '+590',
  'GF': '+594',
  'PF': '+689',
  'GA': '+241',
  'GM': '+220',
  'GE': '+995',
  'DE': '+49',
  'GH': '+233',
  'GI': '+350',
  'GR': '+30',
  'GL': '+299',
  'GD': '+1',
  'GU': '+671',
  'GT': '+502',
  'GN': '+224',
  'GW': '+245',
  'GY': '+592',
  'HT': '+509',
  'HN': '+504',
  'HK': '+852',
  'HU': '+36',
  'IS': '+354',
  'IN': '+91',
  'ID': '+62',
  'IR': '+98',
  'IQ': '+964',
  'IE': '+353',
  'IL': '+972',
  'IT': '+39',
  'CI': '+225',
  'JM': '+1',
  'JP': '+81',
  'JO': '+962',
  'KZ': '+7',
  'KE': '+254',
  'KI': '+686',
  'KG': '+996',
  'KW': '+965',
  'LA': '+856',
  'LV': '+371',
  'LB': '+961',
  'LS': '+266',
  'LR': '+231',
  'LY': '+21',
  'LI': '+41',
  'LT': '+370',
  'LU': '+352',
  'MO': '+853',
  'MK': '+389',
  'MG': '+261',
  'MW': '+265',
  'MY': '+60',
  'MV': '+960',
  'ML': '+223',
  'MT': '+356',
  'MH': '+692',
  'MQ': '+596',
  'MR': '+222',
  'MU': '+230',
  'MX': '+52',
  'FM': '+691',
  'MC': '+377',
  'MD': '+373',
  'MN': '+976',
  'MS': '+1',
  'MA': '+212',
  'MZ': '+258',
  'MM': '+95',
  'NA': '+264',
  'NR': '+674',
  'NP': '+977',
  'NL': '+31',
  'AN': '+599',
  'NC': '+687',
  'NZ': '+64',
  'NI': '+505',
  'NE': '+227',
  'NG': '+234',
  'NU': '+683',
  'NF': '+672',
  'KP': '+850',
  'YE': '+967',
  'MP': '+670',
  'NO': '+47',
  'OM': '+968',
  'PK': '+92',
  'PA': '+507',
  'PG': '+675',
  'PY': '+595',
  'PE': '+51',
  'PH': '+63',
  'PL': '+48',
  'PT': '+351',
  'PR': '+1',
  'QA': '+974',
  'RE': '+262',
  'RO': '+40',
  'RU': '+7',
  'RW': '+250',
  'SH': '+247',
  'PM': '+508',
  'SM': '+39',
  'ST': '+239',
  'SA': '+966',
  'SN': '+221',
  'SC': '+248',
  'CS': '+381',
  'SL': '+232',
  'SG': '+65',
  'SK': '+421',
  'SI': '+386',
  'SB': '+677',
  'SO': '+252',
  'ZA': '+27',
  'KR': '+82',
  'YD': '+969',
  'ES': '+34',
  'LK': '+94',
  'KN': '+1',
  'LC': '+1',
  'VC': '+1',
  'SD': '+249',
  'SR': '+597',
  'SJ': '+47',
  'SZ': '+268',
  'SE': '+46',
  'CH': '+41',
  'SY': '+963',
  'TJ': '+992',
  'TW': '+886',
  'TZ': '+255',
  'TH': '+66',
  'TG': '+228',
  'TK': '+690',
  'TO': '+676',
  'TT': '+1',
  'TN': '+21',
  'TR': '+90',
  'TM': '+993',
  'TC': '+1',
  'TV': '+688',
  'VI': '+1',
  'UG': '+256',
  'UA': '+380',
  'AE': '+971',
  'GB': '+44',
  'UY': '+598',
  'US': '+1',
  'UZ': '+998',
  'VU': '+678',
  'VA': '+39',
  'VE': '+58',
  'VN': '+84',
  'WF': '+681',
  'EH': '+21',
  'WS': '+685',
  'CD': '+243',
  'ZM': '+260',
  'ZW': '+263',
};

class PhoneFieldWrapper extends StatefulWidget {
  final PhoneField? field;
  final Widget child;
  final Function(String extra)? onExtraChanged;
  final TextStyle style;
  const PhoneFieldWrapper({Key? key, this.field, required this.child, this.onExtraChanged, required this.style})
      : super(key: key);

  @override
  State<PhoneFieldWrapper> createState() => _PhoneFieldWrapperState();
}

class _PhoneFieldWrapperState extends State<PhoneFieldWrapper> {
  String? current;

  @override
  void initState() {
    current = widget.field!.initialPrefix;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.field == null) {
      return widget.child;
    }

    return Row(
      children: [
        BottomPickButton(
          text: current!,
          style: widget.style,
          child: SearchCountryBottomView(
            custom: widget.field!.customizations,
            onChanged: (code) {
              current = code;
              setState(() {});
              widget.onExtraChanged?.call(code);
            },
          ),
        ),
        Expanded(
          child: widget.child,
        )
      ],
    );
  }
}

class SearchCountryBottomView extends StatefulWidget {
  final Function(String extra) onChanged;
  final PhoneBottomViewCustomizations custom;
  const SearchCountryBottomView({Key? key, required this.onChanged, required this.custom}) : super(key: key);

  @override
  State<SearchCountryBottomView> createState() => _SearchCountryBottomViewState();
}

class _SearchCountryBottomViewState extends State<SearchCountryBottomView> {
  final controller = TextEditingController();
  final textStreamController = StreamController<String>.broadcast();
  final focusNode = FocusNode();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  String? codeError;

  bool checkCode(String? value) {
    if (value == null) {
      return true;
    }

    if (!value.startsWith('+')) {
      return false;
    }

    if (int.tryParse(value.replaceAll('+', '')) == null) {
      return false;
    }

    return true;
  }

  @override
  void dispose() {
    focusNode.unfocus();
    textStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          color: Theme.of(context).colorScheme.background,
          constraints: const BoxConstraints(maxHeight: 420),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 40,
                        child: Center(
                          child: Icon(
                            Icons.search,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          focusNode: focusNode,
                          keyboardType: TextInputType.text,
                          cursorColor: Theme.of(context).colorScheme.secondary,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: locale.dynamicFormTranslation.chooseCountryCode,
                            hintStyle: widget.custom.hintStyle,
                          ),
                          onChanged: (text) {
                            textStreamController.add(text);
                            setState(() {
                              codeError = null;
                            });
                          },
                          controller: controller,
                        ),
                      ),
                      StreamBuilder<String>(
                        stream: textStreamController.stream,
                        builder: (context, snapshot) {
                          return Visibility(
                            visible: snapshot.data != null && snapshot.data != '',
                            child: SizedBox(
                              width: 40,
                              child: IconButton(
                                onPressed: () {
                                  controller.text = '';
                                },
                                padding: const EdgeInsets.only(),
                                icon: Icon(
                                  Icons.close,
                                  color: Theme.of(context).colorScheme.onBackground,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<String>(
                    stream: textStreamController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.data != null && snapshot.data!.isNotEmpty && checkCode(snapshot.data!)) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (codeError != null) const SizedBox(height: 17),
                              SimpleButton(
                                callback: () {
                                  widget.onChanged(snapshot.data!);
                                  Navigator.of(context).pop();
                                },
                                title: locale.dynamicFormTranslation.useInputtedCode,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              if (codeError != null)
                                Text(
                                  codeError!,
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        color: Theme.of(context).colorScheme.error,
                                      ),
                                ),
                            ],
                          ),
                        );
                      }

                      if (snapshot.data != null &&
                          countryPhoneCodes.keys
                              .where((key) =>
                                  locale.dynamicFormTranslation.countries[key] != null &&
                                  locale.dynamicFormTranslation.countries[key]!
                                      .toLowerCase()
                                      .contains(snapshot.data!.toLowerCase()))
                              .isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: Text(
                              locale.dynamicFormTranslation.nothingFoundCountryCode,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.onBackground,
                                  ),
                            ),
                          ),
                        );
                      }

                      return ListView(
                        padding: const EdgeInsets.only(),
                        children: [
                          for (var key in countryPhoneCodes.keys)
                            if (countryPhoneCodes[key] != null &&
                                locale.dynamicFormTranslation.countries[key] != null &&
                                (snapshot.data == null ||
                                    locale.dynamicFormTranslation.countries[key]!
                                        .toLowerCase()
                                        .contains(snapshot.data!.toLowerCase())))
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: MaterialButton(
                                          height: 48,
                                          onPressed: () {
                                            widget.onChanged(countryPhoneCodes[key]!);
                                            Navigator.of(context).pop();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    constraints: const BoxConstraints(minWidth: 48),
                                                    child: Text(
                                                      '${countryPhoneCodes[key]!}${key == countryPhoneCodes.keys.first ? '' : ':'}',
                                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                          color: Theme.of(context).colorScheme.onBackground,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                  Text(
                                                    locale.dynamicFormTranslation.countries[key]!,
                                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                          color: Theme.of(context).colorScheme.onBackground,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 240,
                                    height: 0.5,
                                    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
                                  ),
                                ],
                              )
                        ],
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
