// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';

class Popover extends StatelessWidget {
  const Popover({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 46),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [buildHandle(context), if (child != null) child],
      ),
    );
  }

  Widget buildHandle(BuildContext context) {
    final theme = Theme.of(context);

    return FractionallySizedBox(
      widthFactor: 0.25,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: Container(
          height: 5,
          decoration: BoxDecoration(
              color: theme.dividerColor,
              borderRadius: const BorderRadius.all(Radius.circular(2.5))),
        ),
      ),
    );
  }
}
