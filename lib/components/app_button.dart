import 'package:flutter/material.dart';
import 'package:to_do_app/utils/constants.dart';

import '../utils/text_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.assetImage,
    this.width,
  });

  final Function() onPressed;
  final String buttonText;
  final String? assetImage;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              assetImage != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Image.asset(
                        assetImage!,
                        height: 30,
                      ),
                    )
                  : const SizedBox(),
              Text(
                buttonText,
                style: TextStyles.defaultTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
