import 'package:flutter/material.dart';

import '../utils/constants.dart';

class PencilIconContainer extends StatelessWidget {
  const PencilIconContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.mode_edit,
        size: 30,
        color: buttonColor,
      ),
    );
  }
}
