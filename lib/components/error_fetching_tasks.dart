import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/text_styles.dart';

class ErrorFetchingTasks extends StatelessWidget {
  const ErrorFetchingTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        errorFetchingTask,
        style: TextStyles.defaultBoldTextStyle,
      ),
    );
  }
}
