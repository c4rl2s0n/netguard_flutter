import 'package:flutter/material.dart';
import 'package:netguard/netguard.dart';

class InformativeProgressIndicator extends StatelessWidget {
  const InformativeProgressIndicator({
    this.progress,
    this.size = 50,
    this.color,
    super.key,
  });

  final double size;
  final double? progress;
  final Color? color;

  bool get hasProgress => progress != null;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          if (hasProgress) ...[
            Center(
              child: Text(
                (progress! * 100).toStringAsFixed(0),
                style: context.textTheme.labelSmall?.copyWith(color: color),
              ),
            ),
          ],
          CircularProgressIndicator(
            value: hasProgress ? progress : null,
            color: color,
          ),
        ],
      ),
    );
  }
}
