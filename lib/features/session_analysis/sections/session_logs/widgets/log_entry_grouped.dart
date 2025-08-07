import 'package:flutter/material.dart';
import 'package:netguard/netguard.dart';

import 'log_entry.dart';

class LogEntryGrouped extends StatelessWidget {
  const LogEntryGrouped(this.log, {super.key});

  final TrafficLogGroup log;

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
        _volume(context, volumeType),
      ],
    );
  }

  Widget _volume(BuildContext context, VolumeType volumeType){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Outgoing traffic volume
        _trafficIndicator(context, CustomIcons.connectionOut, _volumeOut(volumeType)),
        // Incoming traffic volume
        _trafficIndicator(context, CustomIcons.connectionIn, _volumeIn(volumeType)),
      ],
    );
  }
  Widget _trafficIndicator(BuildContext context, IconData icon, String label) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(label, style: context.textTheme.labelSmall),
          const Margin.horizontal(ThemeConstants.smallSpacing),
          Icon(icon, size: context.textTheme.labelSmall.size,),
        ],
      );
  String _volumeIn(VolumeType volumeType) => switch (volumeType) {
    VolumeType.count => log.countIn.toString(),
    VolumeType.bytes => log.sizeIn.readableFileSize(),
  };
  String _volumeOut(VolumeType volumeType) => switch (volumeType) {
    VolumeType.count => log.countOut.toString(),
    VolumeType.bytes => log.sizeOut.readableFileSize(),
  };

  Widget _text() {
    String text =
        "${NetworkingTools.toPortAwareProtocol(log.protocol, log.dport)} ${log.destination}";
    return Text(text);
  }
}
