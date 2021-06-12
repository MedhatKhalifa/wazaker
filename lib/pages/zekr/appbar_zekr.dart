import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wazaker/redux/state/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

_incrementCounter() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var x = prefs.getDouble('counter');

  if (x != null) {
    int counter = (prefs.getInt('counter')) + 1;
    print('Pressed $counter times.');
    await prefs.setInt('counter', counter);
  } else {
    int counter = 26;
    await prefs.setInt('counter', counter);
  }
}

_decrementCounter() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print('prefffffffffffffffffffff');
  var x = prefs.getInt('counter');
  print(x);
  if (x != null) {
    int counter = (prefs.getInt('counter') ?? 0) - 1;
    print('Pressed $counter times.');
    await prefs.setInt('counter', counter);
  } else {
    int counter = 24;
    await prefs.setInt('counter', counter);
  }
}

Widget theappBarZekr(context) {
  return PreferredSize(
      // to increase appbar size
      preferredSize: Size.fromHeight(60.0),
      child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) {
            return AppBar(
              //leading: Icon(Icons.menu),
              centerTitle: true,
              actions: [
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      _incrementCounter();
                    }),
                IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      _decrementCounter();
                    })
              ],

              title: Column(
                children: [
                  SvgPicture.asset(
                    "assets/images/logosvg.svg",
                    width: 50,
                    height: 50,
                    color: Colors.white,
                  ),
                ],
              ),

              backgroundColor: Theme.of(context).primaryColor,
            );
          }));
}

class ZekrAppbarc extends StatefulWidget {
  @override
  _ZekrAppbarcState createState() => _ZekrAppbarcState();
}

class _ZekrAppbarcState extends State<ZekrAppbarc> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        // to increase appbar size
        preferredSize: Size.fromHeight(60.0),
        child: StoreConnector<AppState, AppState>(
            converter: (store) => store.state,
            builder: (context, state) {
              return AppBar(
                //leading: Icon(Icons.menu),
                centerTitle: true,
                actions: [
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        _incrementCounter();
                      }),
                  IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        _decrementCounter();
                      })
                ],

                title: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/images/logosvg.svg",
                      width: 50,
                      height: 50,
                      color: Colors.white,
                    ),
                  ],
                ),

                backgroundColor: Theme.of(context).primaryColor,
              );
            }));
  }
}
