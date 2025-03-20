import 'package:equatable/equatable.dart';

class Activity extends Equatable {
  final int id;
  final String text;
  final bool isSaved;
  const Activity({
    required this.id,
    required this.text,
    required this.isSaved,
  });

  Activity.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['key']),
        text = json['activity'],
        isSaved = false;

  Activity.fromDatabaseJson(Map<String, dynamic> json)
      : id = json['key'],
        text = json['description'],
        isSaved = false;

  Map<String, dynamic> toJson() {
    return {
      'key': id,
      'description': text,
    };
  }

  Activity copyWith(bool? isSaved) {
    return Activity(
      id: id,
      text: text,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  @override
  List<Object?> get props => [id, text, isSaved];
}
