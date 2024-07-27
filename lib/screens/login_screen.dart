import '../components/router/route_name.dart';
import 'package:flutter/material.dart';
import '../flutter_gen/gen_l10n/app_localizations.dart';

import '../components/widgets/button_image_customer.dart';
import '../data/firebase/auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue[600],
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Spacer(
                flex: 1,
              ),
              SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset("assets/images/logo_flat_card.png")),
              const SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context)!.welcome_app,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ButtonImageCustomer(
                onTap: () async {
                  try {
                    await Auth.signInWithGoogle().then((value) {
                      if (value != null) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, RouteName.homePage, (route) => false);
                      }
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                height: 50,
                path: "assets/images/google_icon.png",
                title: AppLocalizations.of(context)!.login_google,
                backgroundColor: Colors.white,
                titleStyle: const TextStyle(
                    fontSize: 18,
                    color: Color(0xff676767),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              ButtonImageCustomer(
                onTap: () {},
                height: 50,
                path: "assets/images/Facbook.png",
                title: AppLocalizations.of(context)!.login_facebook,
                backgroundColor: Colors.white,
                titleStyle: const TextStyle(
                    fontSize: 18,
                    color: Color(0xff676767),
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(
                flex: 4,
              )
            ],
          ),
        ),
      ),
    );
  }
}
