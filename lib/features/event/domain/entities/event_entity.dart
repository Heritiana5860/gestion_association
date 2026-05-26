import 'package:login_with_unite_test_and_clean_architecture/features/member/domain/entities/member_entity.dart';

class EventEntity {
  final int id;
  final String eventName;
  final String eventDescription;
  final String eventDate;
  final String startTime;
  final String endTime;
  final int year;
  final List<MemberEntity>? members;

  const EventEntity({
    required this.eventName,
    required this.eventDescription,
    required this.eventDate,
    required this.startTime,
    required this.endTime,
    required this.year,
    required this.id,
    this.members,
  });
}
