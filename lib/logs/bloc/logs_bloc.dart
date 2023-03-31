import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:log_viewer/authentication/bloc/authentication_bloc.dart';
import 'package:log_viewer/selector/cubit/selector_cubit.dart';
import 'package:async/async.dart';

import '../models/models.dart';

part 'logs_event.dart';
part 'logs_state.dart';

class LogsBloc extends Bloc<LogsEvent, LogsState> {
  LogsBloc(
      {required this.httpClient,
      required this.auth,
      required this.dateSelector})
      : super(const LogsState()) {
    selectedDate = DateTime.now();
    token = '';
    streamSubscription =
        StreamGroup.merge([auth.stream, dateSelector.stream]).listen((event) {
      if (event is AuthenticationState) {
        token = event.token;
      } else {
        selectedDate = event as DateTime;
      }
      add(LogsFetched());
    });
    on<LogsFetched>(_onLogsFetched);
  }

  final http.Client httpClient;
  final AuthenticationBloc auth;
  final SelectorCubit dateSelector;
  late final StreamSubscription streamSubscription;
  late String token;
  late DateTime selectedDate;

  Future<void> _onLogsFetched(
      LogsFetched event, Emitter<LogsState> emit) async {
    try {
      if (state.status == LogsStatus.initial) {
        emit(state.copyWith(status: LogsStatus.loading));
        final logs = await _fetchLogs();
        return emit(state.copyWith(status: LogsStatus.success, logs: logs));
      }
      final logs = await _fetchLogs();
      emit(state.copyWith(
        status: LogsStatus.success,
        logs: logs,
      ));
    } catch (_) {
      emit(state.copyWith(status: LogsStatus.failure));
    }
  }

  // Future<List<Log>> _fetchLogsMock() async {
  //   List<Log> logs2 = [];

  //   for (int i = 0; i < DateTime.now().second; i++) {
  //     logs2.add(Log(
  //         id: i.toString(),
  //         content: DateTime.now().toString(),
  //         time: DateTime.now()));
  //   }

  //   debugPrint(logs2.toString());
  //   return logs2;
  // }

  Future<List<Log>> _fetchLogs() async {
    final logsRequest = Uri.https('myhoursdevelopment-api.azurewebsites.net',
        'api/Logs', {'date': DateFormat('yyyy.MM.dd.').format(selectedDate)});

    final logResponse = await httpClient.get(logsRequest, headers: {
      HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.acceptHeader: "application/json"
    });

    debugPrint(logResponse.statusCode.toString());
    debugPrint(logResponse.body);

    if (logResponse.statusCode != 200) {
      return [];
    }

    final logs = jsonDecode(logResponse.body);

    if (logs.toList().length == 0) {
      return [];
    }

    return logs
        .map((log) =>
            Log(id: log["id"], content: log["note"], time: log["date"]))
        .toList();
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
