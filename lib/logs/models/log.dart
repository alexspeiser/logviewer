import 'package:equatable/equatable.dart';

class Log extends Equatable {
  const Log({required this.id, required this.content, required this.time});

  final String id;
  final String content;
  final DateTime time;

  @override
  List<Object> get props => [id, content, time];
}
