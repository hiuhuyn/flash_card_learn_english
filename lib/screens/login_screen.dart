import '../components/router/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              EdgeInsets.only(left: 20.w, right: 20.w, top: 40.h, bottom: 40.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Spacer(
                flex: 1,
              ),
              SizedBox(
                  height: 200.h,
                  width: 200.w,
                  child: Image.asset("assets/images/logo_flat_card.png")),
              SizedBox(
                height: 20.h,
              ),
              Text(
                AppLocalizations.of(context)!.welcome_app,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 30.h,
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
                height: 50.h,
                path: "assets/images/google_icon.png",
                title: AppLocalizations.of(context)!.login_google,
                backgroundColor: Colors.white,
                titleStyle: TextStyle(
                    fontSize: 18.sp,
                    color: const Color(0xff676767),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.h,
              ),
              ButtonImageCustomer(
                onTap: () {},
                height: 50.h,
                path: "assets/images/Facbook.png",
                title: AppLocalizations.of(context)!.login_facebook,
                backgroundColor: Colors.white,
                titleStyle: TextStyle(
                    fontSize: 18.sp,
                    color: const Color(0xff676767),
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
