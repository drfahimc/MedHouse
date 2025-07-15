import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'mcq_page_model.dart';
export 'mcq_page_model.dart';

/// Generate a comprehensive Multiple Choice Question (MCQ) quiz page in
/// FlutterFlow, named 'McqPage', designed to dynamically load and present
/// questions from Firestore based on a passed topic ID.
///
/// **1. Page Parameters:**
///    - Define a Page Parameter named `selectedTopicId` (Type: String, Is
/// List: false, Required: true). This parameter will be used to filter
/// questions from Firestore.
///
/// **2. Page State Variables:**
///    - `currentQuestionIndex`: Integer, default value 0. Tracks the index of
/// the currently displayed question in the `questionsList`.
///    - `userScore`: Integer, default value 0. Accumulates the number of
/// correct answers.
///    - `selectedOptionText`: String, nullable. Stores the full text of the
/// option chosen by the user for the current question.
///    - `isAnswerSubmitted`: Boolean, default value `false`. Controls
/// visibility of feedback, explanation, and the 'Next' button.
///
/// **3. Backend Query (On Page Load):**
///    - On page load, execute a 'Collection Query' targeting the
/// `mcq_questions` Firestore collection.
///    - The 'Query Type' should be 'List of Documents'.
///    - **Add a Filter:** The filter should be `topicId` (Field) `Equal To
/// (==)` `selectedTopicId` (from Page Parameters).
///    - **Add an Order By:** Order the results by `slno` (Ascending) if
/// `slno` exists in your documents; otherwise, skip ordering or use a
/// timestamp if available.
///    - **Assign Query Result:** Store the documents returned by this query
/// into a new Page State variable named `questionsList` (Type: List of
/// Document Snapshots, Collection: `mcq_questions`).
///
/// **4. UI Layout & Elements (within a Column in the Scaffold Body):**
///    - **Scaffold AppBar:**
///      - Title Text: "Quiz" with the topic name. Dynamically set its text to
/// `Combine Text` -> "Quiz - " + `selectedTopicId` (from Page Parameters).
///      - Leading Icon: A back arrow (`Icons.arrow_back_rounded`). OnPressed:
/// Navigate back (Pop).
///    - **Page Body (main Column):**
///      - Add 24px vertical padding around the entire column.
///      - **Conditional Loading Indicator (Center Aligned):**
///        - Widget: `CircularProgressIndicator`.
///        - Visibility: Conditional. Show ONLY IF `questionsList` (Page
/// State) `Is Empty`.
///        - Wrap this in a `Center` widget.
///      - **Main Quiz Content (Conditional Visibility for all below
/// elements):**
///        - All elements below this point should be visible ONLY IF
/// `questionsList` (Page State) `Is Not Empty`.
///        - **Question Number:**
///          - Widget: `Text`.
///          - Text Source: `Combine Text` -> "Question " +
/// (`currentQuestionIndex` (Page State) `+ 1`) + " of " + (`questionsList`
/// (Page State) `Length`).
///          - Styling: Normal font size, light grey color. Add vertical
/// padding.
///        - **Question Text:**
///          - Widget: `Text`.
///          - Text Source: `questionsList` (Page State) -> `Item at Index`
/// (`currentQuestionIndex` (Page State)) -> `questionText` (from Document).
///          - Styling: Large font size (e.g., HeadlineMedium), bold. Add
/// vertical padding.
///        - **Options Section (within a separate Column or ListView for
/// options):**
///          - Add a `Column` for the option buttons, with 12px vertical
/// spacing between items.
///          - **Option 1 Button:**
///            - Widget: `FFButtonWidget` (or similar button style).
///            - Text Source: `questionsList` -> `Item at Index`
/// (`currentQuestionIndex`) -> `option1` (from Document).
///            - **Fill Color:** Conditional.
///              - Condition (outer): `isAnswerSubmitted` (Page State) `==
/// true`.
///                - If True (inner conditional):
///                  - Condition: `questionsList` -> `Item at Index`
/// (`currentQuestionIndex`) -> `correctAnswer` `==` `questionsList` -> `Item
/// at Index` (`currentQuestionIndex`) -> `option1` (i.e., this option IS the
/// correct answer)
///                  - True Color: Green (e.g., `Color(0xFF4CAF50)`)
///                  - False Color: If `selectedOptionText` (Page State) `==`
/// `questionsList` -> `Item at Index` (`currentQuestionIndex`) -> `option1`
/// (i.e., this option was selected but is wrong), then Red (e.g.,
/// `Color(0xFFF44336)`), Else: Default Button Color (e.g.,
/// `FlutterFlowTheme.of(context).primaryBackground`).
///                - If False (outer conditional): Default Button Color (e.g.,
/// `FlutterFlowTheme.of(context).primaryBackground`).
///            - **Clickable Property:** Conditional. Set to
/// `isAnswerSubmitted` (Page State) `== false`. (Button is only clickable if
/// answer hasn't been submitted).
///          - **Repeat this for Option 2, Option 3, and Option 4 buttons,**
/// changing the `Text Source` to `option2`, `option3`, `option4`
/// respectively, and updating the `correctAnswer` color logic conditions to
/// compare against their respective option texts.
///        - **Feedback Message:**
///          - Widget: `Text`.
///          - Text Source: Conditional Value.
///            - Condition: `selectedOptionText` (Page State) `==`
/// `questionsList` -> `Item at Index` (`currentQuestionIndex`) ->
/// `correctAnswer`.
///            - True Text: "Correct!"
///            - False Text: "Wrong!"
///          - Text Color: Conditional Value (Green for True, Red for False).
///          - Visibility: Conditional. Only visible if `isAnswerSubmitted`
/// (Page State) `== true`.
///          - Styling: Bold, slightly larger font.
///        - **Explanation Text:**
///          - Widget: `Text`.
///          - Text Source: `questionsList` -> `Item at Index`
/// (`currentQuestionIndex`) -> `explanation`.
///          - Visibility: Conditional. Only visible if `isAnswerSubmitted`
/// (Page State) `== true`.
///          - Styling: Normal font size, light grey, perhaps italic. Add
/// vertical padding.
///        - **Next Question Button:**
///          - Widget: `FFButtonWidget`.
///          - Text: "Next Question" (or "Finish Quiz" if at the last question
/// - this will be handled in actions).
///          - Visibility: Conditional. Only visible if `isAnswerSubmitted`
/// (Page State) `== true`.
///
/// **5. Logic (Actions):**
///    - **On Option Button Tap (for each of the 4 option buttons):**
///      1.  **Update Page State:**
///          - Target: `selectedOptionText`
///          - Value: Set to the text of the *current button's option* (e.g.,
/// for Option 1 button, set to `questionsList` -> `Item at Index`
/// (`currentQuestionIndex`) -> `option1`).
///      2.  **Conditional Action:**
///          - Condition: `selectedOptionText` (Page State) `==`
/// `questionsList` -> `Item at Index` (`currentQuestionIndex`) ->
/// `correctAnswer`.
///          - **If True (Correct Answer):**
///            - **Update Page State:** Increment `userScore` (Page State) by
/// 1.
///            - (Optional: Add a "Show SnackBar" action with a green message
/// "Correct!")
///          - **If False (Wrong Answer):**
///            - (Optional: Add a "Show SnackBar" action with a red message
/// "Wrong!")
///      3.  **Update Page State:**
///          - Target: `isAnswerSubmitted`
///          - Value: Set to `true`.
///
///    - **On "Next Question" Button Tap:**
///      1.  **Conditional Action (Check if it's the last question):**
///          - Condition: `currentQuestionIndex` (Page State) `+ 1` `==`
/// `questionsList` (Page State) `Length`.
///          - **If True (Last Question):**
///            - **Navigate To:** A new page named `ResultPage` (create a
/// blank one first if it doesn't exist).
///            - **Pass Parameter:** Add a parameter named `finalScore` (Type:
/// Integer) to `ResultPage` and pass the `userScore` (Page State) as its
/// value.
///          - **If False (More Questions):**
///            - **Update Page State:** Increment `currentQuestionIndex` (Page
/// State) by 1.
///            - **Update Page State:** Clear `selectedOptionText` (Page
/// State).
///            - **Update Page State:** Set `isAnswerSubmitted` (Page State)
/// to `false`.
///
/// **Important Considerations for the AI:**
/// - Ensure all necessary widget imports are included.
/// - Use responsive design principles (e.g., `Expanded` widgets within
/// Columns/Rows where appropriate, flexible sizing).
/// - Apply standard FlutterFlow styling for buttons and text unless specific
/// colors are mentioned.
class McqPageWidget extends StatefulWidget {
  const McqPageWidget({
    super.key,
    required this.selectedTopicId,
  });

  final String? selectedTopicId;

  static String routeName = 'McqPage';
  static String routePath = '/mcqPage';

  @override
  State<McqPageWidget> createState() => _McqPageWidgetState();
}

class _McqPageWidgetState extends State<McqPageWidget>
    with TickerProviderStateMixin {
  late McqPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => McqPageModel());

    animationsMap.addAll({
      'buttonOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.easeOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(1.0, 1.0),
            end: Offset(1.05, 1.05),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<McqQuestionsRecord>>(
      stream: queryMcqQuestionsRecord(
        queryBuilder: (mcqQuestionsRecord) => mcqQuestionsRecord
            .where(
              'topicId',
              isEqualTo: widget!.selectedTopicId,
            )
            .orderBy('slno'),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<McqQuestionsRecord> mcqPageMcqQuestionsRecordList = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(30),
              child: AppBar(
                backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                automaticallyImplyLeading: false,
                leading: Align(
                  alignment: AlignmentDirectional(-1, -1),
                  child: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30,
                    borderWidth: 1,
                    buttonSize: 60,
                    hoverColor: Color(0xFF141212),
                    hoverIconColor: Colors.white,
                    hoverBorderColor: Color(0xFFD9D6D6),
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 30,
                    ),
                    onPressed: () async {
                      context.safePop();
                    },
                  ),
                ),
                title: Text(
                  'Question ${(_model.currentQuestionIndex + 1).toString()} of ${mcqPageMcqQuestionsRecordList.length.toString()}',
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        font: GoogleFonts.figtree(
                          fontWeight: FontWeight.w600,
                          fontStyle: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 20,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .fontStyle,
                      ),
                ),
                actions: [],
                centerTitle: false,
                elevation: 0,
              ),
            ),
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                            child: PageView(
                              controller: _model.pageViewController ??=
                                  PageController(initialPage: 0),
                              scrollDirection: Axis.horizontal,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Stack(
                                      children: [
                                        Align(
                                          alignment: AlignmentDirectional(
                                              -0.79, -0.89),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5, 0, 5, 20),
                                            child: Container(
                                              width: 385.1,
                                              height: 321.1,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                              child: Align(
                                                alignment:
                                                    AlignmentDirectional(0, 0),
                                                child: StreamBuilder<
                                                    List<McqQuestionsRecord>>(
                                                  stream:
                                                      queryMcqQuestionsRecord(
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 50,
                                                          height: 50,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<McqQuestionsRecord>
                                                        textMcqQuestionsRecordList =
                                                        snapshot.data!;
                                                    // Return an empty Container when the item does not exist.
                                                    if (snapshot
                                                        .data!.isEmpty) {
                                                      return Container();
                                                    }
                                                    final textMcqQuestionsRecord =
                                                        textMcqQuestionsRecordList
                                                                .isNotEmpty
                                                            ? textMcqQuestionsRecordList
                                                                .first
                                                            : null;

                                                    return Text(
                                                      valueOrDefault<String>(
                                                        textMcqQuestionsRecord
                                                            ?.questionText,
                                                        '1',
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .figtree(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: Color(
                                                                    0xCC000000),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(),
                                        child: Stack(
                                          alignment: AlignmentDirectional(0, 0),
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -0.12, -0.26),
                                              child: Padding(
                                                padding: EdgeInsets.all(2),
                                                child: StreamBuilder<
                                                    List<McqQuestionsRecord>>(
                                                  stream:
                                                      queryMcqQuestionsRecord(
                                                    queryBuilder:
                                                        (mcqQuestionsRecord) =>
                                                            mcqQuestionsRecord
                                                                .orderBy(
                                                                    'option2',
                                                                    descending:
                                                                        true),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 50,
                                                          height: 50,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<McqQuestionsRecord>
                                                        buttonMcqQuestionsRecordList =
                                                        snapshot.data!;
                                                    // Return an empty Container when the item does not exist.
                                                    if (snapshot
                                                        .data!.isEmpty) {
                                                      return Container();
                                                    }
                                                    final buttonMcqQuestionsRecord =
                                                        buttonMcqQuestionsRecordList
                                                                .isNotEmpty
                                                            ? buttonMcqQuestionsRecordList
                                                                .first
                                                            : null;

                                                    return FFButtonWidget(
                                                      onPressed: () {
                                                        print(
                                                            'Button pressed ...');
                                                      },
                                                      text:
                                                          buttonMcqQuestionsRecord!
                                                              .option2,
                                                      options: FFButtonOptions(
                                                        width: 350,
                                                        height: 40,
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(16, 0,
                                                                    16, 0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 0, 0),
                                                        color:
                                                            Color(0xFF353438),
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .figtree(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Colors
                                                                      .white,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                        elevation: 0,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -0.26, -0.78),
                                              child: Padding(
                                                padding: EdgeInsets.all(2),
                                                child: StreamBuilder<
                                                    List<McqQuestionsRecord>>(
                                                  stream:
                                                      queryMcqQuestionsRecord(
                                                    queryBuilder:
                                                        (mcqQuestionsRecord) =>
                                                            mcqQuestionsRecord
                                                                .orderBy(
                                                                    'option1',
                                                                    descending:
                                                                        true),
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 50,
                                                          height: 50,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<McqQuestionsRecord>
                                                        buttonMcqQuestionsRecordList =
                                                        snapshot.data!;
                                                    // Return an empty Container when the item does not exist.
                                                    if (snapshot
                                                        .data!.isEmpty) {
                                                      return Container();
                                                    }
                                                    final buttonMcqQuestionsRecord =
                                                        buttonMcqQuestionsRecordList
                                                                .isNotEmpty
                                                            ? buttonMcqQuestionsRecordList
                                                                .first
                                                            : null;

                                                    return FFButtonWidget(
                                                      onPressed: () {
                                                        print(
                                                            'Button pressed ...');
                                                      },
                                                      text:
                                                          buttonMcqQuestionsRecord!
                                                              .option1,
                                                      options: FFButtonOptions(
                                                        width: 350,
                                                        height: 40,
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(16, 0,
                                                                    16, 0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 0, 0),
                                                        color:
                                                            Color(0xFF353438),
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .figtree(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Colors
                                                                      .white,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                        elevation: 0,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -0.11, 0.84),
                                              child: Padding(
                                                padding: EdgeInsets.all(2),
                                                child: StreamBuilder<
                                                    List<McqQuestionsRecord>>(
                                                  stream:
                                                      queryMcqQuestionsRecord(
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 50,
                                                          height: 50,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<McqQuestionsRecord>
                                                        buttonMcqQuestionsRecordList =
                                                        snapshot.data!;
                                                    // Return an empty Container when the item does not exist.
                                                    if (snapshot
                                                        .data!.isEmpty) {
                                                      return Container();
                                                    }
                                                    final buttonMcqQuestionsRecord =
                                                        buttonMcqQuestionsRecordList
                                                                .isNotEmpty
                                                            ? buttonMcqQuestionsRecordList
                                                                .first
                                                            : null;

                                                    return FFButtonWidget(
                                                      onPressed: () {
                                                        print(
                                                            'Button pressed ...');
                                                      },
                                                      text:
                                                          buttonMcqQuestionsRecord!
                                                              .option4,
                                                      options: FFButtonOptions(
                                                        width: 350,
                                                        height: 40,
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(16, 0,
                                                                    16, 0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 0, 0),
                                                        color:
                                                            Color(0xFF353438),
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .figtree(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Colors
                                                                      .white,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                        elevation: 0,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -0.15, 0.27),
                                              child: Padding(
                                                padding: EdgeInsets.all(2),
                                                child: StreamBuilder<
                                                    List<McqQuestionsRecord>>(
                                                  stream:
                                                      queryMcqQuestionsRecord(
                                                    singleRecord: true,
                                                  ),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 50,
                                                          height: 50,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    List<McqQuestionsRecord>
                                                        buttonMcqQuestionsRecordList =
                                                        snapshot.data!;
                                                    // Return an empty Container when the item does not exist.
                                                    if (snapshot
                                                        .data!.isEmpty) {
                                                      return Container();
                                                    }
                                                    final buttonMcqQuestionsRecord =
                                                        buttonMcqQuestionsRecordList
                                                                .isNotEmpty
                                                            ? buttonMcqQuestionsRecordList
                                                                .first
                                                            : null;

                                                    return FFButtonWidget(
                                                      onPressed: () {
                                                        print(
                                                            'Button pressed ...');
                                                      },
                                                      text:
                                                          buttonMcqQuestionsRecord!
                                                              .option3,
                                                      options: FFButtonOptions(
                                                        width: 350,
                                                        height: 40,
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(16, 0,
                                                                    16, 0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 0, 0),
                                                        color:
                                                            Color(0xFF353438),
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .figtree(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Colors
                                                                      .white,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                        elevation: 0,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -0.89, 0.8),
                                              child: Padding(
                                                padding: EdgeInsets.all(2),
                                                child: Theme(
                                                  data: ThemeData(
                                                    checkboxTheme:
                                                        CheckboxThemeData(
                                                      visualDensity:
                                                          VisualDensity.compact,
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                      ),
                                                    ),
                                                    unselectedWidgetColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .alternate,
                                                  ),
                                                  child: Checkbox(
                                                    value: _model
                                                            .checkboxValue1 ??=
                                                        false,
                                                    onChanged:
                                                        (newValue) async {
                                                      safeSetState(() => _model
                                                              .checkboxValue1 =
                                                          newValue!);
                                                      if (newValue!) {
                                                        safeSetState(() {
                                                          _model.checkboxValue4 =
                                                              true;
                                                        });
                                                      }
                                                    },
                                                    side: (FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate !=
                                                            null)
                                                        ? BorderSide(
                                                            width: 2,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .alternate!,
                                                          )
                                                        : null,
                                                    activeColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                    checkColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .info,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -0.89, -0.75),
                                              child: Padding(
                                                padding: EdgeInsets.all(2),
                                                child: Theme(
                                                  data: ThemeData(
                                                    checkboxTheme:
                                                        CheckboxThemeData(
                                                      visualDensity:
                                                          VisualDensity.compact,
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                      ),
                                                    ),
                                                    unselectedWidgetColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .alternate,
                                                  ),
                                                  child: Checkbox(
                                                    value: _model
                                                            .checkboxValue2 ??=
                                                        false,
                                                    onChanged:
                                                        (newValue) async {
                                                      safeSetState(() => _model
                                                              .checkboxValue2 =
                                                          newValue!);
                                                      if (newValue!) {
                                                        safeSetState(() {
                                                          _model.checkboxValue1 =
                                                              true;
                                                        });
                                                      }
                                                    },
                                                    side: (FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate !=
                                                            null)
                                                        ? BorderSide(
                                                            width: 2,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .alternate!,
                                                          )
                                                        : null,
                                                    activeColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                    checkColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .info,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -0.89, -0.24),
                                              child: Padding(
                                                padding: EdgeInsets.all(2),
                                                child: Theme(
                                                  data: ThemeData(
                                                    checkboxTheme:
                                                        CheckboxThemeData(
                                                      visualDensity:
                                                          VisualDensity.compact,
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                      ),
                                                    ),
                                                    unselectedWidgetColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .alternate,
                                                  ),
                                                  child: Checkbox(
                                                    value: _model
                                                            .checkboxValue3 ??=
                                                        false,
                                                    onChanged:
                                                        (newValue) async {
                                                      safeSetState(() => _model
                                                              .checkboxValue3 =
                                                          newValue!);
                                                      if (newValue!) {
                                                        safeSetState(() {
                                                          _model.checkboxValue1 =
                                                              true;
                                                        });
                                                      }
                                                    },
                                                    side: (FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate !=
                                                            null)
                                                        ? BorderSide(
                                                            width: 2,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .alternate!,
                                                          )
                                                        : null,
                                                    activeColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                    checkColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .info,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -0.89, 0.27),
                                              child: Padding(
                                                padding: EdgeInsets.all(2),
                                                child: Theme(
                                                  data: ThemeData(
                                                    checkboxTheme:
                                                        CheckboxThemeData(
                                                      visualDensity:
                                                          VisualDensity.compact,
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                      ),
                                                    ),
                                                    unselectedWidgetColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .alternate,
                                                  ),
                                                  child: Checkbox(
                                                    value: _model
                                                            .checkboxValue4 ??=
                                                        false,
                                                    onChanged:
                                                        (newValue) async {
                                                      safeSetState(() => _model
                                                              .checkboxValue4 =
                                                          newValue!);
                                                      if (newValue!) {
                                                        safeSetState(() {
                                                          _model.checkboxValue3 =
                                                              true;
                                                        });
                                                      }
                                                    },
                                                    side: (FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate !=
                                                            null)
                                                        ? BorderSide(
                                                            width: 2,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .alternate!,
                                                          )
                                                        : null,
                                                    activeColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                    checkColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .info,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: AlignmentDirectional(0, 1),
                                          child: Container(
                                            height: 65.71,
                                            child: Stack(
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.86, -0.3),
                                                  child: StreamBuilder<
                                                      List<McqQuestionsRecord>>(
                                                    stream:
                                                        queryMcqQuestionsRecord(
                                                      singleRecord: true,
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Center(
                                                          child: SizedBox(
                                                            width: 50,
                                                            height: 50,
                                                            child:
                                                                CircularProgressIndicator(
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                      Color>(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      List<McqQuestionsRecord>
                                                          buttonMcqQuestionsRecordList =
                                                          snapshot.data!;
                                                      // Return an empty Container when the item does not exist.
                                                      if (snapshot
                                                          .data!.isEmpty) {
                                                        return Container();
                                                      }
                                                      final buttonMcqQuestionsRecord =
                                                          buttonMcqQuestionsRecordList
                                                                  .isNotEmpty
                                                              ? buttonMcqQuestionsRecordList
                                                                  .first
                                                              : null;

                                                      return FFButtonWidget(
                                                        onPressed: () async {
                                                          safeSetState(() {});
                                                        },
                                                        text: 'Next',
                                                        options:
                                                            FFButtonOptions(
                                                          width: 58.7,
                                                          height: 55.5,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(16,
                                                                      0, 16, 0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 0, 0),
                                                          color:
                                                              Color(0xFF353438),
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .figtree(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        25,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                          elevation: 10,
                                                          borderSide:
                                                              BorderSide(
                                                            width: 0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(24),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.03, -0.64),
                                                  child: StreamBuilder<
                                                      List<McqQuestionsRecord>>(
                                                    stream:
                                                        queryMcqQuestionsRecord(
                                                      singleRecord: true,
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Center(
                                                          child: SizedBox(
                                                            width: 50,
                                                            height: 50,
                                                            child:
                                                                CircularProgressIndicator(
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                      Color>(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      List<McqQuestionsRecord>
                                                          buttonMcqQuestionsRecordList =
                                                          snapshot.data!;
                                                      // Return an empty Container when the item does not exist.
                                                      if (snapshot
                                                          .data!.isEmpty) {
                                                        return Container();
                                                      }
                                                      final buttonMcqQuestionsRecord =
                                                          buttonMcqQuestionsRecordList
                                                                  .isNotEmpty
                                                              ? buttonMcqQuestionsRecordList
                                                                  .first
                                                              : null;

                                                      return FFButtonWidget(
                                                        onPressed: () {
                                                          print(
                                                              'Button pressed ...');
                                                        },
                                                        text:
                                                            buttonMcqQuestionsRecord!
                                                                .correctAnswer,
                                                        options:
                                                            FFButtonOptions(
                                                          width: 150,
                                                          height: 40,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(16,
                                                                      0, 16, 0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 0, 0),
                                                          color:
                                                              Color(0xFF353438),
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .figtree(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    fontSize:
                                                                        80,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleMedium
                                                                        .fontStyle,
                                                                  ),
                                                          elevation: 0,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ).animateOnActionTrigger(
                                                        animationsMap[
                                                            'buttonOnActionTriggerAnimation']!,
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -0.94, -0.2),
                                                  child: FFButtonWidget(
                                                    onPressed: () {
                                                      print(
                                                          'Button pressed ...');
                                                    },
                                                    text: 'Game Mode\n',
                                                    options: FFButtonOptions(
                                                      width: 99,
                                                      height: 101.8,
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16, 0, 16, 0),
                                                      iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 0, 0),
                                                      color: Color(0xFF961511),
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .figtree(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleMedium
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleMedium
                                                                    .fontStyle,
                                                              ),
                                                      elevation: 40,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ].divide(SizedBox(height: 0)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 1),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                              child: smooth_page_indicator.SmoothPageIndicator(
                                controller: _model.pageViewController ??=
                                    PageController(initialPage: 0),
                                count: 1,
                                axisDirection: Axis.horizontal,
                                onDotClicked: (i) async {
                                  await _model.pageViewController!
                                      .animateToPage(
                                    i,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );
                                  safeSetState(() {});
                                },
                                effect: smooth_page_indicator.SlideEffect(
                                  spacing: 8,
                                  radius: 8,
                                  dotWidth: 8,
                                  dotHeight: 8,
                                  dotColor:
                                      FlutterFlowTheme.of(context).accent1,
                                  activeDotColor:
                                      FlutterFlowTheme.of(context).primary,
                                  paintStyle: PaintingStyle.fill,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
