import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _playerName = prefs.getString('ff_playerName') ?? _playerName;
    });
    _safeInit(() {
      _isDarkMode = prefs.getBool('ff_isDarkMode') ?? _isDarkMode;
    });
    _safeInit(() {
      _lastAchievedLevel =
          prefs.getInt('ff_lastAchievedLevel') ?? _lastAchievedLevel;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _playerName = 'player1';
  String get playerName => _playerName;
  set playerName(String value) {
    _playerName = value;
    prefs.setString('ff_playerName', value);
  }

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  set isDarkMode(bool value) {
    _isDarkMode = value;
    prefs.setBool('ff_isDarkMode', value);
  }

  int _levelsCount = 5;
  int get levelsCount => _levelsCount;
  set levelsCount(int value) {
    _levelsCount = value;
  }

  int _lastAchievedLevel = 0;
  int get lastAchievedLevel => _lastAchievedLevel;
  set lastAchievedLevel(int value) {
    _lastAchievedLevel = value;
    prefs.setInt('ff_lastAchievedLevel', value);
  }

  List<PlayerStruct> _currentPlayers = [];
  List<PlayerStruct> get currentPlayers => _currentPlayers;
  set currentPlayers(List<PlayerStruct> value) {
    _currentPlayers = value;
  }

  void addToCurrentPlayers(PlayerStruct value) {
    currentPlayers.add(value);
  }

  void removeFromCurrentPlayers(PlayerStruct value) {
    currentPlayers.remove(value);
  }

  void removeAtIndexFromCurrentPlayers(int index) {
    currentPlayers.removeAt(index);
  }

  void updateCurrentPlayersAtIndex(
    int index,
    PlayerStruct Function(PlayerStruct) updateFn,
  ) {
    currentPlayers[index] = updateFn(_currentPlayers[index]);
  }

  void insertAtIndexInCurrentPlayers(int index, PlayerStruct value) {
    currentPlayers.insert(index, value);
  }

  List<LevelStruct> _levelsList = [];
  List<LevelStruct> get levelsList => _levelsList;
  set levelsList(List<LevelStruct> value) {
    _levelsList = value;
  }

  void addToLevelsList(LevelStruct value) {
    levelsList.add(value);
  }

  void removeFromLevelsList(LevelStruct value) {
    levelsList.remove(value);
  }

  void removeAtIndexFromLevelsList(int index) {
    levelsList.removeAt(index);
  }

  void updateLevelsListAtIndex(
    int index,
    LevelStruct Function(LevelStruct) updateFn,
  ) {
    levelsList[index] = updateFn(_levelsList[index]);
  }

  void insertAtIndexInLevelsList(int index, LevelStruct value) {
    levelsList.insert(index, value);
  }

  bool _isHapticAllowed = true;
  bool get isHapticAllowed => _isHapticAllowed;
  set isHapticAllowed(bool value) {
    _isHapticAllowed = value;
  }

  bool _isSoundOn = true;
  bool get isSoundOn => _isSoundOn;
  set isSoundOn(bool value) {
    _isSoundOn = value;
  }

  // String _musicFile =
  //     'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3';
  // String get musicFile => _musicFile;
  // set musicFile(String value) {
  //   _musicFile = value;
  // }

  double _currentMusicVolume = 0.5;
  double get currentMusicVolume => _currentMusicVolume;
  set currentMusicVolume(double value) {
    _currentMusicVolume = value;
  }

  List<dynamic> _mcqtest = [
    jsonDecode(
        '[{\"slno\":1,\"question\":\"Which cellular process helps maintain a normal functional state in a cell?\",\"image\":null,\"option a\":\"Apoptosis\",\"option b\":\"Homeostasis\",\"option c\":\"Hypertrophy\",\"option d\":\"Necrosis\",\"answer\":\"B\",\"explanation\":\"Homeostasis refers to a balanced internal environment that allows cells to function normally. Disruption leads to cellular stress.\"},{\"slno\":2,\"question\":\"Which of the following is a feature of reversible cell injury under electron microscopy?\",\"image\":null,\"option a\":\"Loss of nuclear membrane\",\"option b\":\"Pyknosis\",\"option c\":\"Swelling of organelles\",\"option d\":\"Cytoplasmic fragmentation\",\"answer\":\"C\",\"explanation\":\"In reversible injury, mitochondria and other organelles swell due to ATP depletion and ionic imbalance.\"},{\"slno\":3,\"question\":\"“Mickey Mouse” appearance under EM indicates:\",\"image\":null,\"option a\":\"Apoptotic cell death\",\"option b\":\"Normal mitochondria\",\"option c\":\"Reversible injury with cell swelling\",\"option d\":\"Hydropic degeneration in necrosis\",\"answer\":\"C\",\"explanation\":\"The “Mickey Mouse” appearance describes swollen mitochondria with displaced cristae, typical of reversible injury.\"},{\"slno\":4,\"question\":\"Which adaptation occurs in response to cellular stress?\",\"image\":null,\"option a\":\"Karyolysis\",\"option b\":\"Atrophy\",\"option c\":\"Pyknosis\",\"option d\":\"Necrosis\",\"answer\":\"B\",\"explanation\":\"Atrophy is a reduction in cell size due to decreased workload or nutrient supply, allowing survival under stress.\"},{\"slno\":5,\"question\":\"Pyknosis refers to:\",\"image\":null,\"option a\":\"Fragmentation of the nucleus\",\"option b\":\"Condensation of chromatin\",\"option c\":\"Enlargement of cytoplasm\",\"option d\":\"Swelling of organelles\",\"answer\":\"B\",\"explanation\":\"Pyknosis is the condensation and darkening of nuclear chromatin, often an early sign of cell injury.\"},{\"slno\":6,\"question\":\"In reversible injury, which cellular ion increases first leading to swelling?\",\"image\":null,\"option a\":\"Calcium\",\"option b\":\"Potassium\",\"option c\":\"Magnesium\",\"option d\":\"Sodium\",\"answer\":\"D\",\"explanation\":\"Na⁺ accumulates inside the cell when ATP-dependent pumps fail, causing water influx and cell swelling.\"},{\"slno\":7,\"question\":\"Which of the following is not a cellular adaptation?\",\"image\":null,\"option a\":\"Hypertrophy\",\"option b\":\"Atrophy\",\"option c\":\"Apoptosis\",\"option d\":\"Metaplasia\",\"answer\":\"C\",\"explanation\":\"Apoptosis is a form of controlled cell death, while the others are adaptive responses to stress.\"},{\"slno\":8,\"question\":\"What leads to hydropic change in cell injury?\",\"image\":null,\"option a\":\"Pyruvate accumulation\",\"option b\":\"Mitochondrial DNA damage\",\"option c\":\"ATP depletion and Na⁺ retention\",\"option d\":\"Calcium efflux\",\"answer\":\"C\",\"explanation\":\"Hydropic change results from water accumulation in the cytoplasm due to failure of ion pumps from ATP depletion.\"},{\"slno\":9,\"question\":\"Which light microscopy finding suggests reversible injury?\",\"image\":null,\"option a\":\"Pyknotic nucleus with intensely pink cytoplasm\",\"option b\":\"Pale cytoplasm with pyknotic nucleus\",\"option c\":\"Fragmented chromatin\",\"option d\":\"Nuclear membrane rupture\",\"answer\":\"B\",\"explanation\":\"Pale cytoplasm and nuclear condensation are seen in reversible injuries due to fluid accumulation and mild nuclear damage.\"},{\"slno\":10,\"question\":\"Which type of necrosis maintains cell outline?\",\"image\":null,\"option a\":\"Coagulative necrosis\",\"option b\":\"Liquefactive necrosis\",\"option c\":\"Caseous necrosis\",\"option d\":\"Fibrinoid necrosis\",\"answer\":\"A\",\"explanation\":\"Coagulative necrosis shows preserved tissue architecture despite cell death, typical in infarcts of solid organs.\"},{\"slno\":11,\"question\":\"A hallmark of irreversible injury in electron microscopy is:\",\"image\":null,\"option a\":\"Mitochondrial shrinkage\",\"option b\":\"Cytoplasmic vacuoles\",\"option c\":\"Large flocculent densities due to calcium influx\",\"option d\":\"Increased ribosomal activity\",\"answer\":\"C\",\"explanation\":\"These dense calcium deposits in mitochondria signify membrane damage and irreversible cell injury.\"},{\"slno\":12,\"question\":\"Which pump failure contributes to irreversible cell injury?\",\"image\":null,\"option a\":\"Na⁺/H⁺ antiporter\",\"option b\":\"Na⁺/K⁺ ATPase and Ca²⁺ efflux pumps\",\"option c\":\"Cl⁻/HCO₃⁻ exchanger\",\"option d\":\"Na⁺/glucose symporter\",\"answer\":\"B\",\"explanation\":\"These pumps maintain ion gradients; their failure leads to cellular swelling and enzyme activation.\"},{\"slno\":13,\"question\":\"Which enzymes are activated by increased intracellular Ca²⁺ during severe injury?\",\"image\":null,\"option a\":\"Kinase, Lipase, Amylase\",\"option b\":\"ATPase, Protease, Phospholipase, Endonuclease\",\"option c\":\"Lactate dehydrogenase, Kinase, Caspase\",\"option d\":\"Tyrosinase, Elastase, Lipase\",\"answer\":\"B\",\"explanation\":\"These enzymes degrade cellular components, leading to membrane breakdown, DNA damage, and necrosis.\"},{\"slno\":14,\"question\":\"Which is the most efficient bactericidal compound in O₂-dependent killing?\",\"image\":null,\"option a\":\"O₂⁻\",\"option b\":\"H₂O₂\",\"option c\":\"OH⁻\",\"option d\":\"OCl⁻ (Hypochlorite)\",\"answer\":\"D\",\"explanation\":\"Hypochlorite (OCl⁻) produced by the MPO-H₂O₂-halide system is the most potent microbicidal substance.\"},{\"slno\":15,\"question\":\"What type of necrosis is classically associated with ischemia to solid organs?\",\"image\":null,\"option a\":\"Fibrinoid\",\"option b\":\"Liquefactive\",\"option c\":\"Coagulative\",\"option d\":\"Caseous\",\"answer\":\"C\",\"explanation\":\"Ischemia in heart, kidney, and liver typically leads to coagulative necrosis due to protein denaturation.\"},{\"slno\":16,\"question\":\"Which event occurs first during ATP depletion in cell injury?\",\"image\":null,\"option a\":\"Caspase activation\",\"option b\":\"Intracellular Na⁺ increase\",\"option c\":\"Mitochondrial fragmentation\",\"option d\":\"Chromatin breakdown\",\"answer\":\"B\",\"explanation\":\"ATP loss inhibits ion pumps, causing Na⁺ accumulation and water influx, initiating cell swelling.\"},{\"slno\":17,\"question\":\"Which type of necrosis typically occurs in the brain?\",\"image\":null,\"option a\":\"Coagulative\",\"option b\":\"Caseous\",\"option c\":\"Fibrinoid\",\"option d\":\"Liquefactive\",\"answer\":\"D\",\"explanation\":\"Liquefactive necrosis is common in the brain due to high lipid content and enzymatic digestion after ischemia.\"},{\"slno\":18,\"question\":\"Which of the following is a feature of caseous necrosis?\",\"image\":null,\"option a\":\"Maintained cell outline\",\"option b\":\"Cheese-like gross appearance\",\"option c\":\"Associated with trauma to fat\",\"option d\":\"Seen in infarction of kidney\",\"answer\":\"B\",\"explanation\":\"Caseous necrosis appears soft and white, resembling cheese, typically in TB and fungal infections.\"},{\"slno\":19,\"question\":\"Which necrosis type is associated with acute pancreatitis?\",\"image\":null,\"option a\":\"Caseous necrosis\",\"option b\":\"Fat necrosis\",\"option c\":\"Coagulative necrosis\",\"option d\":\"Fibrinoid necrosis\",\"answer\":\"B\",\"explanation\":\"In pancreatitis, lipase release leads to fat cell destruction and chalky calcium deposits in adipose tissue.\"},{\"slno\":20,\"question\":\"What is a histological feature of coagulative necrosis in the heart?\",\"image\":null,\"option a\":\"Clear outline with neutrophil infiltration\",\"option b\":\"Moth-eaten cytoplasm\",\"option c\":\"Fat vacuoles\",\"option d\":\"Glassy cytoplasm with loss of nuclei\",\"answer\":\"B\",\"explanation\":\"In myocardial infarction, dead cells retain their outlines initially, and neutrophils infiltrate the tissue.\"},{\"slno\":21,\"question\":\"Langhans giant cells are typically found in which necrosis type?\",\"image\":null,\"option a\":\"Fibrinoid\",\"option b\":\"Caseous\",\"option c\":\"Liquefactive\",\"option d\":\"Coagulative\",\"answer\":\"A\",\"explanation\":\"Caseous necrosis involves granulomatous inflammation with Langhans giant cells, seen in TB.\"},{\"slno\":22,\"question\":\"Which feature differentiates apoptosis from necrosis?\",\"image\":null,\"option a\":\"Nuclear fragmentation\",\"option b\":\"Inflammation\",\"option c\":\"Cell shrinkage\",\"option d\":\"ATP depletion\",\"answer\":\"B\",\"explanation\":\"Apoptosis is energy-dependent, involves cell shrinkage, and lacks inflammation—unlike necrosis.\"},{\"slno\":23,\"question\":\"Apoptosis results in DNA fragmentation patterns described as:\",\"image\":null,\"option a\":\"Random smearing\",\"option b\":\"Step ladder pattern\",\"option c\":\"Linear cleavage\",\"option d\":\"Continuous degradation\",\"answer\":\"C\",\"explanation\":\"Apoptotic DNA cleavage occurs at nucleosome intervals (about 180–200 bp), creating a ladder on electrophoresis.\"},{\"slno\":24,\"question\":\"Which proteins are anti-apoptotic?\",\"image\":null,\"option a\":\"BAX, BAK\",\"option b\":\"BCL-2, BCL-XL\",\"option c\":\"Caspase 3, 6\",\"option d\":\"Noxa, Puma\",\"answer\":\"B\",\"explanation\":\"BCL-2 and BCL-XL stabilize mitochondrial membranes, preventing cytochrome c release and apoptosis.\"},{\"slno\":25,\"question\":\"What is the final step in apoptosis before cell fragments are engulfed?\",\"image\":null,\"option a\":\"DNA smearing\",\"option b\":\"Mitochondrial damage\",\"option c\":\"Apoptotic body formation\",\"option d\":\"Caspase 9 activation\",\"answer\":\"B\",\"explanation\":\"Apoptotic bodies containing nuclear and cytoplasmic contents are formed and phagocytosed by neighboring cells.\"},{\"slno\":26,\"question\":\"Which pathway of apoptosis is triggered by FAS-L or TNF?\",\"image\":null,\"option a\":\"Intrinsic\",\"option b\":\"Extrinsic\",\"option c\":\"Necrotic\",\"option d\":\"Hypoxic\",\"answer\":\"B\",\"explanation\":\"The extrinsic pathway involves ligand binding (FAS-L, TNF) to death receptors, leading to caspase activation.\"}]')
  ];
  List<dynamic> get mcqtest => _mcqtest;
  set mcqtest(List<dynamic> value) {
    _mcqtest = value;
  }

  void addToMcqtest(dynamic value) {
    mcqtest.add(value);
  }

  void removeFromMcqtest(dynamic value) {
    mcqtest.remove(value);
  }

  void removeAtIndexFromMcqtest(int index) {
    mcqtest.removeAt(index);
  }

  void updateMcqtestAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    mcqtest[index] = updateFn(_mcqtest[index]);
  }

  void insertAtIndexInMcqtest(int index, dynamic value) {
    mcqtest.insert(index, value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
