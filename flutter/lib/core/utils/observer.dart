import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ObserverManager extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint("$change");
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    debugPrint("onCreate ${bloc.toString()}");
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    debugPrint("onClose ${bloc.toString()}");
  }
}
