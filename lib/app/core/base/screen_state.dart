import 'package:photos/app/core/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:photos/app/core/base/base_state.dart';

abstract class ScreenState<T extends StatefulWidget, C extends BaseController>
    extends BaseState<T, C> {
  Widget buildScreen(BuildContext context);

  Color? get backgroundColor => null;

  Widget? bottomNavigationBar;

  PreferredSizeWidget? appbar(BuildContext context) => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        child: buildScreen(context),
      ),
    );
  }
}
