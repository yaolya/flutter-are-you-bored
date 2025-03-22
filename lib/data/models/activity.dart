import 'package:are_you_bored/data/database/drift_database.dart';
import 'package:equatable/equatable.dart';

class ActivityModel extends Equatable {
  final int id;
  final String text;
  final bool isSaved;
  const ActivityModel({
    required this.id,
    required this.text,
    required this.isSaved,
  });

  ActivityModel.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['key']),
        text = json['activity'],
        isSaved = false;

  ActivityModel.fromDatabaseActivity(Activity activity)
      : id = activity.key,
        text = activity.content,
        isSaved = activity.isSaved;

  ActivityModel copyWith(bool? isSaved) {
    return ActivityModel(
      id: id,
      text: text,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  @override
  List<Object?> get props => [id, text, isSaved];
}
