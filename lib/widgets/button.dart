import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final TextStyle? textStyle;
  final bool loading;
  final bool disabled;
  final VoidCallback? onPressed;
  final Color? disableTextColor;
  final BoxDecoration? disableStyle;
  final double borderRadius;
  final double height;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final Color textColor;

  const CustomButton({
    Key? key,
    required this.title,
    this.textStyle,
    this.loading = false,
    this.disabled = false,
    this.onPressed,
    this.disableTextColor,
    this.disableStyle,
    this.borderRadius = 10,
    this.height = 50,
    this.padding = const EdgeInsets.symmetric(horizontal: 15),
    this.backgroundColor = Colors.green,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = disabled || loading;

    return GestureDetector(
      onTap: isDisabled ? null : onPressed,
      child: Container(
        height: height,
        padding: padding,
        margin: const EdgeInsets.only(top: 20),
        width: double.infinity,
        decoration: isDisabled
            ? disableStyle ??
                  BoxDecoration(
                    color: Colors.grey[400], // disable background
                    borderRadius: BorderRadius.circular(borderRadius),
                  )
            : BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
        alignment: Alignment.center,
        child: loading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(textColor),
                ),
              )
            : Text(
                title,
                style:
                    textStyle ??
                    TextStyle(
                      color: isDisabled
                          ? (disableTextColor ?? Colors.black54)
                          : textColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
              ),
      ),
    );
  }
}
