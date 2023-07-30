import '../../screens/switch_language_screen.dart';
import '../../screens/topic_offline_screen.dart';
import '../../screens/vocabularys_screen.dart';
import 'page_entry.dart';
import 'route_name.dart';

import 'package:flutter/material.dart';

import '../../screens/add_vocabulary_screen.dart';
import '../../screens/home_screen.dart';
import '../../screens/login_screen.dart';
import '../../screens/widget_tree.dart';

class CustomeRoute {
  static PageRoute generate(RouteSettings settings) {
    int index =
        _listPage.indexWhere((element) => element.route == settings.name);
    if (index != -1) {
      return MaterialPageRoute(
          builder: (context) => _listPage[index].page, settings: settings);
    }
    return MaterialPageRoute(
        builder: (context) => Container(), settings: settings);
  }

  static final List<PageEntry> _listPage = [
    PageEntry(route: RouteName.defaultRouter, page: const WidgetTree()),
    PageEntry(route: RouteName.login, page: const LoginScreen()),
    PageEntry(route: RouteName.homePage, page: const HomeScreen()),
    PageEntry(
        route: RouteName.vocabularysScreen, page: const VocabularysScreen()),
    PageEntry(
        route: RouteName.addVocabularys, page: const AddVocabularyScreen()),
    PageEntry(route: RouteName.topicOffline, page: const TopicOfflineScreen()),
    PageEntry(
        route: RouteName.switchLanguage, page: const SwitchLanguageScreen()),
  ];
}
