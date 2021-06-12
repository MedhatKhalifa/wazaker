import 'package:flutter/services.dart';
import 'package:wazaker/pages/home/home_page.dart';
import 'package:wazaker/pages/search/search.dart';

import 'package:wazaker/pages/sebha/sebha.dart';
import 'package:wazaker/pages/splash/splash_screen.dart';
import 'package:wazaker/pages/zekr/azkar_selection.dart';

import 'package:wazaker/pages/zekr/zekr2.dart';
import 'package:wazaker/theme.dart';
import 'package:flutter/material.dart';

import 'package:wazaker/redux/reducers/reducers.dart';
import 'package:wazaker/redux/state/app_state.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';

//import 'package:device_preview/device_preview.dart';

//import 'package:device_preview/device_preview.dart';

void main() async {
  final store = Store<AppState>(appReducer,
      initialState: AppState.initial(),
      middleware: [thunkMiddleware, LoggingMiddleware.printer()]);
  runApp(EasyDynamicThemeWidget(child: MyApp(store: store)));

  //  DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => MyApp(store: store), // Wrap your app
  // ),
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({this.store});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return StoreProvider(
        store: store,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // locale: DevicePreview.locale(context), // Add the locale here
          // builder: DevicePreview.appBuilder, // Add the builder her
          title: 'Wazaker',
          routes: {
            '/': (BuildContext context) => SplashScreen(onInit: () {
                  //StoreProvider.of<AppState>(context).dispatch(getUserAction);
                }),
            //ForgotPasswordScreen(), //CompleteProfileScreen(), //
            '/home': (BuildContext context) => HomePage(),
            '/azkarselection': (BuildContext context) => AzkarSelection(),
            '/search': (BuildContext context) => SearchPage(),
            '/sebha': (BuildContext context) => Sebha(),
            '/zekr': (BuildContext context) => Zekr2(),
          },
          theme: lightThemeData,
          darkTheme: darkThemeData,
          themeMode: EasyDynamicTheme.of(context).themeMode,
        ));
  }
}
