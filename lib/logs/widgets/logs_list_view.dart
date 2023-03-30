import 'package:flutter/material.dart';
import 'package:log_viewer/logs/bloc/logs_bloc.dart';

import 'logs_list_item.dart';

class LogsListView extends StatelessWidget {
  LogsListView({super.key, required this.state});

  final LogsState state;
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    switch (state.status) {
      case LogsStatus.failure:
        return const Center(child: Text('Failed to fetch logs'));
      case LogsStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case LogsStatus.success:
        if (state.logs.isEmpty) {
          return const Center(child: Text('No logs'));
        }
        return ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              Divider(height: 1),
          itemBuilder: (BuildContext context, int index) {
            return LogsListItem(log: state.logs[index]);
          },
          itemCount: state.logs.length,
          controller: _scrollController,
        );
      case LogsStatus.initial:
        return const Center(child: CircularProgressIndicator());
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }
}
