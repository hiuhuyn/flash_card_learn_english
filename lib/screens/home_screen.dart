import 'package:flash_card_learn_english/components/router/route_name.dart';
import '../flutter_gen/gen_l10n/app_localizations.dart';
import '../components/utils/utils.dart';
import '../controllers/topic_controller.dart';
import '../data/firebase/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/topic.dart';
import 'topics_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          leading: Builder(builder: (context) {
            return IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.menu));
          }),
          title: Text(AppLocalizations.of(context)!
              .lets_learn_a_lot_of_new_words_together),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<TopicController>().getData();
                },
                icon: const Icon(Icons.restart_alt_rounded)),
          ],
        ),
        body: const TopicsScreen(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber,
          onPressed: () {
            showDialogEditTopic(
              context,
              title: AppLocalizations.of(context)!.new_topic,
              onTapSave: (value) async {
                Topic topic = Topic(title: value);
                await context
                    .read<TopicController>()
                    .createData(topic)
                    .then((value) {});
              },
            );
          },
          child: const Icon(
            Icons.add,
          ),
        ),
        drawer: _drawer(),
      ),
    );
  }

  Widget _drawerHeader() {
    var user = Auth.currentUser;
    String name = user?.displayName ?? "DisplayName...";
    String email = user?.email ?? "Email...";
    Widget avt = const CircleAvatar(child: FlutterLogo());
    String? photoURL = user?.photoURL;
    if (photoURL != null) {
      avt = CircleAvatar(backgroundImage: NetworkImage(photoURL));
    }
    return UserAccountsDrawerHeader(
        accountName: Text(
          name,
          style: const TextStyle(fontSize: 20),
        ),
        accountEmail: Text(
          email,
          style: const TextStyle(fontSize: 16),
        ),
        currentAccountPicture: avt,
        decoration: const BoxDecoration(color: Colors.amber));
  }

  Drawer _drawer() {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          _drawerHeader(),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.switch_language,
              style: const TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.pushNamed(context, RouteName.switchLanguage);
            },
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.offline_data,
              style: const TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.pushNamed(context, RouteName.topicOffline);
            },
          ),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.sign_out,
              style: const TextStyle(color: Colors.black),
            ),
            onTap: () async {
              await Auth.signOut().then((value) {
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteName.defaultRouter, (route) => false);
              });
            },
          ),
        ],
      ),
    );
  }
}
