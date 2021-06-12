import 'package:wazaker/db/dbhelper.dart';
import 'package:wazaker/models/tables.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wazaker/pages/home/home_page.dart';

import 'package:wazaker/redux/state/app_state.dart';
import 'package:wazaker/size_config.dart';

class SplashScreen extends StatefulWidget {
  final void Function() onInit;
  SplashScreen({this.onInit});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  DbHelper helper;
  @override
  void initState() {
    super.initState();
    helper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return (StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        builder: (context, state) {
          return Scaffold(
            body: AnimatedSplashScreen.withScreenFunction(
              duration: 3000,
              splash: 'assets/images/logo.png',
              screenFunction: () async {
                // var zekr = Azkar({
                //   'category': "أذكاااااااار الصباح",
                //   'content': "لاتنسى ",
                //   'after': "غرست له نخله فى الجنه",
                //   // 'totalCount': 3,
                //   // 'hours': 0,
                //   // 'pre': '',
                //   // 'currentCount': 0,
                //   // 'startDate': '06/09/2019',
                //   // 'endDate': '06/09/2019'
                // });
                // int id = await helper.createCourse(zekr);
                // print(id);

                return HomePage();
              },
              splashTransition: SplashTransition.rotationTransition,
              pageTransitionType: PageTransitionType.scale,
              backgroundColor: Colors.white,
            ),
          );
        }));
  }
}
