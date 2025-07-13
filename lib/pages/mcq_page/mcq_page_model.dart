import '/flutter_flow/flutter_flow_util.dart';
import 'mcq_page_widget.dart' show McqPageWidget;
import 'package:flutter/material.dart';

class McqPageModel extends FlutterFlowModel<McqPageWidget> {
  ///  Local state fields for this page.

  int currentQuestionIndex = 0;

  bool isAnswerSubmitted = false;

  List<String> selectedOptionText = [];
  void addToSelectedOptionText(String item) => selectedOptionText.add(item);
  void removeFromSelectedOptionText(String item) =>
      selectedOptionText.remove(item);
  void removeAtIndexFromSelectedOptionText(int index) =>
      selectedOptionText.removeAt(index);
  void insertAtIndexInSelectedOptionText(int index, String item) =>
      selectedOptionText.insert(index, item);
  void updateSelectedOptionTextAtIndex(int index, Function(String) updateFn) =>
      selectedOptionText[index] = updateFn(selectedOptionText[index]);

  int userScore = 0;

  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // State field(s) for Checkbox widget.
  bool? checkboxValue1;
  // State field(s) for Checkbox widget.
  bool? checkboxValue2;
  // State field(s) for Checkbox widget.
  bool? checkboxValue3;
  // State field(s) for Checkbox widget.
  bool? checkboxValue4;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
