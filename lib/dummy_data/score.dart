import 'dart:convert';

class Score {
  final int topScore;
  final String time;

  Score({required this.topScore, required this.time});

  factory Score.fromJson(Map<String, dynamic> jsonData) {
    return Score(topScore: jsonData['topScore'], time: jsonData['time']);
  }
  static Map<String, dynamic> toMap(Score score) =>
      {'topScore': score.topScore, 'time': score.time};

  static String encode(List<Score> scores) => json.encode(
        scores
            .map<Map<String, dynamic>>(
                (scoreElement) => Score.toMap(scoreElement))
            .toList(),
      );

  static List<Score> decode(String score) =>
      (json.decode(score) as List<dynamic>)
          .map<Score>((item) => Score.fromJson(item))
          .toList();
}
