part of 'logs_bloc.dart';

enum LogsStatus { initial, loading, success, failure }

class LogsState extends Equatable {
  const LogsState({
    this.status = LogsStatus.initial,
    this.logs = const <Log>[],
  });

  final LogsStatus status;
  final List<Log> logs;

  LogsState copyWith({
    LogsStatus? status,
    List<Log>? logs,
  }) {
    return LogsState(status: status ?? this.status, logs: logs ?? this.logs);
  }

  @override
  String toString() {
    return 'LogsState {status: $status, logs: ${logs.length}}';
  }

  @override
  List<Object> get props => [status, logs];
}
