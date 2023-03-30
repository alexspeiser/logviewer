import 'package:flutter/material.dart';

import '../models/log.dart';
import 'package:intl/intl.dart';

class LogsListItem extends StatelessWidget {
  const LogsListItem({super.key, required this.log});

  final Log log;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        title: Text(log.content),
        trailing: Text(DateFormat.Hm().format(log.time)),
        dense: true,
      ),
    );
  }
}
