import 'package:wazaker/models/inloading.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final InLoading inloading;
  final double fontsize;

  AppState({
    @required this.inloading,
    @required this.fontsize,
  });

  factory AppState.initial() {
    return AppState(
      inloading: InLoading(),
      fontsize: 22,
    );
  }
}
