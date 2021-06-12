import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazaker/redux/state/app_state.dart';

Widget theappBar(context) {
  return PreferredSize(
      // to increase appbar size
      preferredSize: Size.fromHeight(60.0),
      child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) {
            return AppBar(
              //leading: Icon(Icons.menu),
              centerTitle: true,
              // actions: [
              //   IconButton(
              //     icon: Icon(Icons.search),
              //     iconSize: 33,
              //     color: Colors.white,
              //     onPressed: () => Navigator.pushNamed(context, '/search',
              //         arguments: {'senttext': ''}),
              //   ),
              // ],

              leading: IconButton(
                icon: Theme.of(context).brightness == Brightness.dark
                    ? Icon(Icons.light_mode)
                    : Icon(Icons.dark_mode),
                tooltip: 'Show Snackbar',
                onPressed: () {
                  if (Theme.of(context).brightness == Brightness.dark) {
                    print(Theme.of(context).brightness);
                    EasyDynamicTheme.of(context).changeTheme();
                    print(Theme.of(context).brightness);
                    if (Theme.of(context).brightness == Brightness.dark) {
                      EasyDynamicTheme.of(context).changeTheme();
                    }
                  } else {
                    EasyDynamicTheme.of(context).changeTheme();
                  }
                },
              ),

              title: Column(
                children: [
                  GestureDetector(
                    onTap: () => {Navigator.pushNamed(context, '/home')},
                    child: SvgPicture.asset(
                      "assets/images/logosvg.svg",
                      width: 50,
                      height: 50,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              backgroundColor: Theme.of(context).primaryColor,
            );
          }));
}
