
/*
 * Generated file. Do not edit.
 *
 * Locales: 2
 * Strings: 484 (242.0 per locale)
 *
 * Built on 2022-08-11 at 05:32 UTC
 */

import 'package:flutter/widgets.dart';

const DynamicFormAppLocale _baseLocale = DynamicFormAppLocale.en;
DynamicFormAppLocale _currLocale = _baseLocale;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(DynamicFormAppLocale.en) // set locale
/// - Locale locale = DynamicFormAppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == DynamicFormAppLocale.en) // locale check
enum DynamicFormAppLocale {
	en, // 'en' (base locale, fallback)
	ru, // 'ru'
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of dynamicFormTranslation).
///
/// Usage:
/// String a = dynamicFormTranslation.someKey.anotherKey;
/// String b = dynamicFormTranslation['someKey.anotherKey']; // Only for edge cases!
_DynamicFormLocalizationsEn _dynamicFormTranslation = _currLocale.translations;
_DynamicFormLocalizationsEn get dynamicFormTranslation => _dynamicFormTranslation;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final dynamicFormTranslation = Translations.of(context); // Get dynamicFormTranslation variable.
/// String a = dynamicFormTranslation.someKey.anotherKey; // Use dynamicFormTranslation variable.
/// String b = dynamicFormTranslation['someKey.anotherKey']; // Only for edge cases!
class Translations {
	Translations._(); // no constructor

	static _DynamicFormLocalizationsEn of(BuildContext context) {
		final inheritedWidget = context.dependOnInheritedWidgetOfExactType<_InheritedLocaleData>();
		if (inheritedWidget == null) {
			throw 'Please wrap your app with "TranslationProvider".';
		}
		return inheritedWidget.translations;
	}
}

class LocaleSettings {
	LocaleSettings._(); // no constructor

	/// Uses locale of the device, fallbacks to base locale.
	/// Returns the locale which has been set.
	static DynamicFormAppLocale useDeviceLocale() {
		final locale = DynamicFormAppLocaleUtils.findDeviceLocale();
		return setLocale(locale);
	}

	/// Sets locale
	/// Returns the locale which has been set.
	static DynamicFormAppLocale setLocale(DynamicFormAppLocale locale) {
		_currLocale = locale;
		_dynamicFormTranslation = _currLocale.translations;

		if (WidgetsBinding.instance != null) {
			// force rebuild if TranslationProvider is used
			_translationProviderKey.currentState?.setLocale(_currLocale);
		}

		return _currLocale;
	}

	/// Sets locale using string tag (e.g. en_US, de-DE, fr)
	/// Fallbacks to base locale.
	/// Returns the locale which has been set.
	static DynamicFormAppLocale setLocaleRaw(String rawLocale) {
		final locale = DynamicFormAppLocaleUtils.parse(rawLocale);
		return setLocale(locale);
	}

	/// Gets current locale.
	static DynamicFormAppLocale get currentLocale {
		return _currLocale;
	}

	/// Gets base locale.
	static DynamicFormAppLocale get baseLocale {
		return _baseLocale;
	}

	/// Gets supported locales in string format.
	static List<String> get supportedLocalesRaw {
		return DynamicFormAppLocale.values
			.map((locale) => locale.languageTag)
			.toList();
	}

	/// Gets supported locales (as Locale objects) with base locale sorted first.
	static List<Locale> get supportedLocales {
		return DynamicFormAppLocale.values
			.map((locale) => locale.flutterLocale)
			.toList();
	}
}

/// Provides utility functions without any side effects.
class DynamicFormAppLocaleUtils {
	DynamicFormAppLocaleUtils._(); // no constructor

	/// Returns the locale of the device as the enum type.
	/// Fallbacks to base locale.
	static DynamicFormAppLocale findDeviceLocale() {
		final String? deviceLocale = WidgetsBinding.instance?.window.locale.toLanguageTag();
		if (deviceLocale != null) {
			final typedLocale = _selectLocale(deviceLocale);
			if (typedLocale != null) {
				return typedLocale;
			}
		}
		return _baseLocale;
	}

	/// Returns the enum type of the raw locale.
	/// Fallbacks to base locale.
	static DynamicFormAppLocale parse(String rawLocale) {
		return _selectLocale(rawLocale) ?? _baseLocale;
	}
}

// context enums

// interfaces generated as mixins

// translation instances

late _DynamicFormLocalizationsEn _translationsEn = _DynamicFormLocalizationsEn.build();
late _DynamicFormLocalizationsRu _translationsRu = _DynamicFormLocalizationsRu.build();

// extensions for DynamicFormAppLocale

extension DynamicFormAppLocaleExtensions on DynamicFormAppLocale {

	/// Gets the translation instance managed by this library.
	/// [TranslationProvider] is using this instance.
	/// The plural resolvers are set via [LocaleSettings].
	_DynamicFormLocalizationsEn get translations {
		switch (this) {
			case DynamicFormAppLocale.en: return _translationsEn;
			case DynamicFormAppLocale.ru: return _translationsRu;
		}
	}

	/// Gets a new translation instance.
	/// [LocaleSettings] has no effect here.
	/// Suitable for dependency injection and unit tests.
	///
	/// Usage:
	/// final t = AppLocale.en.build(); // build
	/// String a = t.my.path; // access
	_DynamicFormLocalizationsEn build() {
		switch (this) {
			case DynamicFormAppLocale.en: return _DynamicFormLocalizationsEn.build();
			case DynamicFormAppLocale.ru: return _DynamicFormLocalizationsRu.build();
		}
	}

	String get languageTag {
		switch (this) {
			case DynamicFormAppLocale.en: return 'en';
			case DynamicFormAppLocale.ru: return 'ru';
		}
	}

	Locale get flutterLocale {
		switch (this) {
			case DynamicFormAppLocale.en: return const Locale.fromSubtags(languageCode: 'en');
			case DynamicFormAppLocale.ru: return const Locale.fromSubtags(languageCode: 'ru');
		}
	}
}

extension StringDynamicFormAppLocaleExtensions on String {
	DynamicFormAppLocale? toDynamicFormAppLocale() {
		switch (this) {
			case 'en': return DynamicFormAppLocale.en;
			case 'ru': return DynamicFormAppLocale.ru;
			default: return null;
		}
	}
}

// wrappers

GlobalKey<_TranslationProviderState> _translationProviderKey = GlobalKey<_TranslationProviderState>();

class TranslationProvider extends StatefulWidget {
	TranslationProvider({required this.child}) : super(key: _translationProviderKey);

	final Widget child;

	@override
	_TranslationProviderState createState() => _TranslationProviderState();

	static _InheritedLocaleData of(BuildContext context) {
		final inheritedWidget = context.dependOnInheritedWidgetOfExactType<_InheritedLocaleData>();
		if (inheritedWidget == null) {
			throw 'Please wrap your app with "TranslationProvider".';
		}
		return inheritedWidget;
	}
}

class _TranslationProviderState extends State<TranslationProvider> {
	DynamicFormAppLocale locale = _currLocale;

	void setLocale(DynamicFormAppLocale newLocale) {
		setState(() {
			locale = newLocale;
		});
	}

	@override
	Widget build(BuildContext context) {
		return _InheritedLocaleData(
			locale: locale,
			child: widget.child,
		);
	}
}

class _InheritedLocaleData extends InheritedWidget {
	final DynamicFormAppLocale locale;
	Locale get flutterLocale => locale.flutterLocale; // shortcut
	final _DynamicFormLocalizationsEn translations; // store translations to avoid switch call

	_InheritedLocaleData({required this.locale, required Widget child})
		: translations = locale.translations, super(child: child);

	@override
	bool updateShouldNotify(_InheritedLocaleData oldWidget) {
		return oldWidget.locale != locale;
	}
}

// pluralization feature not used

// helpers

final _localeRegex = RegExp(r'^([a-z]{2,8})?([_-]([A-Za-z]{4}))?([_-]?([A-Z]{2}|[0-9]{3}))?$');
DynamicFormAppLocale? _selectLocale(String localeRaw) {
	final match = _localeRegex.firstMatch(localeRaw);
	DynamicFormAppLocale? selected;
	if (match != null) {
		final language = match.group(1);
		final country = match.group(5);

		// match exactly
		selected = DynamicFormAppLocale.values
			.cast<DynamicFormAppLocale?>()
			.firstWhere((supported) => supported?.languageTag == localeRaw.replaceAll('_', '-'), orElse: () => null);

		if (selected == null && language != null) {
			// match language
			selected = DynamicFormAppLocale.values
				.cast<DynamicFormAppLocale?>()
				.firstWhere((supported) => supported?.languageTag.startsWith(language) == true, orElse: () => null);
		}

		if (selected == null && country != null) {
			// match country
			selected = DynamicFormAppLocale.values
				.cast<DynamicFormAppLocale?>()
				.firstWhere((supported) => supported?.languageTag.contains(country) == true, orElse: () => null);
		}
	}
	return selected;
}

// translations

// Path: <root>
class _DynamicFormLocalizationsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [DynamicFormAppLocale.build] is preferred.
	_DynamicFormLocalizationsEn.build();

	/// Access flat map
	dynamic operator[](String key) => _flatMap[key];

	// Internal flat map initialized lazily
	late final Map<String, dynamic> _flatMap = _buildFlatMap();

	late final _DynamicFormLocalizationsEn _root = this; // ignore: unused_field

	// Translations
	Map<String, String> get countries => {
		'AA': 'Any number',
		'AF': 'Afghanistan',
		'AL': 'Albania',
		'DZ': 'Algeria',
		'AS': 'American Samoa',
		'AD': 'Andorra',
		'AO': 'Angola',
		'AI': 'Anguilla',
		'AG': 'Antigua and Barbuda',
		'AM': 'Armenia',
		'AR': 'Argentina',
		'AU': 'Australia',
		'AT': 'Austria',
		'AZ': 'Azerbaijan',
		'BS': 'Bahamas',
		'BH': 'Bahrain',
		'BD': 'Bangladesh',
		'BB': 'Barbados',
		'BY': 'Belarus',
		'BE': 'Belgium',
		'BZ': 'Belize',
		'BJ': 'Benin',
		'BM': 'Bermuda',
		'BO': 'Bolivia',
		'BA': 'Bosnia and Herzegovina',
		'BW': 'Botswana',
		'BR': 'Brazil',
		'VG': 'British Virgin Islands',
		'BN': 'Brunei Darusalaam',
		'BG': 'Bulgaria',
		'BF': 'Burkina Faso',
		'BI': 'Burundi',
		'KH': 'Cambodia',
		'CM': 'Cameroon',
		'CA': 'Canada',
		'CV': 'Cape Verde',
		'KY': 'Cayman Islands',
		'CF': 'Central African Republic',
		'TD': 'Chad',
		'CL': 'Chile',
		'CN': 'China',
		'CX': 'Christmas Island',
		'CC': 'Cocos Islands',
		'CO': 'Colombia',
		'KM': 'Comoros and Mayotte Island',
		'CG': 'Congo',
		'CK': 'Cook Islands',
		'CR': 'Costa Rica',
		'HR': 'Croatia',
		'CU': 'Cuba',
		'CY': 'Cyprus',
		'CZ': 'Czech Republic',
		'DK': 'Denmark',
		'DG': 'Diego Garcia',
		'DJ': 'Djibouti',
		'DM': 'Dominica',
		'DO': 'Dominican Republic',
		'TL': 'East Timor',
		'EC': 'Ecuador',
		'EG': 'Egypt',
		'SV': 'El Salvador',
		'GQ': 'Equatorial Guinea',
		'EE': 'Estonia',
		'ET': 'Ethiopia',
		'FO': 'Faeroe Islands',
		'FK': 'Falkland Islands',
		'FJ': 'Fiji',
		'FI': 'Finland',
		'FR': 'France',
		'BL': 'French Antilles',
		'GF': 'French Guiana',
		'PF': 'French Polynesia',
		'GA': 'Gabon',
		'GM': 'Gambia',
		'GE': 'Georgia',
		'DE': 'Germany',
		'GH': 'Ghana',
		'GI': 'Gibraltar',
		'GR': 'Greece',
		'GL': 'Greenland',
		'GD': 'Grenada',
		'GU': 'Guam',
		'GT': 'Guatemala',
		'GN': 'Guinea',
		'GW': 'Guinea-Bissau',
		'GY': 'Guyana',
		'HT': 'Haiti',
		'HN': 'Honduras',
		'HK': 'Hong Kong',
		'HU': 'Hungary',
		'IS': 'Iceland',
		'IN': 'India',
		'ID': 'Indonesia',
		'IR': 'Iran',
		'IQ': 'Iraq',
		'IE': 'Irish Republic',
		'IL': 'Israel',
		'IT': 'Italy',
		'CI': 'Ivory Coast',
		'JM': 'Jamaica',
		'JP': 'Japan',
		'JO': 'Jordan',
		'KZ': 'Kazakhstan',
		'KE': 'Kenya',
		'KI': 'Kiribati Republic',
		'KG': 'Kirghizia',
		'KW': 'Kuwait',
		'LA': 'Laos',
		'LV': 'Latvia',
		'LB': 'Lebanon',
		'LS': 'Lesotho',
		'LR': 'Liberia',
		'LY': 'Libya',
		'LI': 'Liechtenstein',
		'LT': 'Lithuania',
		'LU': 'Luxembourg',
		'MO': 'Macao',
		'MK': 'Macedonia',
		'MG': 'Madagascar',
		'MW': 'Malawi',
		'MY': 'Malaysia',
		'MV': 'Maldives',
		'ML': 'Mali',
		'MT': 'Malta',
		'MH': 'Marshall Islands',
		'MQ': 'Martinique',
		'MR': 'Mauritania',
		'MU': 'Mauritius',
		'MX': 'Mexico706',
		'FM': 'Micronesia',
		'MC': 'Monaco',
		'MN': 'Mongolia',
		'MS': 'Montserrat',
		'MA': 'Morocco',
		'MZ': 'Mozambique',
		'MM': 'Myanmar',
		'NA': 'Namibia',
		'NR': 'Nauru',
		'NP': 'Nepal',
		'NL': 'Netherlands',
		'AN': 'Netherlands Antilles',
		'NC': 'New Caledonia',
		'NZ': 'New Zealand',
		'NI': 'Nicaragua',
		'NE': 'Niger',
		'NG': 'Nigeria',
		'NU': 'Niue',
		'NF': 'Norfolk Island',
		'KP': 'North Korea',
		'YE': 'North Yemen',
		'MP': 'Northern Mariana Islands',
		'NO': 'Norway',
		'OM': 'Oman',
		'PK': 'Pakistan',
		'PA': 'Panama',
		'PG': 'Papua New Guinea',
		'PY': 'Paraguay',
		'PE': 'Peru',
		'PH': 'Philippines',
		'PL': 'Poland',
		'PT': 'Portugal',
		'PR': 'Puerto Rico',
		'QA': 'Qatar',
		'RE': 'Reunion',
		'RO': 'Romania',
		'RU': 'Russia',
		'RW': 'Rwandese Republic',
		'SH': 'Saint Helena and Ascension Island',
		'PM': 'Saint Pierre et Miquelon',
		'SM': 'San Marino',
		'ST': 'Sao Tome e Principe',
		'SA': 'Saudi Arabia',
		'SN': 'Senegal',
		'SC': 'Seychelles',
		'CS': 'Serbia',
		'SL': 'Sierra Leone',
		'SG': 'Singapore',
		'SK': 'Slovakia',
		'SI': 'Slovenia',
		'SB': 'Solomon Islands',
		'SO': 'Somalia',
		'ZA': 'South Africa',
		'KR': 'South Korea',
		'YD': 'South Yemen',
		'ES': 'Spain',
		'LK': 'Sri Lanka',
		'KN': 'St Kitts and Nevis',
		'LC': 'St Lucia',
		'VC': 'St Vincent and the Grenadines',
		'SD': 'Sudan',
		'SR': 'Suriname',
		'SJ': 'Svalbard and Jan Mayen Islands',
		'SZ': 'Swaziland',
		'SE': 'Sweden',
		'CH': 'Switzerland',
		'SY': 'Syria',
		'TJ': 'Tadjikistan',
		'TW': 'Taiwan',
		'TZ': 'Tanzania',
		'TH': 'Thailand',
		'TG': 'Togolese Republic',
		'TK': 'Tokelau',
		'TO': 'Tonga',
		'TT': 'Trinidad and Tobago',
		'TN': 'Tunisia',
		'TR': 'Turkey',
		'TM': 'Turkmenistan',
		'TC': 'Turks and Caicos Islands',
		'TV': 'Tuvalu',
		'VI': 'US Virgin Islands',
		'UG': 'Uganda',
		'UA': 'Ukraine',
		'AE': 'United Arab Emirates',
		'GB': 'United Kingdom',
		'UY': 'Uruguay',
		'US': 'USA',
		'UZ': 'Uzbekistan',
		'VU': 'Vanuatu',
		'VA': 'Vatican City',
		'VE': 'Venezuela',
		'VN': 'Vietnam',
		'WF': 'Wallis and Futuna Islands',
		'EH': 'Western Sahara',
		'WS': 'Western Samoa',
		'CD': 'Zaire',
		'ZM': 'Zambia',
		'ZW': 'Zimbabwe',
	};
	String passwordErrorText({required Object MIN, required Object MAX}) => 'Your password must be between $MIN and $MAX characters and contain at least one number and one letter';
	String useridErrorText({required Object MIN}) => 'Login length should be greater than $MIN characters';
	String get invalidPhoneNumber => 'Phone number is not valid';
	String get invalidTime => 'Time is not valid';
	String get emailIsNotValidErrorText => 'Email is not valid';
	String dateIsNotValidErrorText({required Object format}) => 'Please enter a valid date $format';
	String get fieldIsRequiredErrorText => 'This field is required';
	String get wrongFormatText => 'Something wrong with the format';
	String get fieldDoesNotMatch => 'The value entered does not match';
	String get returnDateWarning => 'Can\'t be earlier than first date';
	String get selectDate => 'Select date';
	String get selectTime => 'Select time';
	String get chooseCountryCode => 'Select or enter country code';
	String get useInputtedCode => 'Use inputted code';
	String get nothingFoundCountryCode => 'Nothing found, try changing your query or entering the country code manually';
}

// Path: <root>
class _DynamicFormLocalizationsRu implements _DynamicFormLocalizationsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [DynamicFormAppLocale.build] is preferred.
	_DynamicFormLocalizationsRu.build();

	/// Access flat map
	@override dynamic operator[](String key) => _flatMap[key];

	// Internal flat map initialized lazily
	@override late final Map<String, dynamic> _flatMap = _buildFlatMap();

	@override late final _DynamicFormLocalizationsRu _root = this; // ignore: unused_field

	// Translations
	@override Map<String, String> get countries => {
		'AA': 'Произвольный номер',
		'AF': 'Афганистан',
		'AL': 'Албания',
		'DZ': 'Алжир',
		'AS': 'Американское Самоа',
		'AD': 'Андорра',
		'AO': 'Ангола',
		'AI': 'Ангилья',
		'AG': 'Антигуа и Барбуда',
		'AM': 'Армения',
		'AR': 'Аргентина',
		'AU': 'Австралия',
		'AT': 'Австрия',
		'AZ': 'Азербайджан',
		'BS': 'Багамы',
		'BH': 'Бахрейн',
		'BD': 'Бангладеш',
		'BB': 'Барбадос',
		'BY': 'Белоруссия',
		'BE': 'Бельгия',
		'BZ': 'Белиз',
		'BJ': 'Бенин',
		'BM': 'Бермудские острова',
		'BO': 'Боливия',
		'BA': 'Босния и Герцеговина',
		'BW': 'Ботсвана',
		'BR': 'Бразилия',
		'VG': 'Британские Виргинские острова',
		'BN': 'Бруней Даруэсалаам',
		'BG': 'Болгария',
		'BF': 'Буркина Фасо',
		'BI': 'Бурунди',
		'KH': 'Камбоджа',
		'CM': 'Камерун',
		'CA': 'Канада',
		'CV': 'Кабо-Верде',
		'KY': 'Каймановы Острова',
		'CF': 'Центральноафриканская Республика',
		'TD': 'Чад',
		'CL': 'Чили',
		'CN': 'Китай',
		'CX': 'Рождественсткие острова',
		'CC': 'Кокосовые острова',
		'CO': 'Колумбия',
		'KM': 'Коморские и Майотские острова',
		'CG': 'Конго',
		'CK': 'Острова Кука',
		'CR': 'Коста-Рика',
		'HR': 'Хорватия',
		'CU': 'Куба',
		'CY': 'Кипр',
		'CZ': 'Чешская республика',
		'DK': 'Дания',
		'DG': 'Диего Гарсия',
		'DJ': 'Джибути',
		'DM': 'Доминика',
		'DO': 'Доминиканская республика',
		'TL': 'Восточный Тимор',
		'EC': 'Эквадор',
		'EG': 'Египет',
		'SV': 'Сальвадор',
		'GQ': 'Экваториальная Гвинея',
		'EE': 'Эстония',
		'ET': 'Эфиопия',
		'FO': 'Фарерские острова',
		'FK': 'Фолклендские острова',
		'FJ': 'Фиджи',
		'FI': 'Финляндия',
		'FR': 'Франция',
		'BL': 'Французские Антиллы',
		'GF': 'Французская Гвиана',
		'PF': 'Франзузская полинезия',
		'GA': 'Габон',
		'GM': 'Гамбия',
		'GE': 'Грузия',
		'DE': 'Германия',
		'GH': 'Гана',
		'GI': 'Гибралтар',
		'GR': 'Греция',
		'GL': 'Гренландия',
		'GD': 'Гренада',
		'GU': 'Гуам',
		'GT': 'Гватемала',
		'GN': 'Гвинея',
		'GW': 'Гвинея Биссау',
		'GY': 'Гайана',
		'HT': 'Гаити',
		'HN': 'Гондурас',
		'HK': 'Гон-Конг',
		'HU': 'Венгрия',
		'IS': 'исландия',
		'IN': 'Индия',
		'ID': 'Индонезия',
		'IR': 'Иран',
		'IQ': 'Ирак',
		'IE': 'Ирландская республика',
		'IL': 'Израиль',
		'IT': 'Италия',
		'CI': 'Берег слоновой кости',
		'JM': 'Джамайка',
		'JP': 'Япония',
		'JO': 'Иордания',
		'KZ': 'Казахстан',
		'KE': 'Кения',
		'KI': 'Кирибати',
		'KG': 'Кыргызстан',
		'KW': 'Кувейт',
		'LA': 'Лаос',
		'LV': 'Латвия',
		'LB': 'Ливан',
		'LS': 'Лессото',
		'LR': 'Либерия',
		'LY': 'Ливия',
		'LI': 'Лихтенштейн',
		'LT': 'Литва',
		'LU': 'Люксембург',
		'MO': 'Макао',
		'MK': 'Македония',
		'MG': 'Мадагаскар',
		'MW': 'Малави',
		'MY': 'Малайзия',
		'MV': 'Мальдивы',
		'ML': 'Мали',
		'MT': 'Мальта',
		'MH': 'Маршалловы острова',
		'MQ': 'Мартиника',
		'MR': 'Мавритания',
		'MU': 'Маврикий',
		'MX': 'Мексика',
		'FM': 'Микронезия',
		'MC': 'Монако',
		'MN': 'Монголия',
		'MS': 'Монсеррат',
		'MA': 'Мороко',
		'MZ': 'Мозамбик',
		'MM': 'Мьянма',
		'NA': 'Намибия',
		'NR': 'Науру',
		'NP': 'Непал',
		'NL': 'Нидерланды',
		'AN': 'Нидерландские антиллы',
		'NC': 'Новая каледония',
		'NZ': 'Новая зеландия',
		'NI': 'Никарагуа',
		'NE': 'Нигер',
		'NG': 'Нигерия',
		'NU': 'Ниуэ',
		'NF': 'Норфолкские острова',
		'KP': 'Северная Корея',
		'YE': 'Северный Йемен',
		'MP': 'Северно Марианские острова',
		'NO': 'Норвегия',
		'OM': 'Оман',
		'PK': 'Пакистан',
		'PA': 'Панама',
		'PG': 'Папуа Новая Гвинея',
		'PY': 'Парагвай',
		'PE': 'Перу',
		'PH': 'Филипины',
		'PL': 'Польша',
		'PT': 'Португалия',
		'PR': 'Пуэрто Рико',
		'QA': 'Катар',
		'RE': 'Реоньон',
		'RO': 'Румыния',
		'RU': 'Россия',
		'RW': 'Республика Руанда',
		'SH': 'Остров Вознесения',
		'PM': 'Сен-Пьер и Микелон',
		'SM': 'Сан Марино',
		'ST': 'Сан-Томе и Принсипи',
		'SA': 'Саудовская Аравия',
		'SN': 'Сенегал',
		'SC': 'Сейшельские Острова',
		'CS': 'Сербия',
		'SL': 'Сьерра Леоне',
		'SG': 'Сингапур',
		'SK': 'Словакия',
		'SI': 'Словения',
		'SB': 'Соломоновы острова',
		'SO': 'Сомали',
		'ZA': 'ЮАР',
		'KR': 'Южная Корея',
		'YD': 'Южный Йемен',
		'ES': 'Испания',
		'LK': 'Шри Ланка',
		'KN': 'Сент-Китс и Невис',
		'LC': 'Сент-Люсия',
		'VC': 'Сент-Винсент и Гренадины',
		'SD': 'Судан',
		'SR': 'Суринам',
		'SJ': 'Шпицберген и Ян-Майен',
		'SZ': 'Свазиленд',
		'SE': 'Швеция',
		'CH': 'Швейцария',
		'SY': 'Сирия',
		'TJ': 'Таджикистан',
		'TW': 'Тайвань',
		'TZ': 'Танзания',
		'TH': 'Тайланд',
		'TG': 'Республика Тоголезе',
		'TK': 'Токелау',
		'TO': 'Тонго',
		'TT': 'Тринидад и Тобаго',
		'TN': 'Тунис',
		'TR': 'Турция',
		'TM': 'Туркменистан',
		'TC': 'Теркс и Кайкос',
		'TV': 'Тувалу',
		'VI': 'Американские Виргинские острова',
		'UG': 'Уганда',
		'UA': 'Украина',
		'AE': 'О.А.Э.',
		'GB': 'Великобритания',
		'UY': 'Уругвай',
		'US': 'США',
		'UZ': 'Узбекистан',
		'VU': 'Вануату',
		'VA': 'Ватикан',
		'VE': 'Венесуэла',
		'VN': 'Вьетнам',
		'WF': 'Уоллис и Футуна',
		'EH': 'Западная Сахара',
		'WS': 'Западное Самоа',
		'CD': 'Заир',
		'ZM': 'Замбия',
		'ZW': 'Зимбабве',
	};
	@override String passwordErrorText({required Object MIN, required Object MAX}) => 'Пароль должен быть в пределах от $MIN до $MAX символов и содержать как минимум одну букву и одну цифру';
	@override String useridErrorText({required Object MIN}) => 'Логин должен содержать более $MIN символов';
	@override String get invalidPhoneNumber => 'Введите корректный номер телефона';
	@override String get invalidTime => 'Введите корректное время';
	@override String get emailIsNotValidErrorText => 'Введите корректный e-mail';
	@override String dateIsNotValidErrorText({required Object format}) => 'Введите дату в формате: $format';
	@override String get fieldIsRequiredErrorText => 'Поле не должно быть пустым';
	@override String get wrongFormatText => 'Неверный формат данных';
	@override String get fieldDoesNotMatch => 'Значения не совпадают';
	@override String get returnDateWarning => 'Не может быть раньше первой даты';
	@override String get selectDate => 'Выберите дату';
	@override String get selectTime => 'Выберите время';
	@override String get chooseCountryCode => 'Выберите или введите код страны';
	@override String get useInputtedCode => 'Использовать введенный код';
	@override String get nothingFoundCountryCode => 'Ничего не найдено, попробуйте изменить запрос или ввести код страны вручную';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on _DynamicFormLocalizationsEn {
	Map<String, dynamic> _buildFlatMap() {
		return <String, dynamic>{
			'countries.AA': 'Any number',
			'countries.AF': 'Afghanistan',
			'countries.AL': 'Albania',
			'countries.DZ': 'Algeria',
			'countries.AS': 'American Samoa',
			'countries.AD': 'Andorra',
			'countries.AO': 'Angola',
			'countries.AI': 'Anguilla',
			'countries.AG': 'Antigua and Barbuda',
			'countries.AM': 'Armenia',
			'countries.AR': 'Argentina',
			'countries.AU': 'Australia',
			'countries.AT': 'Austria',
			'countries.AZ': 'Azerbaijan',
			'countries.BS': 'Bahamas',
			'countries.BH': 'Bahrain',
			'countries.BD': 'Bangladesh',
			'countries.BB': 'Barbados',
			'countries.BY': 'Belarus',
			'countries.BE': 'Belgium',
			'countries.BZ': 'Belize',
			'countries.BJ': 'Benin',
			'countries.BM': 'Bermuda',
			'countries.BO': 'Bolivia',
			'countries.BA': 'Bosnia and Herzegovina',
			'countries.BW': 'Botswana',
			'countries.BR': 'Brazil',
			'countries.VG': 'British Virgin Islands',
			'countries.BN': 'Brunei Darusalaam',
			'countries.BG': 'Bulgaria',
			'countries.BF': 'Burkina Faso',
			'countries.BI': 'Burundi',
			'countries.KH': 'Cambodia',
			'countries.CM': 'Cameroon',
			'countries.CA': 'Canada',
			'countries.CV': 'Cape Verde',
			'countries.KY': 'Cayman Islands',
			'countries.CF': 'Central African Republic',
			'countries.TD': 'Chad',
			'countries.CL': 'Chile',
			'countries.CN': 'China',
			'countries.CX': 'Christmas Island',
			'countries.CC': 'Cocos Islands',
			'countries.CO': 'Colombia',
			'countries.KM': 'Comoros and Mayotte Island',
			'countries.CG': 'Congo',
			'countries.CK': 'Cook Islands',
			'countries.CR': 'Costa Rica',
			'countries.HR': 'Croatia',
			'countries.CU': 'Cuba',
			'countries.CY': 'Cyprus',
			'countries.CZ': 'Czech Republic',
			'countries.DK': 'Denmark',
			'countries.DG': 'Diego Garcia',
			'countries.DJ': 'Djibouti',
			'countries.DM': 'Dominica',
			'countries.DO': 'Dominican Republic',
			'countries.TL': 'East Timor',
			'countries.EC': 'Ecuador',
			'countries.EG': 'Egypt',
			'countries.SV': 'El Salvador',
			'countries.GQ': 'Equatorial Guinea',
			'countries.EE': 'Estonia',
			'countries.ET': 'Ethiopia',
			'countries.FO': 'Faeroe Islands',
			'countries.FK': 'Falkland Islands',
			'countries.FJ': 'Fiji',
			'countries.FI': 'Finland',
			'countries.FR': 'France',
			'countries.BL': 'French Antilles',
			'countries.GF': 'French Guiana',
			'countries.PF': 'French Polynesia',
			'countries.GA': 'Gabon',
			'countries.GM': 'Gambia',
			'countries.GE': 'Georgia',
			'countries.DE': 'Germany',
			'countries.GH': 'Ghana',
			'countries.GI': 'Gibraltar',
			'countries.GR': 'Greece',
			'countries.GL': 'Greenland',
			'countries.GD': 'Grenada',
			'countries.GU': 'Guam',
			'countries.GT': 'Guatemala',
			'countries.GN': 'Guinea',
			'countries.GW': 'Guinea-Bissau',
			'countries.GY': 'Guyana',
			'countries.HT': 'Haiti',
			'countries.HN': 'Honduras',
			'countries.HK': 'Hong Kong',
			'countries.HU': 'Hungary',
			'countries.IS': 'Iceland',
			'countries.IN': 'India',
			'countries.ID': 'Indonesia',
			'countries.IR': 'Iran',
			'countries.IQ': 'Iraq',
			'countries.IE': 'Irish Republic',
			'countries.IL': 'Israel',
			'countries.IT': 'Italy',
			'countries.CI': 'Ivory Coast',
			'countries.JM': 'Jamaica',
			'countries.JP': 'Japan',
			'countries.JO': 'Jordan',
			'countries.KZ': 'Kazakhstan',
			'countries.KE': 'Kenya',
			'countries.KI': 'Kiribati Republic',
			'countries.KG': 'Kirghizia',
			'countries.KW': 'Kuwait',
			'countries.LA': 'Laos',
			'countries.LV': 'Latvia',
			'countries.LB': 'Lebanon',
			'countries.LS': 'Lesotho',
			'countries.LR': 'Liberia',
			'countries.LY': 'Libya',
			'countries.LI': 'Liechtenstein',
			'countries.LT': 'Lithuania',
			'countries.LU': 'Luxembourg',
			'countries.MO': 'Macao',
			'countries.MK': 'Macedonia',
			'countries.MG': 'Madagascar',
			'countries.MW': 'Malawi',
			'countries.MY': 'Malaysia',
			'countries.MV': 'Maldives',
			'countries.ML': 'Mali',
			'countries.MT': 'Malta',
			'countries.MH': 'Marshall Islands',
			'countries.MQ': 'Martinique',
			'countries.MR': 'Mauritania',
			'countries.MU': 'Mauritius',
			'countries.MX': 'Mexico706',
			'countries.FM': 'Micronesia',
			'countries.MC': 'Monaco',
			'countries.MN': 'Mongolia',
			'countries.MS': 'Montserrat',
			'countries.MA': 'Morocco',
			'countries.MZ': 'Mozambique',
			'countries.MM': 'Myanmar',
			'countries.NA': 'Namibia',
			'countries.NR': 'Nauru',
			'countries.NP': 'Nepal',
			'countries.NL': 'Netherlands',
			'countries.AN': 'Netherlands Antilles',
			'countries.NC': 'New Caledonia',
			'countries.NZ': 'New Zealand',
			'countries.NI': 'Nicaragua',
			'countries.NE': 'Niger',
			'countries.NG': 'Nigeria',
			'countries.NU': 'Niue',
			'countries.NF': 'Norfolk Island',
			'countries.KP': 'North Korea',
			'countries.YE': 'North Yemen',
			'countries.MP': 'Northern Mariana Islands',
			'countries.NO': 'Norway',
			'countries.OM': 'Oman',
			'countries.PK': 'Pakistan',
			'countries.PA': 'Panama',
			'countries.PG': 'Papua New Guinea',
			'countries.PY': 'Paraguay',
			'countries.PE': 'Peru',
			'countries.PH': 'Philippines',
			'countries.PL': 'Poland',
			'countries.PT': 'Portugal',
			'countries.PR': 'Puerto Rico',
			'countries.QA': 'Qatar',
			'countries.RE': 'Reunion',
			'countries.RO': 'Romania',
			'countries.RU': 'Russia',
			'countries.RW': 'Rwandese Republic',
			'countries.SH': 'Saint Helena and Ascension Island',
			'countries.PM': 'Saint Pierre et Miquelon',
			'countries.SM': 'San Marino',
			'countries.ST': 'Sao Tome e Principe',
			'countries.SA': 'Saudi Arabia',
			'countries.SN': 'Senegal',
			'countries.SC': 'Seychelles',
			'countries.CS': 'Serbia',
			'countries.SL': 'Sierra Leone',
			'countries.SG': 'Singapore',
			'countries.SK': 'Slovakia',
			'countries.SI': 'Slovenia',
			'countries.SB': 'Solomon Islands',
			'countries.SO': 'Somalia',
			'countries.ZA': 'South Africa',
			'countries.KR': 'South Korea',
			'countries.YD': 'South Yemen',
			'countries.ES': 'Spain',
			'countries.LK': 'Sri Lanka',
			'countries.KN': 'St Kitts and Nevis',
			'countries.LC': 'St Lucia',
			'countries.VC': 'St Vincent and the Grenadines',
			'countries.SD': 'Sudan',
			'countries.SR': 'Suriname',
			'countries.SJ': 'Svalbard and Jan Mayen Islands',
			'countries.SZ': 'Swaziland',
			'countries.SE': 'Sweden',
			'countries.CH': 'Switzerland',
			'countries.SY': 'Syria',
			'countries.TJ': 'Tadjikistan',
			'countries.TW': 'Taiwan',
			'countries.TZ': 'Tanzania',
			'countries.TH': 'Thailand',
			'countries.TG': 'Togolese Republic',
			'countries.TK': 'Tokelau',
			'countries.TO': 'Tonga',
			'countries.TT': 'Trinidad and Tobago',
			'countries.TN': 'Tunisia',
			'countries.TR': 'Turkey',
			'countries.TM': 'Turkmenistan',
			'countries.TC': 'Turks and Caicos Islands',
			'countries.TV': 'Tuvalu',
			'countries.VI': 'US Virgin Islands',
			'countries.UG': 'Uganda',
			'countries.UA': 'Ukraine',
			'countries.AE': 'United Arab Emirates',
			'countries.GB': 'United Kingdom',
			'countries.UY': 'Uruguay',
			'countries.US': 'USA',
			'countries.UZ': 'Uzbekistan',
			'countries.VU': 'Vanuatu',
			'countries.VA': 'Vatican City',
			'countries.VE': 'Venezuela',
			'countries.VN': 'Vietnam',
			'countries.WF': 'Wallis and Futuna Islands',
			'countries.EH': 'Western Sahara',
			'countries.WS': 'Western Samoa',
			'countries.CD': 'Zaire',
			'countries.ZM': 'Zambia',
			'countries.ZW': 'Zimbabwe',
			'passwordErrorText': ({required Object MIN, required Object MAX}) => 'Your password must be between $MIN and $MAX characters and contain at least one number and one letter',
			'useridErrorText': ({required Object MIN}) => 'Login length should be greater than $MIN characters',
			'invalidPhoneNumber': 'Phone number is not valid',
			'invalidTime': 'Time is not valid',
			'emailIsNotValidErrorText': 'Email is not valid',
			'dateIsNotValidErrorText': ({required Object format}) => 'Please enter a valid date $format',
			'fieldIsRequiredErrorText': 'This field is required',
			'wrongFormatText': 'Something wrong with the format',
			'fieldDoesNotMatch': 'The value entered does not match',
			'returnDateWarning': 'Can\'t be earlier than first date',
			'selectDate': 'Select date',
			'selectTime': 'Select time',
			'chooseCountryCode': 'Select or enter country code',
			'useInputtedCode': 'Use inputted code',
			'nothingFoundCountryCode': 'Nothing found, try changing your query or entering the country code manually',
		};
	}
}

extension on _DynamicFormLocalizationsRu {
	Map<String, dynamic> _buildFlatMap() {
		return <String, dynamic>{
			'countries.AA': 'Произвольный номер',
			'countries.AF': 'Афганистан',
			'countries.AL': 'Албания',
			'countries.DZ': 'Алжир',
			'countries.AS': 'Американское Самоа',
			'countries.AD': 'Андорра',
			'countries.AO': 'Ангола',
			'countries.AI': 'Ангилья',
			'countries.AG': 'Антигуа и Барбуда',
			'countries.AM': 'Армения',
			'countries.AR': 'Аргентина',
			'countries.AU': 'Австралия',
			'countries.AT': 'Австрия',
			'countries.AZ': 'Азербайджан',
			'countries.BS': 'Багамы',
			'countries.BH': 'Бахрейн',
			'countries.BD': 'Бангладеш',
			'countries.BB': 'Барбадос',
			'countries.BY': 'Белоруссия',
			'countries.BE': 'Бельгия',
			'countries.BZ': 'Белиз',
			'countries.BJ': 'Бенин',
			'countries.BM': 'Бермудские острова',
			'countries.BO': 'Боливия',
			'countries.BA': 'Босния и Герцеговина',
			'countries.BW': 'Ботсвана',
			'countries.BR': 'Бразилия',
			'countries.VG': 'Британские Виргинские острова',
			'countries.BN': 'Бруней Даруэсалаам',
			'countries.BG': 'Болгария',
			'countries.BF': 'Буркина Фасо',
			'countries.BI': 'Бурунди',
			'countries.KH': 'Камбоджа',
			'countries.CM': 'Камерун',
			'countries.CA': 'Канада',
			'countries.CV': 'Кабо-Верде',
			'countries.KY': 'Каймановы Острова',
			'countries.CF': 'Центральноафриканская Республика',
			'countries.TD': 'Чад',
			'countries.CL': 'Чили',
			'countries.CN': 'Китай',
			'countries.CX': 'Рождественсткие острова',
			'countries.CC': 'Кокосовые острова',
			'countries.CO': 'Колумбия',
			'countries.KM': 'Коморские и Майотские острова',
			'countries.CG': 'Конго',
			'countries.CK': 'Острова Кука',
			'countries.CR': 'Коста-Рика',
			'countries.HR': 'Хорватия',
			'countries.CU': 'Куба',
			'countries.CY': 'Кипр',
			'countries.CZ': 'Чешская республика',
			'countries.DK': 'Дания',
			'countries.DG': 'Диего Гарсия',
			'countries.DJ': 'Джибути',
			'countries.DM': 'Доминика',
			'countries.DO': 'Доминиканская республика',
			'countries.TL': 'Восточный Тимор',
			'countries.EC': 'Эквадор',
			'countries.EG': 'Египет',
			'countries.SV': 'Сальвадор',
			'countries.GQ': 'Экваториальная Гвинея',
			'countries.EE': 'Эстония',
			'countries.ET': 'Эфиопия',
			'countries.FO': 'Фарерские острова',
			'countries.FK': 'Фолклендские острова',
			'countries.FJ': 'Фиджи',
			'countries.FI': 'Финляндия',
			'countries.FR': 'Франция',
			'countries.BL': 'Французские Антиллы',
			'countries.GF': 'Французская Гвиана',
			'countries.PF': 'Франзузская полинезия',
			'countries.GA': 'Габон',
			'countries.GM': 'Гамбия',
			'countries.GE': 'Грузия',
			'countries.DE': 'Германия',
			'countries.GH': 'Гана',
			'countries.GI': 'Гибралтар',
			'countries.GR': 'Греция',
			'countries.GL': 'Гренландия',
			'countries.GD': 'Гренада',
			'countries.GU': 'Гуам',
			'countries.GT': 'Гватемала',
			'countries.GN': 'Гвинея',
			'countries.GW': 'Гвинея Биссау',
			'countries.GY': 'Гайана',
			'countries.HT': 'Гаити',
			'countries.HN': 'Гондурас',
			'countries.HK': 'Гон-Конг',
			'countries.HU': 'Венгрия',
			'countries.IS': 'исландия',
			'countries.IN': 'Индия',
			'countries.ID': 'Индонезия',
			'countries.IR': 'Иран',
			'countries.IQ': 'Ирак',
			'countries.IE': 'Ирландская республика',
			'countries.IL': 'Израиль',
			'countries.IT': 'Италия',
			'countries.CI': 'Берег слоновой кости',
			'countries.JM': 'Джамайка',
			'countries.JP': 'Япония',
			'countries.JO': 'Иордания',
			'countries.KZ': 'Казахстан',
			'countries.KE': 'Кения',
			'countries.KI': 'Кирибати',
			'countries.KG': 'Кыргызстан',
			'countries.KW': 'Кувейт',
			'countries.LA': 'Лаос',
			'countries.LV': 'Латвия',
			'countries.LB': 'Ливан',
			'countries.LS': 'Лессото',
			'countries.LR': 'Либерия',
			'countries.LY': 'Ливия',
			'countries.LI': 'Лихтенштейн',
			'countries.LT': 'Литва',
			'countries.LU': 'Люксембург',
			'countries.MO': 'Макао',
			'countries.MK': 'Македония',
			'countries.MG': 'Мадагаскар',
			'countries.MW': 'Малави',
			'countries.MY': 'Малайзия',
			'countries.MV': 'Мальдивы',
			'countries.ML': 'Мали',
			'countries.MT': 'Мальта',
			'countries.MH': 'Маршалловы острова',
			'countries.MQ': 'Мартиника',
			'countries.MR': 'Мавритания',
			'countries.MU': 'Маврикий',
			'countries.MX': 'Мексика',
			'countries.FM': 'Микронезия',
			'countries.MC': 'Монако',
			'countries.MN': 'Монголия',
			'countries.MS': 'Монсеррат',
			'countries.MA': 'Мороко',
			'countries.MZ': 'Мозамбик',
			'countries.MM': 'Мьянма',
			'countries.NA': 'Намибия',
			'countries.NR': 'Науру',
			'countries.NP': 'Непал',
			'countries.NL': 'Нидерланды',
			'countries.AN': 'Нидерландские антиллы',
			'countries.NC': 'Новая каледония',
			'countries.NZ': 'Новая зеландия',
			'countries.NI': 'Никарагуа',
			'countries.NE': 'Нигер',
			'countries.NG': 'Нигерия',
			'countries.NU': 'Ниуэ',
			'countries.NF': 'Норфолкские острова',
			'countries.KP': 'Северная Корея',
			'countries.YE': 'Северный Йемен',
			'countries.MP': 'Северно Марианские острова',
			'countries.NO': 'Норвегия',
			'countries.OM': 'Оман',
			'countries.PK': 'Пакистан',
			'countries.PA': 'Панама',
			'countries.PG': 'Папуа Новая Гвинея',
			'countries.PY': 'Парагвай',
			'countries.PE': 'Перу',
			'countries.PH': 'Филипины',
			'countries.PL': 'Польша',
			'countries.PT': 'Португалия',
			'countries.PR': 'Пуэрто Рико',
			'countries.QA': 'Катар',
			'countries.RE': 'Реоньон',
			'countries.RO': 'Румыния',
			'countries.RU': 'Россия',
			'countries.RW': 'Республика Руанда',
			'countries.SH': 'Остров Вознесения',
			'countries.PM': 'Сен-Пьер и Микелон',
			'countries.SM': 'Сан Марино',
			'countries.ST': 'Сан-Томе и Принсипи',
			'countries.SA': 'Саудовская Аравия',
			'countries.SN': 'Сенегал',
			'countries.SC': 'Сейшельские Острова',
			'countries.CS': 'Сербия',
			'countries.SL': 'Сьерра Леоне',
			'countries.SG': 'Сингапур',
			'countries.SK': 'Словакия',
			'countries.SI': 'Словения',
			'countries.SB': 'Соломоновы острова',
			'countries.SO': 'Сомали',
			'countries.ZA': 'ЮАР',
			'countries.KR': 'Южная Корея',
			'countries.YD': 'Южный Йемен',
			'countries.ES': 'Испания',
			'countries.LK': 'Шри Ланка',
			'countries.KN': 'Сент-Китс и Невис',
			'countries.LC': 'Сент-Люсия',
			'countries.VC': 'Сент-Винсент и Гренадины',
			'countries.SD': 'Судан',
			'countries.SR': 'Суринам',
			'countries.SJ': 'Шпицберген и Ян-Майен',
			'countries.SZ': 'Свазиленд',
			'countries.SE': 'Швеция',
			'countries.CH': 'Швейцария',
			'countries.SY': 'Сирия',
			'countries.TJ': 'Таджикистан',
			'countries.TW': 'Тайвань',
			'countries.TZ': 'Танзания',
			'countries.TH': 'Тайланд',
			'countries.TG': 'Республика Тоголезе',
			'countries.TK': 'Токелау',
			'countries.TO': 'Тонго',
			'countries.TT': 'Тринидад и Тобаго',
			'countries.TN': 'Тунис',
			'countries.TR': 'Турция',
			'countries.TM': 'Туркменистан',
			'countries.TC': 'Теркс и Кайкос',
			'countries.TV': 'Тувалу',
			'countries.VI': 'Американские Виргинские острова',
			'countries.UG': 'Уганда',
			'countries.UA': 'Украина',
			'countries.AE': 'О.А.Э.',
			'countries.GB': 'Великобритания',
			'countries.UY': 'Уругвай',
			'countries.US': 'США',
			'countries.UZ': 'Узбекистан',
			'countries.VU': 'Вануату',
			'countries.VA': 'Ватикан',
			'countries.VE': 'Венесуэла',
			'countries.VN': 'Вьетнам',
			'countries.WF': 'Уоллис и Футуна',
			'countries.EH': 'Западная Сахара',
			'countries.WS': 'Западное Самоа',
			'countries.CD': 'Заир',
			'countries.ZM': 'Замбия',
			'countries.ZW': 'Зимбабве',
			'passwordErrorText': ({required Object MIN, required Object MAX}) => 'Пароль должен быть в пределах от $MIN до $MAX символов и содержать как минимум одну букву и одну цифру',
			'useridErrorText': ({required Object MIN}) => 'Логин должен содержать более $MIN символов',
			'invalidPhoneNumber': 'Введите корректный номер телефона',
			'invalidTime': 'Введите корректное время',
			'emailIsNotValidErrorText': 'Введите корректный e-mail',
			'dateIsNotValidErrorText': ({required Object format}) => 'Введите дату в формате: $format',
			'fieldIsRequiredErrorText': 'Поле не должно быть пустым',
			'wrongFormatText': 'Неверный формат данных',
			'fieldDoesNotMatch': 'Значения не совпадают',
			'returnDateWarning': 'Не может быть раньше первой даты',
			'selectDate': 'Выберите дату',
			'selectTime': 'Выберите время',
			'chooseCountryCode': 'Выберите или введите код страны',
			'useInputtedCode': 'Использовать введенный код',
			'nothingFoundCountryCode': 'Ничего не найдено, попробуйте изменить запрос или ввести код страны вручную',
		};
	}
}
