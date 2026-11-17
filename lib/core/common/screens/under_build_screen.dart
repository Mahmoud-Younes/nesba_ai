import 'package:flutter/material.dart';
import 'package:nesba_ai/core/extensions/context_extension.dart';
import 'package:nesba_ai/core/language/lang_keys.dart';

class PageUnderBuildScreen extends StatelessWidget {
  const PageUnderBuildScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: context.color.mainColor,
      body: Center(
        child: Text(
          context.translate(LangKeys.cubitHint),
          style: context.textStyle,
        ),
      ),
    );
  }
}
