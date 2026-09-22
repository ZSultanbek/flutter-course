import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // the ONE line to change if all labels or values should look different
          Text(
            label,
            style: TextStyle(fontFamily: 'ComicSans', color: colors.primary),
          ),
          Text(
            value,
            style: TextStyle(fontFamily: 'Impact', color: colors.secondary),
          ),
        ],
      ),
    );
  }
}
