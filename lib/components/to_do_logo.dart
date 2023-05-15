import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/text_styles.dart';

class ToDoLogo extends StatelessWidget {
  const ToDoLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.task,
            size: 100,
          ),
          SizedBox(height: 10),
          Text(
            appName,
            style: TextStyles.appNameTextStyle,
          ),
        ],
      ),
    );
  }
}
