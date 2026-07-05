import 'package:flutter/widgets.dart';

import '../i18n/strings.g.dart';

/// Wrap [DynamicForm] with this widget to provide your own localization JSON.
///
/// The host app usually already has its translations as a decoded JSON map
/// (same shape as the package `translations.i18n.json`). Provide the map for
/// the currently active locale via [translations]. Every localized string
/// inside the form will first be looked up in this map and only fall back to
/// the package's bundled translations (`slang`) when a key is missing.
///
/// ```dart
/// DynamicFormLocalizationsWrapper(
///   locale: const Locale('en'),
///   translations: myJsonMap, // Map<String, dynamic>
///   child: DynamicForm(...),
/// )
/// ```
///
/// When the app locale changes, rebuild the wrapper with the JSON for the new
/// locale (and the new [locale]).
class DynamicFormLocalizationsWrapper extends InheritedWidget {
  const DynamicFormLocalizationsWrapper({
    Key? key,
    required this.translations,
    this.locale,
    required Widget child,
  }) : super(key: key, child: child);

  /// Decoded localization JSON for the currently active [locale].
  ///
  /// Keys follow the package `translations.i18n.json` structure, e.g.
  /// `selectDate`, `countries`, `passwordErrorText`.
  final Map<String, dynamic> translations;

  /// The locale [translations] correspond to. Informational only — lookups use
  /// [translations] directly since it is already resolved for one locale.
  final Locale? locale;

  static DynamicFormLocalizationsWrapper? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<DynamicFormLocalizationsWrapper>();

  @override
  bool updateShouldNotify(covariant DynamicFormLocalizationsWrapper oldWidget) =>
      translations != oldWidget.translations || locale != oldWidget.locale;
}

/// Localization facade used by the form internals.
///
/// Obtain it via [BuildContext.dfl]. Each accessor first tries the host JSON
/// provided through [DynamicFormLocalizationsWrapper] and falls back to the
/// package's global `slang` translations (`t`) when the key is absent or has
/// the wrong type. The global fallback never throws and does not require a
/// `TranslationProvider` ancestor.
class DynamicFormL10n {
  DynamicFormL10n(this._json, this._context);

  factory DynamicFormL10n.of(BuildContext context) =>
      DynamicFormL10n(DynamicFormLocalizationsWrapper.maybeOf(context)?.translations, context);

  final Map<String, dynamic>? _json;

  BuildContext _context;

  String? _str(String key) {
    final value = _json?[key];
    return value is String ? value : null;
  }

  Map<String, String>? _strMap(String key) {
    final value = _json?[key];
    if (value is Map) {
      return value.map((k, v) => MapEntry(k.toString(), v.toString()));
    }
    return null;
  }

  List<String>? _strList(String key) {
    final value = _json?[key];
    if (value is List) {
      return value.map((e) => e.toString()).toList();
    }
    return null;
  }

  String _fill(String template, Map<String, String> params) {
    var result = template;
    params.forEach((key, value) {
      result = result.replaceAll('{$key}', value);
    });
    return result;
  }

  // Simple strings.
  String get selectDate => _str('selectDate') ?? _context.t.selectDate;
  String get selectTime => _str('selectTime') ?? _context.t.selectTime;
  String get clear => _str('clear') ?? _context.t.clear;
  String get done => _str('done') ?? _context.t.done;
  String get startDate => _str('startDate') ?? _context.t.startDate;
  String get endDate => _str('endDate') ?? _context.t.endDate;
  String get link => _str('link') ?? _context.t.link;
  String get addLink => _str('addLink') ?? _context.t.addLink;
  String get wrongLinkSnack => _str('wrongLinkSnack') ?? _context.t.wrongLinkSnack;
  String get chooseCountryCode => _str('chooseCountryCode') ?? _context.t.chooseCountryCode;
  String get useInputtedCode => _str('useInputtedCode') ?? _context.t.useInputtedCode;
  String get nothingFoundCountryCode =>
      _str('nothingFoundCountryCode') ?? _context.t.nothingFoundCountryCode;
  String get returnDateWarning => _str('returnDateWarning') ?? _context.t.returnDateWarning;
  String get periodDateWarning => _str('periodDateWarning') ?? _context.t.periodDateWarning;
  String get emailIsNotValidErrorText =>
      _str('emailIsNotValidErrorText') ?? _context.t.emailIsNotValidErrorText;
  String get invalidTime => _str('invalidTime') ?? _context.t.invalidTime;
  String get fieldIsRequiredErrorText =>
      _str('fieldIsRequiredErrorText') ?? _context.t.fieldIsRequiredErrorText;
  String get wrongFormatText => _str('wrongFormatText') ?? _context.t.wrongFormatText;
  String get fieldDoesNotMatch => _str('fieldDoesNotMatch') ?? _context.t.fieldDoesNotMatch;

  // Collections.
  Map<String, String> get countries => _strMap('countries') ?? _context.t.countries;
  List<String> get weeksShort => _strList('weeksShort') ?? _context.t.weeksShort;

  // Parameterized strings.
  String dateIsNotValidErrorText({required String format}) {
    final raw = _str('dateIsNotValidErrorText');
    return raw != null
        ? _fill(raw, {'format': format})
        : _context.t.dateIsNotValidErrorText(format: format);
  }

  // ignore: non_constant_identifier_names
  String passwordErrorText({required String MIN}) {
    final raw = _str('passwordErrorText');
    return raw != null ? _fill(raw, {'MIN': MIN}) : _context.t.passwordErrorText(MIN: MIN);
  }
}

extension DynamicFormL10nX on BuildContext {
  /// Localization facade for the dynamic form. See [DynamicFormL10n].
  DynamicFormL10n get dfl => DynamicFormL10n.of(this);
}
