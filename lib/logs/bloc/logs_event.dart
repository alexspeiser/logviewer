part of 'logs_bloc.dart';

abstract class LogsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LogsFetched extends LogsEvent {}
