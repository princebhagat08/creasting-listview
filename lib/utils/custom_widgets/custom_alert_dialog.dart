import 'package:flutter/material.dart';
import 'package:youbloomdemo/config/color/color.dart';
import 'package:youbloomdemo/config/text_style/text_style.dart';

class CustomAlertDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final Widget? content;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? messageColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;

  const CustomAlertDialog({
    Key? key,
    this.title,
    this.message,
    this.content,
    this.actions,
    this.backgroundColor,
    this.titleColor,
    this.messageColor,
    this.borderRadius = 8.0,
    this.contentPadding,
    this.titleStyle,
    this.messageStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
      ),
      backgroundColor: backgroundColor ?? AppColor.offWhite,
      contentPadding: contentPadding ?? const EdgeInsets.all(16.0),
      title: title != null
          ? Text(title!,
              style: titleStyle ?? xLargeBoldText, textAlign: TextAlign.center)
          : null,
      content: content ??
          (message != null
              ? Text(
                  message!,
                  style: messageStyle ?? mediumBoldText,
                  textAlign: TextAlign.center,
                )
              : null),
      actions: actions,
    );
  }
}
