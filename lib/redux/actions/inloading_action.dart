import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wazaker/models/inloading.dart';

import 'package:wazaker/redux/state/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateInloading {
  final InLoading _inLoading;

  InLoading get inloading => this._inLoading;

  UpdateInloading(this._inLoading);
}

ThunkAction<AppState> fontsizeincresed = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();

  double counter;
  var x = prefs.getDouble('counter');
  print(x);
  if (x != null) {
    counter = (prefs.getDouble('counter')) + 1;
    print('Pressed $counter times.');
    await prefs.setDouble('counter', counter);
  } else {
    counter = 26;
    await prefs.setDouble('counter', counter);
  }

  store.dispatch(Fontsizeincresed(counter));
};

class Fontsizeincresed {
  final double _fontsize;

  double get fontsize => this._fontsize;

  Fontsizeincresed(this._fontsize);
}

ThunkAction<AppState> fontsizedecresed = (Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance();

  double counter;
  var x = prefs.getDouble('counter');
  print(x);
  if (x != null) {
    counter = (prefs.getDouble('counter')) + 1;
    print('Pressed $counter times.');
    await prefs.setDouble('counter', counter);
  } else {
    counter = 26;
    await prefs.setDouble('counter', counter);
  }

  store.dispatch(Fontsizedecresed(counter));
};

class Fontsizedecresed {
  final double _fontsize;

  double get fontsize => this._fontsize;

  Fontsizedecresed(this._fontsize);
}
