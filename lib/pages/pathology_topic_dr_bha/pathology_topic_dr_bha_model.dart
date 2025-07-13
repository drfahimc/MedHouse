import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'pathology_topic_dr_bha_widget.dart' show PathologyTopicDrBhaWidget;
import 'package:flutter/material.dart';

class PathologyTopicDrBhaModel
    extends FlutterFlowModel<PathologyTopicDrBhaWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
