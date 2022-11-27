import 'package:flagle/constants/constants.dart';
import 'package:flutter/material.dart';

class StatusHeader extends StatelessWidget {
  const StatusHeader({
    Key? key,
    required this.attemptsRemaining,
  }) : super(key: key);

  final int attemptsRemaining;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '$attemptsRemaining out of ${Constants.maxAttempts} attempts left.',
          style: const TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
