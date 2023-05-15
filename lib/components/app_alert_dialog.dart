import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/text_styles.dart';
import 'app_button.dart';

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onPressedOk,
  });

  final String title;
  final String content;
  final Function() onPressedOk;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyles.defaultBoldTextStyle,
      ),
      content: Text(
        content,
        style: TextStyles.defaultTextStyle,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: AppButton(
                onPressed: () => Navigator.pop(context),
                buttonText: cancel,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AppButton(
                onPressed: onPressedOk,
                buttonText: ok,
              ),
            ),
          ],
        )
      ],
    );
  }
}
