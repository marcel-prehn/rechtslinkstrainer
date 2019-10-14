class Progress {
  final double value;

  Progress({this.value});

  factory Progress.fromMap(Map<String, dynamic> json) =>
      new Progress(value: json["value"]);

  Map<String, dynamic> toMap() => {"value": value};
}
