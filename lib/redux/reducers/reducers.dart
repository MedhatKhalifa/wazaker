import 'package:wazaker/models/inloading.dart';

import 'package:wazaker/redux/actions/inloading_action.dart';

import 'package:wazaker/redux/state/app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
      inloading: inloadingReducer(state.inloading, action),
      fontsize: fontsizeReducer(state.fontsize, action));
}

InLoading inloadingReducer(InLoading inloading, dynamic action) {
  if (action is UpdateInloading) {
    return action.inloading;
  }
  return inloading;
}

double fontsizeReducer(double fontsize, dynamic action) {
  if (action is Fontsizeincresed) {
    return action.fontsize;
  } else if (action is Fontsizedecresed) {
    return action.fontsize;
  }
  return fontsize;
}
