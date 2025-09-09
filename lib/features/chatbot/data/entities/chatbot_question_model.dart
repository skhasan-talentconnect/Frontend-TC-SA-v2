class ChatbotQuestion {
  final int id;
  final String question;
  final String field;
  final String value;

  ChatbotQuestion({
    required this.id,
    required this.question,
    required this.field,
    required this.value,
  });

  factory ChatbotQuestion.fromJson(Map<String, dynamic> json) {
    return ChatbotQuestion(
      id: (json['id'] ?? 0) is int ? json['id'] : int.tryParse('${json['id']}') ?? 0,
      question: json['question'] ?? '',
      field: json['field'] ?? '',
      value: json['value'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'question': question,
    'field': field,
    'value': value,
  };
}
