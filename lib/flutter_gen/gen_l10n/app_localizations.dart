import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get sign_up;

  /// No description provided for @sign_out.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get sign_out;

  /// No description provided for @welcome_app.
  ///
  /// In en, this message translates to:
  /// **'Let\'s embark on the journey of learning English with the Flat Card app right now and explore the exciting and potential_filled world of the English language!'**
  String get welcome_app;

  /// No description provided for @login_google.
  ///
  /// In en, this message translates to:
  /// **'Login with Google'**
  String get login_google;

  /// No description provided for @login_facebook.
  ///
  /// In en, this message translates to:
  /// **'Login with Facebook'**
  String get login_facebook;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @new_topic.
  ///
  /// In en, this message translates to:
  /// **'New topic'**
  String get new_topic;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @folder.
  ///
  /// In en, this message translates to:
  /// **'Folder'**
  String get folder;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @terms.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get terms;

  /// No description provided for @define.
  ///
  /// In en, this message translates to:
  /// **'Define'**
  String get define;

  /// No description provided for @spelling.
  ///
  /// In en, this message translates to:
  /// **'Spelling'**
  String get spelling;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @example.
  ///
  /// In en, this message translates to:
  /// **'Example'**
  String get example;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @app.
  ///
  /// In en, this message translates to:
  /// **'App'**
  String get app;

  /// No description provided for @lets_learn_a_lot_of_new_words_together.
  ///
  /// In en, this message translates to:
  /// **'Let\'s learn a lot of new words together'**
  String get lets_learn_a_lot_of_new_words_together;

  /// No description provided for @topic.
  ///
  /// In en, this message translates to:
  /// **'Topic'**
  String get topic;

  /// No description provided for @input.
  ///
  /// In en, this message translates to:
  /// **'Input'**
  String get input;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'title'**
  String get title;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @list_vocbulary.
  ///
  /// In en, this message translates to:
  /// **'Vocabulary list'**
  String get list_vocbulary;

  /// No description provided for @text_color.
  ///
  /// In en, this message translates to:
  /// **'Text color'**
  String get text_color;

  /// No description provided for @background_color.
  ///
  /// In en, this message translates to:
  /// **'Background color'**
  String get background_color;

  /// No description provided for @new_vocabulary.
  ///
  /// In en, this message translates to:
  /// **'New vocabulary'**
  String get new_vocabulary;

  /// No description provided for @switch_language.
  ///
  /// In en, this message translates to:
  /// **'Switch language'**
  String get switch_language;

  /// No description provided for @offline_data.
  ///
  /// In en, this message translates to:
  /// **'Offline data'**
  String get offline_data;

  /// No description provided for @share_app.
  ///
  /// In en, this message translates to:
  /// **'Share app'**
  String get share_app;

  /// No description provided for @open_in_computer.
  ///
  /// In en, this message translates to:
  /// **'Open in computer'**
  String get open_in_computer;

  /// No description provided for @no_topic.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any topics yet'**
  String get no_topic;

  /// No description provided for @let_new_vocabulary.
  ///
  /// In en, this message translates to:
  /// **'Let\'s add new vocabulary'**
  String get let_new_vocabulary;

  /// No description provided for @are_you_sure_you_want_to_download_the_vocabulary.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to download the vocabulary ?'**
  String get are_you_sure_you_want_to_download_the_vocabulary;

  /// No description provided for @are_you_sure_you_want_to_delete_the_topic.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the topic ?'**
  String get are_you_sure_you_want_to_delete_the_topic;

  /// No description provided for @show_all_vocabulary_infomation.
  ///
  /// In en, this message translates to:
  /// **'Show all vocabulary information'**
  String get show_all_vocabulary_infomation;

  /// No description provided for @show_only_the_term_and_definitions_of_vocabulary.
  ///
  /// In en, this message translates to:
  /// **'Show only the term and definitions of vocabulary'**
  String get show_only_the_term_and_definitions_of_vocabulary;

  /// No description provided for @add_information.
  ///
  /// In en, this message translates to:
  /// **'Add information'**
  String get add_information;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
