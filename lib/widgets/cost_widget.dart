import 'dart:ui';

import 'package:flutter/material.dart';

class CostWidget extends StatelessWidget {
  final Color color;
  final double cost;

  const CostWidget({super.key, required this.color, required this.cost});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "₹",
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontFeatures: const [
                FontFeature.superscripts(),
              ],
            ),
          ),
          Text(
            cost.toInt().toString(),
            style: TextStyle(
              fontSize: 25,
              color: color,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            (cost - cost.truncate()).toString(),
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontFeatures: const [
                FontFeature.superscripts(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
