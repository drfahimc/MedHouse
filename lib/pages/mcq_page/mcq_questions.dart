class McqQuestion {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String explanation;
  final int qsno;
  final String topicId;

  McqQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    required this.qsno,
    required this.topicId,
  });

  factory McqQuestion.fromJson(Map<String, dynamic> json) {
    return McqQuestion(
      question: json['questionText'] ?? '',
      options: [
        json['option1'] ?? '',
        json['option2'] ?? '',
        json['option3'] ?? '',
        json['option4'] ?? '',
      ],
      correctAnswer: json['correctAnswer'] ?? '',
      explanation: json['explanation'] ?? '',
      qsno: json['qsno'] ?? 0,
      topicId: json['topicId'] ?? '',
    );
  }
}


