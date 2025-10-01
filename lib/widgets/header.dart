import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final Color titleColor;
  final Color iconColor;
  final bool centerTitle;
  final VoidCallback? onBack;

  const CustomHeader({
    Key? key,
    required this.title,
    this.backgroundColor = Colors.white,
    this.titleColor = Colors.black,
    this.iconColor = Colors.black,
    this.centerTitle = false,
    this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: backgroundColor, // Background of status bar
        statusBarIconBrightness: titleColor == Colors.white
            ? Brightness.light
            : Brightness.dark,
        statusBarBrightness: titleColor == Colors.white
            ? Brightness.dark
            : Brightness.light,
      ),
      elevation: 0,
      backgroundColor: backgroundColor,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: iconColor),
        onPressed: onBack ?? () => Navigator.pop(context),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: titleColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
