/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 536 (268 per locale)
///
/// Built on 2023-11-01 at 10:20 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, _StringsEn> {
	en(languageCode: 'en', build: _StringsEn.build),
	ru(languageCode: 'ru', build: _StringsRu.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, _StringsEn> build;

	/// Gets current instance managed by [LocaleSettings].
	_StringsEn get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
_StringsEn get t => LocaleSettings.instance.currentTranslations;

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
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class Translations {
	Translations._(); // no constructor

	static _StringsEn of(BuildContext context) => InheritedLocaleData.of<AppLocale, _StringsEn>(context).translations;
}

/// The provider for method B
class TranslationProvider extends BaseTranslationProvider<AppLocale, _StringsEn> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, _StringsEn> of(BuildContext context) => InheritedLocaleData.of<AppLocale, _StringsEn>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	_StringsEn get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, _StringsEn> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, _StringsEn> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class _StringsEn implements BaseTranslations<AppLocale, _StringsEn> {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsEn.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, _StringsEn> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final _StringsEn _root = this; // ignore: unused_field

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
	String passwordErrorText({required Object MIN, required Object MAX}) => 'Your password must be between ${MIN} and ${MAX} characters and contain at least one number and one letter';
	String useridErrorText({required Object MIN}) => 'Login length should be greater than ${MIN} characters';
	String get invalidPhoneNumber => 'Phone number is not valid';
	String get invalidTime => 'Time is not valid';
	String get emailIsNotValidErrorText => 'Email is not valid';
	String dateIsNotValidErrorText({required Object format}) => 'Please enter a valid date ${format}';
	String get fieldIsRequiredErrorText => 'This field is required';
	String get wrongFormatText => 'Something wrong with the format';
	String get fieldDoesNotMatch => 'The value entered does not match';
	String get returnDateWarning => 'Can\'t be earlier than first date';
	String get periodDateWarning => 'Can\'t get the period, please fill it correctly';
	String get selectDate => 'Select date';
	String get selectTime => 'Select time';
	String get chooseCountryCode => 'Select or enter country code';
	String get useInputtedCode => 'Use inputted code';
	String get nothingFoundCountryCode => 'Nothing found, try changing your query or entering the country code manually';
	String get clear => 'Clear';
	String get selectPeriod => 'Select Period';
	String get done => 'Done';
	String get wrongLinkSnack => 'This link is incorrect, try replacing it with the correct one';
	List<String> get months => [
		'January',
		'February',
		'March',
		'April',
		'May',
		'June',
		'July',
		'August',
		'September',
		'October',
		'November',
		'December',
	];
	List<String> get weeksShort => [
		'Mo',
		'Tu',
		'We',
		'Th',
		'Fr',
		'Sa',
		'Su',
	];
	String get startDate => 'Start Date';
	String get endDate => 'End Date';
}

// Path: <root>
class _StringsRu implements _StringsEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsRu.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.ru,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ru>.
	@override final TranslationMetadata<AppLocale, _StringsEn> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _StringsRu _root = this; // ignore: unused_field

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
	@override String passwordErrorText({required Object MIN, required Object MAX}) => 'Пароль должен быть в пределах от ${MIN} до ${MAX} символов и содержать как минимум одну букву и одну цифру';
	@override String useridErrorText({required Object MIN}) => 'Логин должен содержать более ${MIN} символов';
	@override String get invalidPhoneNumber => 'Введите корректный номер телефона';
	@override String get invalidTime => 'Введите корректное время';
	@override String get emailIsNotValidErrorText => 'Введите корректный e-mail';
	@override String dateIsNotValidErrorText({required Object format}) => 'Введите дату в формате: ${format}';
	@override String get fieldIsRequiredErrorText => 'Поле не должно быть пустым';
	@override String get wrongFormatText => 'Неверный формат данных';
	@override String get fieldDoesNotMatch => 'Значения не совпадают';
	@override String get returnDateWarning => 'Не может быть раньше первой даты';
	@override String get periodDateWarning => 'Неверный формат периода, пожалуйста исправьте и попробуйте снова';
	@override String get selectDate => 'Выберите дату';
	@override String get selectTime => 'Выберите время';
	@override String get chooseCountryCode => 'Выберите или введите код страны';
	@override String get useInputtedCode => 'Использовать введенный код';
	@override String get nothingFoundCountryCode => 'Ничего не найдено, попробуйте изменить запрос или ввести код страны вручную';
	@override String get clear => 'Очистить';
	@override String get selectPeriod => 'Выберите период';
	@override String get done => 'Готово';
	@override String get wrongLinkSnack => 'Эта ссылка некорректная, вставьте правильную и попробуйте еще раз';
	@override List<String> get months => [
		'Январь',
		'Февраль',
		'Март',
		'Апрель',
		'Май',
		'Июнь',
		'Июль',
		'Август',
		'Сентябрб',
		'Октябрь',
		'Ноябрь',
		'Декабрь',
	];
	@override List<String> get weeksShort => [
		'Пн',
		'Вт',
		'Ср',
		'Чт',
		'Пт',
		'Сб',
		'Вс',
	];
	@override String get startDate => 'Дата начала';
	@override String get endDate => 'Дата окончания';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on _StringsEn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'countries.AA': return 'Any number';
			case 'countries.AF': return 'Afghanistan';
			case 'countries.AL': return 'Albania';
			case 'countries.DZ': return 'Algeria';
			case 'countries.AS': return 'American Samoa';
			case 'countries.AD': return 'Andorra';
			case 'countries.AO': return 'Angola';
			case 'countries.AI': return 'Anguilla';
			case 'countries.AG': return 'Antigua and Barbuda';
			case 'countries.AM': return 'Armenia';
			case 'countries.AR': return 'Argentina';
			case 'countries.AU': return 'Australia';
			case 'countries.AT': return 'Austria';
			case 'countries.AZ': return 'Azerbaijan';
			case 'countries.BS': return 'Bahamas';
			case 'countries.BH': return 'Bahrain';
			case 'countries.BD': return 'Bangladesh';
			case 'countries.BB': return 'Barbados';
			case 'countries.BY': return 'Belarus';
			case 'countries.BE': return 'Belgium';
			case 'countries.BZ': return 'Belize';
			case 'countries.BJ': return 'Benin';
			case 'countries.BM': return 'Bermuda';
			case 'countries.BO': return 'Bolivia';
			case 'countries.BA': return 'Bosnia and Herzegovina';
			case 'countries.BW': return 'Botswana';
			case 'countries.BR': return 'Brazil';
			case 'countries.VG': return 'British Virgin Islands';
			case 'countries.BN': return 'Brunei Darusalaam';
			case 'countries.BG': return 'Bulgaria';
			case 'countries.BF': return 'Burkina Faso';
			case 'countries.BI': return 'Burundi';
			case 'countries.KH': return 'Cambodia';
			case 'countries.CM': return 'Cameroon';
			case 'countries.CA': return 'Canada';
			case 'countries.CV': return 'Cape Verde';
			case 'countries.KY': return 'Cayman Islands';
			case 'countries.CF': return 'Central African Republic';
			case 'countries.TD': return 'Chad';
			case 'countries.CL': return 'Chile';
			case 'countries.CN': return 'China';
			case 'countries.CX': return 'Christmas Island';
			case 'countries.CC': return 'Cocos Islands';
			case 'countries.CO': return 'Colombia';
			case 'countries.KM': return 'Comoros and Mayotte Island';
			case 'countries.CG': return 'Congo';
			case 'countries.CK': return 'Cook Islands';
			case 'countries.CR': return 'Costa Rica';
			case 'countries.HR': return 'Croatia';
			case 'countries.CU': return 'Cuba';
			case 'countries.CY': return 'Cyprus';
			case 'countries.CZ': return 'Czech Republic';
			case 'countries.DK': return 'Denmark';
			case 'countries.DG': return 'Diego Garcia';
			case 'countries.DJ': return 'Djibouti';
			case 'countries.DM': return 'Dominica';
			case 'countries.DO': return 'Dominican Republic';
			case 'countries.TL': return 'East Timor';
			case 'countries.EC': return 'Ecuador';
			case 'countries.EG': return 'Egypt';
			case 'countries.SV': return 'El Salvador';
			case 'countries.GQ': return 'Equatorial Guinea';
			case 'countries.EE': return 'Estonia';
			case 'countries.ET': return 'Ethiopia';
			case 'countries.FO': return 'Faeroe Islands';
			case 'countries.FK': return 'Falkland Islands';
			case 'countries.FJ': return 'Fiji';
			case 'countries.FI': return 'Finland';
			case 'countries.FR': return 'France';
			case 'countries.BL': return 'French Antilles';
			case 'countries.GF': return 'French Guiana';
			case 'countries.PF': return 'French Polynesia';
			case 'countries.GA': return 'Gabon';
			case 'countries.GM': return 'Gambia';
			case 'countries.GE': return 'Georgia';
			case 'countries.DE': return 'Germany';
			case 'countries.GH': return 'Ghana';
			case 'countries.GI': return 'Gibraltar';
			case 'countries.GR': return 'Greece';
			case 'countries.GL': return 'Greenland';
			case 'countries.GD': return 'Grenada';
			case 'countries.GU': return 'Guam';
			case 'countries.GT': return 'Guatemala';
			case 'countries.GN': return 'Guinea';
			case 'countries.GW': return 'Guinea-Bissau';
			case 'countries.GY': return 'Guyana';
			case 'countries.HT': return 'Haiti';
			case 'countries.HN': return 'Honduras';
			case 'countries.HK': return 'Hong Kong';
			case 'countries.HU': return 'Hungary';
			case 'countries.IS': return 'Iceland';
			case 'countries.IN': return 'India';
			case 'countries.ID': return 'Indonesia';
			case 'countries.IR': return 'Iran';
			case 'countries.IQ': return 'Iraq';
			case 'countries.IE': return 'Irish Republic';
			case 'countries.IL': return 'Israel';
			case 'countries.IT': return 'Italy';
			case 'countries.CI': return 'Ivory Coast';
			case 'countries.JM': return 'Jamaica';
			case 'countries.JP': return 'Japan';
			case 'countries.JO': return 'Jordan';
			case 'countries.KZ': return 'Kazakhstan';
			case 'countries.KE': return 'Kenya';
			case 'countries.KI': return 'Kiribati Republic';
			case 'countries.KG': return 'Kirghizia';
			case 'countries.KW': return 'Kuwait';
			case 'countries.LA': return 'Laos';
			case 'countries.LV': return 'Latvia';
			case 'countries.LB': return 'Lebanon';
			case 'countries.LS': return 'Lesotho';
			case 'countries.LR': return 'Liberia';
			case 'countries.LY': return 'Libya';
			case 'countries.LI': return 'Liechtenstein';
			case 'countries.LT': return 'Lithuania';
			case 'countries.LU': return 'Luxembourg';
			case 'countries.MO': return 'Macao';
			case 'countries.MK': return 'Macedonia';
			case 'countries.MG': return 'Madagascar';
			case 'countries.MW': return 'Malawi';
			case 'countries.MY': return 'Malaysia';
			case 'countries.MV': return 'Maldives';
			case 'countries.ML': return 'Mali';
			case 'countries.MT': return 'Malta';
			case 'countries.MH': return 'Marshall Islands';
			case 'countries.MQ': return 'Martinique';
			case 'countries.MR': return 'Mauritania';
			case 'countries.MU': return 'Mauritius';
			case 'countries.MX': return 'Mexico706';
			case 'countries.FM': return 'Micronesia';
			case 'countries.MC': return 'Monaco';
			case 'countries.MN': return 'Mongolia';
			case 'countries.MS': return 'Montserrat';
			case 'countries.MA': return 'Morocco';
			case 'countries.MZ': return 'Mozambique';
			case 'countries.MM': return 'Myanmar';
			case 'countries.NA': return 'Namibia';
			case 'countries.NR': return 'Nauru';
			case 'countries.NP': return 'Nepal';
			case 'countries.NL': return 'Netherlands';
			case 'countries.AN': return 'Netherlands Antilles';
			case 'countries.NC': return 'New Caledonia';
			case 'countries.NZ': return 'New Zealand';
			case 'countries.NI': return 'Nicaragua';
			case 'countries.NE': return 'Niger';
			case 'countries.NG': return 'Nigeria';
			case 'countries.NU': return 'Niue';
			case 'countries.NF': return 'Norfolk Island';
			case 'countries.KP': return 'North Korea';
			case 'countries.YE': return 'North Yemen';
			case 'countries.MP': return 'Northern Mariana Islands';
			case 'countries.NO': return 'Norway';
			case 'countries.OM': return 'Oman';
			case 'countries.PK': return 'Pakistan';
			case 'countries.PA': return 'Panama';
			case 'countries.PG': return 'Papua New Guinea';
			case 'countries.PY': return 'Paraguay';
			case 'countries.PE': return 'Peru';
			case 'countries.PH': return 'Philippines';
			case 'countries.PL': return 'Poland';
			case 'countries.PT': return 'Portugal';
			case 'countries.PR': return 'Puerto Rico';
			case 'countries.QA': return 'Qatar';
			case 'countries.RE': return 'Reunion';
			case 'countries.RO': return 'Romania';
			case 'countries.RU': return 'Russia';
			case 'countries.RW': return 'Rwandese Republic';
			case 'countries.SH': return 'Saint Helena and Ascension Island';
			case 'countries.PM': return 'Saint Pierre et Miquelon';
			case 'countries.SM': return 'San Marino';
			case 'countries.ST': return 'Sao Tome e Principe';
			case 'countries.SA': return 'Saudi Arabia';
			case 'countries.SN': return 'Senegal';
			case 'countries.SC': return 'Seychelles';
			case 'countries.CS': return 'Serbia';
			case 'countries.SL': return 'Sierra Leone';
			case 'countries.SG': return 'Singapore';
			case 'countries.SK': return 'Slovakia';
			case 'countries.SI': return 'Slovenia';
			case 'countries.SB': return 'Solomon Islands';
			case 'countries.SO': return 'Somalia';
			case 'countries.ZA': return 'South Africa';
			case 'countries.KR': return 'South Korea';
			case 'countries.YD': return 'South Yemen';
			case 'countries.ES': return 'Spain';
			case 'countries.LK': return 'Sri Lanka';
			case 'countries.KN': return 'St Kitts and Nevis';
			case 'countries.LC': return 'St Lucia';
			case 'countries.VC': return 'St Vincent and the Grenadines';
			case 'countries.SD': return 'Sudan';
			case 'countries.SR': return 'Suriname';
			case 'countries.SJ': return 'Svalbard and Jan Mayen Islands';
			case 'countries.SZ': return 'Swaziland';
			case 'countries.SE': return 'Sweden';
			case 'countries.CH': return 'Switzerland';
			case 'countries.SY': return 'Syria';
			case 'countries.TJ': return 'Tadjikistan';
			case 'countries.TW': return 'Taiwan';
			case 'countries.TZ': return 'Tanzania';
			case 'countries.TH': return 'Thailand';
			case 'countries.TG': return 'Togolese Republic';
			case 'countries.TK': return 'Tokelau';
			case 'countries.TO': return 'Tonga';
			case 'countries.TT': return 'Trinidad and Tobago';
			case 'countries.TN': return 'Tunisia';
			case 'countries.TR': return 'Turkey';
			case 'countries.TM': return 'Turkmenistan';
			case 'countries.TC': return 'Turks and Caicos Islands';
			case 'countries.TV': return 'Tuvalu';
			case 'countries.VI': return 'US Virgin Islands';
			case 'countries.UG': return 'Uganda';
			case 'countries.UA': return 'Ukraine';
			case 'countries.AE': return 'United Arab Emirates';
			case 'countries.GB': return 'United Kingdom';
			case 'countries.UY': return 'Uruguay';
			case 'countries.US': return 'USA';
			case 'countries.UZ': return 'Uzbekistan';
			case 'countries.VU': return 'Vanuatu';
			case 'countries.VA': return 'Vatican City';
			case 'countries.VE': return 'Venezuela';
			case 'countries.VN': return 'Vietnam';
			case 'countries.WF': return 'Wallis and Futuna Islands';
			case 'countries.EH': return 'Western Sahara';
			case 'countries.WS': return 'Western Samoa';
			case 'countries.CD': return 'Zaire';
			case 'countries.ZM': return 'Zambia';
			case 'countries.ZW': return 'Zimbabwe';
			case 'passwordErrorText': return ({required Object MIN, required Object MAX}) => 'Your password must be between ${MIN} and ${MAX} characters and contain at least one number and one letter';
			case 'useridErrorText': return ({required Object MIN}) => 'Login length should be greater than ${MIN} characters';
			case 'invalidPhoneNumber': return 'Phone number is not valid';
			case 'invalidTime': return 'Time is not valid';
			case 'emailIsNotValidErrorText': return 'Email is not valid';
			case 'dateIsNotValidErrorText': return ({required Object format}) => 'Please enter a valid date ${format}';
			case 'fieldIsRequiredErrorText': return 'This field is required';
			case 'wrongFormatText': return 'Something wrong with the format';
			case 'fieldDoesNotMatch': return 'The value entered does not match';
			case 'returnDateWarning': return 'Can\'t be earlier than first date';
			case 'periodDateWarning': return 'Can\'t get the period, please fill it correctly';
			case 'selectDate': return 'Select date';
			case 'selectTime': return 'Select time';
			case 'chooseCountryCode': return 'Select or enter country code';
			case 'useInputtedCode': return 'Use inputted code';
			case 'nothingFoundCountryCode': return 'Nothing found, try changing your query or entering the country code manually';
			case 'clear': return 'Clear';
			case 'selectPeriod': return 'Select Period';
			case 'done': return 'Done';
			case 'wrongLinkSnack': return 'This link is incorrect, try replacing it with the correct one';
			case 'months.0': return 'January';
			case 'months.1': return 'February';
			case 'months.2': return 'March';
			case 'months.3': return 'April';
			case 'months.4': return 'May';
			case 'months.5': return 'June';
			case 'months.6': return 'July';
			case 'months.7': return 'August';
			case 'months.8': return 'September';
			case 'months.9': return 'October';
			case 'months.10': return 'November';
			case 'months.11': return 'December';
			case 'weeksShort.0': return 'Mo';
			case 'weeksShort.1': return 'Tu';
			case 'weeksShort.2': return 'We';
			case 'weeksShort.3': return 'Th';
			case 'weeksShort.4': return 'Fr';
			case 'weeksShort.5': return 'Sa';
			case 'weeksShort.6': return 'Su';
			case 'startDate': return 'Start Date';
			case 'endDate': return 'End Date';
			default: return null;
		}
	}
}

extension on _StringsRu {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'countries.AA': return 'Произвольный номер';
			case 'countries.AF': return 'Афганистан';
			case 'countries.AL': return 'Албания';
			case 'countries.DZ': return 'Алжир';
			case 'countries.AS': return 'Американское Самоа';
			case 'countries.AD': return 'Андорра';
			case 'countries.AO': return 'Ангола';
			case 'countries.AI': return 'Ангилья';
			case 'countries.AG': return 'Антигуа и Барбуда';
			case 'countries.AM': return 'Армения';
			case 'countries.AR': return 'Аргентина';
			case 'countries.AU': return 'Австралия';
			case 'countries.AT': return 'Австрия';
			case 'countries.AZ': return 'Азербайджан';
			case 'countries.BS': return 'Багамы';
			case 'countries.BH': return 'Бахрейн';
			case 'countries.BD': return 'Бангладеш';
			case 'countries.BB': return 'Барбадос';
			case 'countries.BY': return 'Белоруссия';
			case 'countries.BE': return 'Бельгия';
			case 'countries.BZ': return 'Белиз';
			case 'countries.BJ': return 'Бенин';
			case 'countries.BM': return 'Бермудские острова';
			case 'countries.BO': return 'Боливия';
			case 'countries.BA': return 'Босния и Герцеговина';
			case 'countries.BW': return 'Ботсвана';
			case 'countries.BR': return 'Бразилия';
			case 'countries.VG': return 'Британские Виргинские острова';
			case 'countries.BN': return 'Бруней Даруэсалаам';
			case 'countries.BG': return 'Болгария';
			case 'countries.BF': return 'Буркина Фасо';
			case 'countries.BI': return 'Бурунди';
			case 'countries.KH': return 'Камбоджа';
			case 'countries.CM': return 'Камерун';
			case 'countries.CA': return 'Канада';
			case 'countries.CV': return 'Кабо-Верде';
			case 'countries.KY': return 'Каймановы Острова';
			case 'countries.CF': return 'Центральноафриканская Республика';
			case 'countries.TD': return 'Чад';
			case 'countries.CL': return 'Чили';
			case 'countries.CN': return 'Китай';
			case 'countries.CX': return 'Рождественсткие острова';
			case 'countries.CC': return 'Кокосовые острова';
			case 'countries.CO': return 'Колумбия';
			case 'countries.KM': return 'Коморские и Майотские острова';
			case 'countries.CG': return 'Конго';
			case 'countries.CK': return 'Острова Кука';
			case 'countries.CR': return 'Коста-Рика';
			case 'countries.HR': return 'Хорватия';
			case 'countries.CU': return 'Куба';
			case 'countries.CY': return 'Кипр';
			case 'countries.CZ': return 'Чешская республика';
			case 'countries.DK': return 'Дания';
			case 'countries.DG': return 'Диего Гарсия';
			case 'countries.DJ': return 'Джибути';
			case 'countries.DM': return 'Доминика';
			case 'countries.DO': return 'Доминиканская республика';
			case 'countries.TL': return 'Восточный Тимор';
			case 'countries.EC': return 'Эквадор';
			case 'countries.EG': return 'Египет';
			case 'countries.SV': return 'Сальвадор';
			case 'countries.GQ': return 'Экваториальная Гвинея';
			case 'countries.EE': return 'Эстония';
			case 'countries.ET': return 'Эфиопия';
			case 'countries.FO': return 'Фарерские острова';
			case 'countries.FK': return 'Фолклендские острова';
			case 'countries.FJ': return 'Фиджи';
			case 'countries.FI': return 'Финляндия';
			case 'countries.FR': return 'Франция';
			case 'countries.BL': return 'Французские Антиллы';
			case 'countries.GF': return 'Французская Гвиана';
			case 'countries.PF': return 'Франзузская полинезия';
			case 'countries.GA': return 'Габон';
			case 'countries.GM': return 'Гамбия';
			case 'countries.GE': return 'Грузия';
			case 'countries.DE': return 'Германия';
			case 'countries.GH': return 'Гана';
			case 'countries.GI': return 'Гибралтар';
			case 'countries.GR': return 'Греция';
			case 'countries.GL': return 'Гренландия';
			case 'countries.GD': return 'Гренада';
			case 'countries.GU': return 'Гуам';
			case 'countries.GT': return 'Гватемала';
			case 'countries.GN': return 'Гвинея';
			case 'countries.GW': return 'Гвинея Биссау';
			case 'countries.GY': return 'Гайана';
			case 'countries.HT': return 'Гаити';
			case 'countries.HN': return 'Гондурас';
			case 'countries.HK': return 'Гон-Конг';
			case 'countries.HU': return 'Венгрия';
			case 'countries.IS': return 'исландия';
			case 'countries.IN': return 'Индия';
			case 'countries.ID': return 'Индонезия';
			case 'countries.IR': return 'Иран';
			case 'countries.IQ': return 'Ирак';
			case 'countries.IE': return 'Ирландская республика';
			case 'countries.IL': return 'Израиль';
			case 'countries.IT': return 'Италия';
			case 'countries.CI': return 'Берег слоновой кости';
			case 'countries.JM': return 'Джамайка';
			case 'countries.JP': return 'Япония';
			case 'countries.JO': return 'Иордания';
			case 'countries.KZ': return 'Казахстан';
			case 'countries.KE': return 'Кения';
			case 'countries.KI': return 'Кирибати';
			case 'countries.KG': return 'Кыргызстан';
			case 'countries.KW': return 'Кувейт';
			case 'countries.LA': return 'Лаос';
			case 'countries.LV': return 'Латвия';
			case 'countries.LB': return 'Ливан';
			case 'countries.LS': return 'Лессото';
			case 'countries.LR': return 'Либерия';
			case 'countries.LY': return 'Ливия';
			case 'countries.LI': return 'Лихтенштейн';
			case 'countries.LT': return 'Литва';
			case 'countries.LU': return 'Люксембург';
			case 'countries.MO': return 'Макао';
			case 'countries.MK': return 'Македония';
			case 'countries.MG': return 'Мадагаскар';
			case 'countries.MW': return 'Малави';
			case 'countries.MY': return 'Малайзия';
			case 'countries.MV': return 'Мальдивы';
			case 'countries.ML': return 'Мали';
			case 'countries.MT': return 'Мальта';
			case 'countries.MH': return 'Маршалловы острова';
			case 'countries.MQ': return 'Мартиника';
			case 'countries.MR': return 'Мавритания';
			case 'countries.MU': return 'Маврикий';
			case 'countries.MX': return 'Мексика';
			case 'countries.FM': return 'Микронезия';
			case 'countries.MC': return 'Монако';
			case 'countries.MN': return 'Монголия';
			case 'countries.MS': return 'Монсеррат';
			case 'countries.MA': return 'Мороко';
			case 'countries.MZ': return 'Мозамбик';
			case 'countries.MM': return 'Мьянма';
			case 'countries.NA': return 'Намибия';
			case 'countries.NR': return 'Науру';
			case 'countries.NP': return 'Непал';
			case 'countries.NL': return 'Нидерланды';
			case 'countries.AN': return 'Нидерландские антиллы';
			case 'countries.NC': return 'Новая каледония';
			case 'countries.NZ': return 'Новая зеландия';
			case 'countries.NI': return 'Никарагуа';
			case 'countries.NE': return 'Нигер';
			case 'countries.NG': return 'Нигерия';
			case 'countries.NU': return 'Ниуэ';
			case 'countries.NF': return 'Норфолкские острова';
			case 'countries.KP': return 'Северная Корея';
			case 'countries.YE': return 'Северный Йемен';
			case 'countries.MP': return 'Северно Марианские острова';
			case 'countries.NO': return 'Норвегия';
			case 'countries.OM': return 'Оман';
			case 'countries.PK': return 'Пакистан';
			case 'countries.PA': return 'Панама';
			case 'countries.PG': return 'Папуа Новая Гвинея';
			case 'countries.PY': return 'Парагвай';
			case 'countries.PE': return 'Перу';
			case 'countries.PH': return 'Филипины';
			case 'countries.PL': return 'Польша';
			case 'countries.PT': return 'Португалия';
			case 'countries.PR': return 'Пуэрто Рико';
			case 'countries.QA': return 'Катар';
			case 'countries.RE': return 'Реоньон';
			case 'countries.RO': return 'Румыния';
			case 'countries.RU': return 'Россия';
			case 'countries.RW': return 'Республика Руанда';
			case 'countries.SH': return 'Остров Вознесения';
			case 'countries.PM': return 'Сен-Пьер и Микелон';
			case 'countries.SM': return 'Сан Марино';
			case 'countries.ST': return 'Сан-Томе и Принсипи';
			case 'countries.SA': return 'Саудовская Аравия';
			case 'countries.SN': return 'Сенегал';
			case 'countries.SC': return 'Сейшельские Острова';
			case 'countries.CS': return 'Сербия';
			case 'countries.SL': return 'Сьерра Леоне';
			case 'countries.SG': return 'Сингапур';
			case 'countries.SK': return 'Словакия';
			case 'countries.SI': return 'Словения';
			case 'countries.SB': return 'Соломоновы острова';
			case 'countries.SO': return 'Сомали';
			case 'countries.ZA': return 'ЮАР';
			case 'countries.KR': return 'Южная Корея';
			case 'countries.YD': return 'Южный Йемен';
			case 'countries.ES': return 'Испания';
			case 'countries.LK': return 'Шри Ланка';
			case 'countries.KN': return 'Сент-Китс и Невис';
			case 'countries.LC': return 'Сент-Люсия';
			case 'countries.VC': return 'Сент-Винсент и Гренадины';
			case 'countries.SD': return 'Судан';
			case 'countries.SR': return 'Суринам';
			case 'countries.SJ': return 'Шпицберген и Ян-Майен';
			case 'countries.SZ': return 'Свазиленд';
			case 'countries.SE': return 'Швеция';
			case 'countries.CH': return 'Швейцария';
			case 'countries.SY': return 'Сирия';
			case 'countries.TJ': return 'Таджикистан';
			case 'countries.TW': return 'Тайвань';
			case 'countries.TZ': return 'Танзания';
			case 'countries.TH': return 'Тайланд';
			case 'countries.TG': return 'Республика Тоголезе';
			case 'countries.TK': return 'Токелау';
			case 'countries.TO': return 'Тонго';
			case 'countries.TT': return 'Тринидад и Тобаго';
			case 'countries.TN': return 'Тунис';
			case 'countries.TR': return 'Турция';
			case 'countries.TM': return 'Туркменистан';
			case 'countries.TC': return 'Теркс и Кайкос';
			case 'countries.TV': return 'Тувалу';
			case 'countries.VI': return 'Американские Виргинские острова';
			case 'countries.UG': return 'Уганда';
			case 'countries.UA': return 'Украина';
			case 'countries.AE': return 'О.А.Э.';
			case 'countries.GB': return 'Великобритания';
			case 'countries.UY': return 'Уругвай';
			case 'countries.US': return 'США';
			case 'countries.UZ': return 'Узбекистан';
			case 'countries.VU': return 'Вануату';
			case 'countries.VA': return 'Ватикан';
			case 'countries.VE': return 'Венесуэла';
			case 'countries.VN': return 'Вьетнам';
			case 'countries.WF': return 'Уоллис и Футуна';
			case 'countries.EH': return 'Западная Сахара';
			case 'countries.WS': return 'Западное Самоа';
			case 'countries.CD': return 'Заир';
			case 'countries.ZM': return 'Замбия';
			case 'countries.ZW': return 'Зимбабве';
			case 'passwordErrorText': return ({required Object MIN, required Object MAX}) => 'Пароль должен быть в пределах от ${MIN} до ${MAX} символов и содержать как минимум одну букву и одну цифру';
			case 'useridErrorText': return ({required Object MIN}) => 'Логин должен содержать более ${MIN} символов';
			case 'invalidPhoneNumber': return 'Введите корректный номер телефона';
			case 'invalidTime': return 'Введите корректное время';
			case 'emailIsNotValidErrorText': return 'Введите корректный e-mail';
			case 'dateIsNotValidErrorText': return ({required Object format}) => 'Введите дату в формате: ${format}';
			case 'fieldIsRequiredErrorText': return 'Поле не должно быть пустым';
			case 'wrongFormatText': return 'Неверный формат данных';
			case 'fieldDoesNotMatch': return 'Значения не совпадают';
			case 'returnDateWarning': return 'Не может быть раньше первой даты';
			case 'periodDateWarning': return 'Неверный формат периода, пожалуйста исправьте и попробуйте снова';
			case 'selectDate': return 'Выберите дату';
			case 'selectTime': return 'Выберите время';
			case 'chooseCountryCode': return 'Выберите или введите код страны';
			case 'useInputtedCode': return 'Использовать введенный код';
			case 'nothingFoundCountryCode': return 'Ничего не найдено, попробуйте изменить запрос или ввести код страны вручную';
			case 'clear': return 'Очистить';
			case 'selectPeriod': return 'Выберите период';
			case 'done': return 'Готово';
			case 'wrongLinkSnack': return 'Эта ссылка некорректная, вставьте правильную и попробуйте еще раз';
			case 'months.0': return 'Январь';
			case 'months.1': return 'Февраль';
			case 'months.2': return 'Март';
			case 'months.3': return 'Апрель';
			case 'months.4': return 'Май';
			case 'months.5': return 'Июнь';
			case 'months.6': return 'Июль';
			case 'months.7': return 'Август';
			case 'months.8': return 'Сентябрб';
			case 'months.9': return 'Октябрь';
			case 'months.10': return 'Ноябрь';
			case 'months.11': return 'Декабрь';
			case 'weeksShort.0': return 'Пн';
			case 'weeksShort.1': return 'Вт';
			case 'weeksShort.2': return 'Ср';
			case 'weeksShort.3': return 'Чт';
			case 'weeksShort.4': return 'Пт';
			case 'weeksShort.5': return 'Сб';
			case 'weeksShort.6': return 'Вс';
			case 'startDate': return 'Дата начала';
			case 'endDate': return 'Дата окончания';
			default: return null;
		}
	}
}
