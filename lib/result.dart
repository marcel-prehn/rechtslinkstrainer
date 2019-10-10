import 'dart:convert';

Result resultFromJson(String value) {
  final jsonData = json.decode(value);
  return Result.fromMap(jsonData);
}

String resultToJson(Result result) {
  final map = result.toMap();
  return json.encode(map);
}

class Result {
  final String uuid;
  final int practiceId;
  final String timestamp;
  final int correct;
  final int incorrect;

  Result({this.uuid, this.practiceId, this.timestamp, this.correct, this.incorrect});

  factory Result.fromMap(Map<String, dynamic> json) => new Result(
        uuid: json["uuid"],
        practiceId: json["practice_id"],
        timestamp: json["timestamp"],
        correct: json["correct"],
        incorrect: json["incorrect"],
      );

  Map<String, dynamic> toMap() => {
        "uuid": uuid,
        "practice_id": practiceId,
        "timestamp": timestamp,
        "correct": correct,
        "incorrect": incorrect,
      };
}
