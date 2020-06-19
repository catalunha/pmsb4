import 'package:flutter/foundation.dart' show TargetPlatform;
import 'package:pmsb4/plataform/io.dart'
    if (dart.library.html) 'package:pmsb4/plataform/html.dart';

class Recursos {
  static Recursos instance;

  static void initialize(TargetPlatform plataforma) {
    switch (plataforma) {
      case TargetPlatform.android:
        Recursos.instance = Recursos._(PLATFORM == "io" ? "android" : "web");
        break;
      case TargetPlatform.fuchsia:
        Recursos.instance = Recursos._(PLATFORM == "io" ? "fuchsia" : "web");
        break;
      case TargetPlatform.iOS:
        Recursos.instance = Recursos._(PLATFORM == "io" ? "ios" : "web");
        break;
      default:
        Recursos.instance = Recursos._("fuchsia");
        break;
    }
  }

  final String plataforma;

  Recursos._(this.plataforma);
}
