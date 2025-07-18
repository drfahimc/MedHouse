import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'study_page_model.dart';
export 'study_page_model.dart';

/// page Goal: A Multiple Choice Question quiz page using FlutterFlow +
/// Firebase.Backend: Firebase FirestoreCollection Name: mcq_questionsEach
/// document contains:questionText (String)option1, option2, option3, option4
/// (String)correctAnswer (String)explanation (String)qsno(number)Page Name:
/// McqPagePurpose: Displays MCQs filtered by topicId, allows answering, gives
/// immediate feedback, and shows explanation.Page Parameters:selectedTopicId
/// (Type: String)Page State Variables:currentQuestionIndex (int, default
/// 0)isAnswerSubmitted (bool, default false)selectedOptionText
/// (String)userScore (int, default 0)Backend Query:Collection:
/// mcq_questionsFilter:where topicId == selectedTopicIdordered by slno
/// ASCStore as: mcqQuestionsListBindings on McqPage:Question Number (Text
/// Widget):Text: "Q.
///
/// ${currentQuestionIndex + 1} / ${mcqQuestionsList.length}"Question Text
/// (Text Widget):Bind:
/// mcqQuestionsList[currentQuestionIndex].questionTextOption Buttons (4
/// Buttons):Text:Button 1:
/// mcqQuestionsList[currentQuestionIndex].option1Button 2: option2Button 3:
/// option3Button 4: option4On Tap Action for Each Button:Wrap inside a
/// condition: isAnswerSubmitted == falseStep A: Update
/// selectedOptionTextAction Type: Update Page StateVariable:
/// selectedOptionTextValue: Button Text (this button’s text)Step B: Set
/// isAnswerSubmitted = trueUpdate Page State: isAnswerSubmitted → trueStep C:
/// If selectedOptionText == correctAnswerAction: Update userScore → Increment
/// by 1Copy this logic to all 4 buttons and ensure each one references its
/// own button text.Conditional Button Colors:Set Fill Color → Conditional
/// Value:Condition 1: isAnswerSubmitted == trueInner Condition A:If Button
/// Text == mcqQuestionsList[currentQuestionIndex].correctAnswer → GreenInner
/// Condition B:If Button Text == selectedOptionText (and not correct) →
/// RedElse → Default (gray or original)Explanation Widget (Text):Visibility
/// Condition: isAnswerSubmitted == trueBind Text:
/// mcqQuestionsList[currentQuestionIndex].explanation"Next Question"
/// Button:Visibility: isAnswerSubmitted == trueOn Tap:Check:
/// currentQuestionIndex + 1 == mcqQuestionsList.lengthIf true: Navigate to
/// ResultPage and pass userScoreIf false:Increment currentQuestionIndexReset
/// isAnswerSubmitted → falseReset selectedOptionText → """Previous Question"
/// Button (optional):Decrease currentQuestionIndex by 1 (with boundary
/// check) Page Name: ResultPagePage Parameter: finalScore (Type:
/// int)Widgets:Text: "Your Score: ${finalScore}"Button: "Restart Quiz"Action:
/// Navigate to HomePage or TopicSelectionPage Topic Selection Page (HomePage
/// or MainMenuPage)Buttons for each topic (e.g., "Cell Injury")On
/// Tap:Navigate to: McqPagePass Parameter: selectedTopicId =
/// "cell_injury"Firebase NotesFirebase integration already done.Firestore
/// collection mcq_questions with proper schema.Config files uploaded.Security
/// rules already deployed via FlutterFlow.upon clicking 'nextquestion'the
/// next question, its options need to be displayed.keep a submit button .upon
/// clicking submit button check if the answer is true or not if any option is
/// selecte   and display the explanation.
class StudyPageWidget extends StatefulWidget {
  const StudyPageWidget({super.key});

  static String routeName = 'StudyPage';
  static String routePath = '/studyPage';

  @override
  State<StudyPageWidget> createState() => _StudyPageWidgetState();
}

class _StudyPageWidgetState extends State<StudyPageWidget> {
  late StudyPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StudyPageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: FlutterFlowTheme.of(context).alternate,
            borderRadius: 20,
            borderWidth: 2,
            buttonSize: 40,
            icon: Icon(
              Icons.chevron_left,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          title: Text(
            'MCQ Quiz',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.figtree(
                    fontWeight: FontWeight.w600,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Color(0x1A000000),
                            offset: Offset(
                              0,
                              2,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: StreamBuilder<List<McqQuestionsRecord>>(
                                stream: queryMcqQuestionsRecord(
                                  singleRecord: true,
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  List<McqQuestionsRecord>
                                      textMcqQuestionsRecordList =
                                      snapshot.data!;
                                  final textMcqQuestionsRecord =
                                      textMcqQuestionsRecordList.isNotEmpty
                                          ? textMcqQuestionsRecordList.first
                                          : null;

                                  return AutoSizeText(
                                    valueOrDefault<String>(
                                      textMcqQuestionsRecord?.questionText,
                                      'null',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .override(
                                          font: GoogleFonts.figtree(
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .headlineSmall
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .headlineSmall
                                                  .fontStyle,
                                          lineHeight: 1.4,
                                        ),
                                  );
                                },
                              ),
                            ),
                          ].divide(SizedBox(height: 20)),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<McqQuestionsRecord>>(
                    stream: queryMcqQuestionsRecord(
                      singleRecord: true,
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                          ),
                        );
                      }
                      List<McqQuestionsRecord> columnMcqQuestionsRecordList =
                          snapshot.data!;
                      // Return an empty Container when the item does not exist.
                      if (snapshot.data!.isEmpty) {
                        return Container();
                      }
                      final columnMcqQuestionsRecord =
                          columnMcqQuestionsRecordList.isNotEmpty
                              ? columnMcqQuestionsRecordList.first
                              : null;

                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 2,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Theme(
                                        data: ThemeData(
                                          checkboxTheme: CheckboxThemeData(
                                            visualDensity:
                                                VisualDensity.compact,
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                          unselectedWidgetColor:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                        ),
                                        child: Checkbox(
                                          value: _model.checkboxValue1 ??=
                                              false,
                                          onChanged: (newValue) async {
                                            safeSetState(() => _model
                                                .checkboxValue1 = newValue!);
                                          },
                                          side: (FlutterFlowTheme.of(context)
                                                      .alternate !=
                                                  null)
                                              ? BorderSide(
                                                  width: 2,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate!,
                                                )
                                              : null,
                                          activeColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                          checkColor:
                                              FlutterFlowTheme.of(context).info,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          valueOrDefault<String>(
                                            columnMcqQuestionsRecord?.option1,
                                            '0',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.figtree(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: FlutterFlowTheme.of(context).primaryText,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 12)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 2,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Theme(
                                        data: ThemeData(
                                          checkboxTheme: CheckboxThemeData(
                                            visualDensity:
                                                VisualDensity.compact,
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                          unselectedWidgetColor:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                        ),
                                        child: Checkbox(
                                          value: _model.checkboxValue2 ??=
                                              false,
                                          onChanged: (newValue) async {
                                            safeSetState(() => _model
                                                .checkboxValue2 = newValue!);
                                          },
                                          side: (FlutterFlowTheme.of(context)
                                                      .alternate !=
                                                  null)
                                              ? BorderSide(
                                                  width: 2,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate!,
                                                )
                                              : null,
                                          activeColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                          checkColor:
                                              FlutterFlowTheme.of(context).info,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          valueOrDefault<String>(
                                            columnMcqQuestionsRecord?.option2,
                                            '0',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                font: GoogleFonts.figtree(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLarge
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 12)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context).alternate,
                                    width: 2,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Theme(
                                        data: ThemeData(
                                          checkboxTheme: CheckboxThemeData(
                                            visualDensity:
                                                VisualDensity.compact,
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                          unselectedWidgetColor:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                        ),
                                        child: Checkbox(
                                          value: _model.checkboxValue3 ??=
                                              false,
                                          onChanged: (newValue) async {
                                            safeSetState(() => _model
                                                .checkboxValue3 = newValue!);
                                          },
                                          side: (FlutterFlowTheme.of(context)
                                                      .alternate !=
                                                  null)
                                              ? BorderSide(
                                                  width: 2,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate!,
                                                )
                                              : null,
                                          activeColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                          checkColor:
                                              FlutterFlowTheme.of(context).info,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          valueOrDefault<String>(
                                            columnMcqQuestionsRecord?.option3,
                                            '0',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                font: GoogleFonts.figtree(
                                                  fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 12)),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 2,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Theme(
                                        data: ThemeData(
                                          checkboxTheme: CheckboxThemeData(
                                            visualDensity:
                                                VisualDensity.compact,
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                          ),
                                          unselectedWidgetColor:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                        ),
                                        child: Checkbox(
                                          value: _model.checkboxValue4 ??=
                                              false,
                                          onChanged: (newValue) async {
                                            safeSetState(() => _model
                                                .checkboxValue4 = newValue!);
                                          },
                                          side: (FlutterFlowTheme.of(context)
                                                      .alternate !=
                                                  null)
                                              ? BorderSide(
                                                  width: 2,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate!,
                                                )
                                              : null,
                                          activeColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                          checkColor:
                                              FlutterFlowTheme.of(context).info,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          valueOrDefault<String>(
                                            columnMcqQuestionsRecord?.option4,
                                            '0',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                font: GoogleFonts.figtree(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyLarge
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ].divide(SizedBox(width: 12)),
                                  ),
                                ),
                              ),
                            ),
                          ].divide(SizedBox(height: 5)),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          color: Color(0x1A000000),
                          offset: Offset(
                            0,
                            2,
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: 'Submit Answer',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 50,
                              padding: EdgeInsets.all(8),
                              iconPadding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.figtree(
                                      fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).info,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                              elevation: 0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: FFButtonWidget(
                                  onPressed: () {
                                    print('Button pressed ...');
                                  },
                                  text: 'Previous',
                                  icon: Icon(
                                    Icons.chevron_left,
                                    size: 20,
                                  ),
                                  options: FFButtonOptions(
                                    height: 50,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24, 0, 24, 0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
                                    iconColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          font: GoogleFonts.figtree(
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                        ),
                                    elevation: 0,
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  context.pushNamed(GamemodeWidget.routeName);
                                },
                                text: '  Game  ',
                                options: FFButtonOptions(
                                  height: 49,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  color: Color(0xFFA70C14),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        font: GoogleFonts.figtree(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                        color: Colors.white,
                                        fontSize: 18,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                  borderSide: BorderSide(
                                    color: Color(0xFF2F0101),
                                    width: 0.9,
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              Expanded(
                                child: FFButtonWidget(
                                  onPressed: () {
                                    print('Button pressed ...');
                                  },
                                  text: 'Next',
                                  icon: Icon(
                                    Icons.chevron_right,
                                    size: 20,
                                  ),
                                  options: FFButtonOptions(
                                    height: 50,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24, 0, 24, 0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
                                    iconColor:
                                        FlutterFlowTheme.of(context).info,
                                    color:
                                        FlutterFlowTheme.of(context).tertiary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          font: GoogleFonts.figtree(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                          ),
                                          color:
                                              FlutterFlowTheme.of(context).info,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                        ),
                                    elevation: 0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(width: 12)),
                          ),
                        ].divide(SizedBox(height: 16)),
                      ),
                    ),
                  ),
                ),
              ].divide(SizedBox(height: 5)),
            ),
          ),
        ),
      ),
    );
  }
}
