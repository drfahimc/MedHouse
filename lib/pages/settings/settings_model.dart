import '/components/profile_circle_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'settings_widget.dart' show SettingsWidget;
import 'package:flutter/material.dart';

class SettingsModel extends FlutterFlowModel<SettingsWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for DarkModeSwitch widget.
  bool? darkModeSwitchValue;
  // Model for ProfileCircle component.
  late ProfileCircleModel profileCircleModel;

  @override
  void initState(BuildContext context) {
    profileCircleModel = createModel(context, () => ProfileCircleModel());
  }

  @override
  void dispose() {
    profileCircleModel.dispose();
  }
}
