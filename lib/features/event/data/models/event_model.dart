import 'package:login_with_unite_test_and_clean_architecture/features/event/domain/entities/event_entity.dart';
import 'package:login_with_unite_test_and_clean_architecture/features/member/data/models/member_model.dart';

class EventModel extends EventEntity {
  const EventModel({
    required super.eventName,
    required super.eventDescription,
    required super.eventDate,
    required super.startTime,
    required super.endTime,
    required super.year,
    super.id,
    super.members,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      eventName: json['event_name'] as String,
      eventDescription: json['event_description'] as String,
      eventDate: json['event_date'] as String,
      startTime: json['event_start_time'] as String,
      endTime: json['event_end_time'] as String,
      year: json['year'] as int,
      id: json['id'] as int?,
      members: (json['present_members'] as List)
          .map((e) => MemberModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event_name': eventName,
      'event_description': eventDescription,
      'event_date': eventDate,
      'event_start_time': startTime,
      'event_end_time': endTime,
      'year': year,
      'present_members': members?.map((m) => m.id).toList() ?? [],
    };
  }
}
