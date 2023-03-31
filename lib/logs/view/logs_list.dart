import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:log_viewer/logs/widgets/logs_list_view.dart';

import '../bloc/logs_bloc.dart';

class LogsList extends StatefulWidget {
  const LogsList({super.key});

  @override
  State<LogsList> createState() => _LogsListState();
}

class _LogsListState extends State<LogsList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogsBloc, LogsState>(
      builder: (context, state) {
        return Column(children: [
          Expanded(
              child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.transparent,
                  child: LogsListView(state: state)))
        ]);
      },
    );
  }
}
