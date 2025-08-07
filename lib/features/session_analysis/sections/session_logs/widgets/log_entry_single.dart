import 'package:flutter/material.dart';
import 'package:netguard/common/common.dart';
import 'package:netguard/data/data.dart';

import 'log_entry.dart';

class LogEntrySingle extends StatelessWidget {
  const LogEntrySingle(this.log, {super.key});

  final TrafficLog log;

  @override
  Widget build(BuildContext context) {
    return LogEntry(
      packageName: log.packageName,
      allowed: log.allowed,
      clipboardContent: log.destination,
      buildChild: _content,
    );
  }

  Widget _content(BuildContext context, VolumeType volumeType) {
    return Row(
      children: [
        Expanded(child: _text()),
        Icon(
          log.outgoing ? CustomIcons.connectionOut : CustomIcons.connectionIn,
        ),
        if (volumeType == VolumeType.bytes) ...[
          const Margin.horizontal(ThemeConstants.smallSpacing),
          Text(log.size.readableFileSize()),
        ],
      ],
    );
  }

  Widget _text() {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(log.time);
    String timeStr = time.isToday ? time.hms : time.noMs;
    return Text(
      "$timeStr: ${NetworkingTools.toPortAwareProtocol(log.protocol, log.dport)} ${log.destination}:${log.dport}",
    );
  }
}
