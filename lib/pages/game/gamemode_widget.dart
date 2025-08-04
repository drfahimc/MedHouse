import 'dart:async';
import 'package:flame/game.dart';
import '../../backend/game/dino_run.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../mcq_page/mcq_questions.dart';
import 'gamemode_model.dart';
export 'gamemode_model.dart';

/// Create a page called gamemode which has a widget in top to run a game
/// inside it and below it displays question,its options submit answer button
/// to check answer .
///
/// each time submit answer button is pressed, the next set of question and
/// its options are displayed in the ui
class GamemodeWidget extends StatefulWidget {
  const GamemodeWidget({super.key});

  static String routeName = 'gamemode';
  static String routePath = '/gamemode';
  static var time = 0;

  @override
  State<GamemodeWidget> createState() => _GamemodeWidgetState();
}

class _GamemodeWidgetState extends State<GamemodeWidget> {
  late GamemodeModel _model;

  // Timer? _timer;
  // int _timeLeft = 20;
  int _displayTime = 20;
  bool _gameOver = false;
  late DinoGame _dinoGame;
  double _dinoSize = 50.0;
  int _score = 0;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<List<McqQuestion>> fetchMcqQuestions() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('mcq_questions')
        .orderBy('qsno') // Optional: sort by question number
        .get();

    return snapshot.docs
        .map((doc) => McqQuestion.fromJson(doc.data()))
        .toList();
  }

  List<McqQuestion> questions = [];
  int currentIndex = 0;

  Future<void> loadQuestions() async {
    final fetched = await fetchMcqQuestions();
    //print('Fetched questions: $fetched');
    //print('Fetched questions: ${fetched.map((q) => q.question).toList()}');
    setState(() => questions = fetched);
  }

  void submitAnswer() {
    if (_model.checkboxValue1 == true) {
      print('Option 1 selected');
    }
    if (_model.checkboxValue2 == true) {
      print('Option 2 selected');
    }
    if (_model.checkboxValue3 == true) {
      print('Option 3 selected');
    }
    if (_model.checkboxValue4 == true) {
      print('Option 4 selected');
    }
  }

  bool checkAnswer() {
    bool isCorrect = false;
    if (_model.checkboxValue1 == true) {
      if (questions[currentIndex].correctAnswer ==
          questions[currentIndex].options[0]) {
        isCorrect = true;
      }
    }
    if (_model.checkboxValue2 == true) {
      if (questions[currentIndex].correctAnswer ==
          questions[currentIndex].options[1]) {
        isCorrect = true;
      }
    }
    if (_model.checkboxValue3 == true) {
      if (questions[currentIndex].correctAnswer ==
          questions[currentIndex].options[2]) {
        isCorrect = true;
      }
    }
    if (_model.checkboxValue4 == true) {
      if (questions[currentIndex].correctAnswer ==
          questions[currentIndex].options[3]) {
        isCorrect = true;
      }
    }
    return isCorrect;
  }

  void increaseScore() {
    setState(() {
      _score++;
    });
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GamemodeModel());

    // -- CHANGED: Configure game callbacks here --
    _dinoGame = DinoGame(
      onGameOver: () {
        if (mounted) {
          setState(() => _gameOver = true);
        }
      },
      onSizeChange: (size) {
        if (mounted) {
          setState(() => _dinoSize = size);
        }
      },
      onTimerUpdate: (timeLeft) {
        // The game updates the widget's time display
        if (mounted) {
          setState(() => _displayTime = timeLeft);
        }
      },
    );
    loadQuestions();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _model = createModel(context, () => GamemodeModel());
  //   loadQuestions().then((_) {
  //     if (questions.isNotEmpty) {
  //       _startTimer();
  //     }
  //   });

  //   // Initialize the game instance
  //   _dinoGame = DinoGame(
  //     onGameOver: () {
  //       setState(() {
  //         _gameOver = true;
  //       });
  //     },
  //     onSizeChange: (size) {
  //       setState(() {
  //         _dinoSize = size;
  //       });
  //     },
  //     onTimerUpdate: (timeLeft) {
  //       // This callback is called by the game to update timer
  //       // We don't need to do anything here as the timer is managed in the widget
  //     },
  //   );

  //   WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  // }

  // @override
  // void dispose() {
  //   _timer?.cancel();
  //   _model.dispose();
  //   super.dispose();
  // }

  // void _startTimer() {
  //   _timer?.cancel();
  //   setState(() {
  //     _timeLeft = 15;
  //     _gameOver = false;
  //   });
  //   _timer = Timer.periodic(Duration(seconds: 1), (timer) {
  //     if (_timeLeft > 0) {
  //       setState(() {
  //         _timeLeft--;
  //       });
  //       // Update the game's timer so it knows when to spawn obstacles
  //       _dinoGame._onTick();
  //     } else {
  //       timer.cancel();
  //       setState(() {
  //         _gameOver = true;
  //       });
  //     }
  //   });
  // }

  void showNext() {
    if (currentIndex < questions.length - 1) {
      setState(() {
        _model.checkboxValue1 = false;
        _model.checkboxValue2 = false;
        _model.checkboxValue3 = false;
        _model.checkboxValue4 = false;
        currentIndex++;
        _gameOver = false;
        //_timeLeft = 20;
      });
      print('currentIndex: $currentIndex');
      _dinoGame.resetGameForNewQuestion();
      // Reset obstacle spawn flag for next question
      // _dinoGame.resetObstacleSpawn();
      // _startTimer();
    } else {
      // Handle quiz completion
      print("End of quiz!");
      // You might want to navigate away or show a final score screen here
      setState(() => _gameOver = true);
    }
  }

  bool Timeout() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (_gameOver) {
      return Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Game Over',
                style: TextStyle(fontSize: 32, color: Colors.red),
              ),
              SizedBox(height: 24),
              FFButtonWidget(
                onPressed: () async {
                  context.safePop();
                  print("Button pressed");
                },
                text: 'Back',
                options: FFButtonOptions(
                  width: 200,
                  height: 50,
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleMedium.override(
                        font: GoogleFonts.figtree(
                          fontWeight: FontWeight.w600,
                          fontStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).info,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleMedium.fontStyle,
                      ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
        ),
      );
    }
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
            borderRadius: 12,
            borderWidth: 1,
            buttonSize: 40,
            fillColor: FlutterFlowTheme.of(context).secondaryBackground,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24,
            ),
            onPressed: () async {
              context.safePop();
              print("Button pressed");
            },
          ),
          title: Text(
            'Game Mode',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.figtree(
                    fontWeight: FontWeight.bold,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.bold,
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        color: Color.fromARGB(255, 255, 255, 255),
                        offset: Offset(
                          0,
                          4,
                        ),
                      )
                    ],
                    gradient: LinearGradient(
                      colors: [
                        FlutterFlowTheme.of(context).primary,
                        FlutterFlowTheme.of(context).accent1
                      ],
                      stops: [0.1, 0.8],
                      begin: AlignmentDirectional(1, -1),
                      end: AlignmentDirectional(-1, 1),
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).accent4,
                      width: 2,
                    ),
                  ),
                  child: GameWidget(game: _dinoGame),
                  // child: Column(
                  //   mainAxisSize: MainAxisSize.max,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Row(
                  //       mainAxisSize: MainAxisSize.max,
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Icon(
                  //           Icons.games_rounded,
                  //           color: FlutterFlowTheme.of(context).primary,
                  //           size: 32,
                  //         ),
                  //       ].divide(SizedBox(width: 8)),
                  //     )
                  //   ].divide(SizedBox(height: 12)),
                  // ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: questions.isEmpty
                      ? Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                FlutterFlowTheme.of(context).primary,
                              ),
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            // Text('Time left: $_timeLeft seconds',
                            //     style: TextStyle(fontSize: 20)),
                            // SizedBox(height: 16),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 4,
                                      color: Color(0x1A000000),
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          questions[currentIndex].question ??
                                              '',
                                          style: FlutterFlowTheme.of(context)
                                              .titleLarge
                                              .override(
                                                font: GoogleFonts.figtree(
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleLarge
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .fontStyle,
                                                lineHeight: 1.3,
                                              ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            for (int i = 0; i < 4; i++)
                                              Container(
                                                width: double.infinity,
                                                height: 56,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                    width: 2,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(16),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Theme(
                                                        data: ThemeData(
                                                          checkboxTheme:
                                                              CheckboxThemeData(
                                                            visualDensity:
                                                                VisualDensity
                                                                    .compact,
                                                            materialTapTargetSize:
                                                                MaterialTapTargetSize
                                                                    .shrinkWrap,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                            ),
                                                          ),
                                                          unselectedWidgetColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .alternate,
                                                        ),
                                                        child: Checkbox(
                                                          value: i == 0
                                                              ? _model.checkboxValue1 ??=
                                                                  false
                                                              : i == 1
                                                                  ? _model.checkboxValue2 ??=
                                                                      false
                                                                  : i == 2
                                                                      ? _model.checkboxValue3 ??=
                                                                          false
                                                                      : _model.checkboxValue4 ??=
                                                                          false,
                                                          onChanged:
                                                              (newValue) async {
                                                            setState(() {
                                                              _model.checkboxValue1 =
                                                                  i == 0
                                                                      ? newValue!
                                                                      : false;
                                                              _model.checkboxValue2 =
                                                                  i == 1
                                                                      ? newValue!
                                                                      : false;
                                                              _model.checkboxValue3 =
                                                                  i == 2
                                                                      ? newValue!
                                                                      : false;
                                                              _model.checkboxValue4 =
                                                                  i == 3
                                                                      ? newValue!
                                                                      : false;
                                                            });
                                                          },
                                                          side: (FlutterFlowTheme.of(
                                                                          context)
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
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                          checkColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .info,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(12,
                                                                      0, 12, 0),
                                                          child: Text(
                                                            questions[currentIndex]
                                                                        .options[
                                                                    i] ??
                                                                '',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .figtree(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                          ].divide(SizedBox(height: 12)),
                                        ),
                                      ].divide(SizedBox(height: 20)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  child: FFButtonWidget(
                    onPressed: () {
                      //showNext();
                      if (checkAnswer()) {
                        increaseScore();
                        _dinoGame.increaseDinoSize();
                        showNext();
                      } else {
                        _dinoGame.reduceDinoSize();
                        showNext();
                      }
                      print('Button pressed ...');
                    },
                    text: 'Submit Answer',
                    icon: Icon(
                      Icons.check_circle_rounded,
                      size: 20,
                    ),
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 56,
                      padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      iconColor: FlutterFlowTheme.of(context).info,
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleMedium.override(
                                font: GoogleFonts.figtree(
                                  fontWeight: FontWeight.w600,
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
                      elevation: 2,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ]
                .divide(SizedBox(height: 16))
                .addToStart(SizedBox(height: 16))
                .addToEnd(SizedBox(height: 16)),
          ),
        ),
      ),
    );
  }
}
