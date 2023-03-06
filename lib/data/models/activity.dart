class Activity {
  final int id;
  final String act;
  Activity(this.id, this.act);

  Activity.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['key']),
        act = json['activity'];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Activity && runtimeType == other.runtimeType && id == other.id;
}
