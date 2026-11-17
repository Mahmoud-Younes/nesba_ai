import 'package:flutter/material.dart';
import 'package:nesba_ai/core/language/app_localizations.dart';
import 'package:nesba_ai/core/style/theme/color_extension.dart';

extension ContextExt on BuildContext {
  //color
  MyColors get color => Theme.of(this).extension<MyColors>()!;

  // style
  TextStyle get textStyle => Theme.of(this).textTheme.bodyMedium!;

//Language
  String translate(String langkey) {
    return AppLocalizations.of(this)!.translate(langkey).toString();
  }

//Navigation

  Future<dynamic> pushName(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  void pop() => Navigator.of(this).pop();
}
