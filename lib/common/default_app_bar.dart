import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final List<Widget>? actions;
  final bool showBackButton;

  const DefaultAppBar({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.actions,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Theme.of(context).appBarTheme.foregroundColor ??
              Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: centerTitle,
      backgroundColor:
      Theme.of(context).appBarTheme.backgroundColor ?? Colors.blue,
      elevation: Theme.of(context).appBarTheme.elevation ?? 4.0,
      leading: showBackButton
          ? IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Theme.of(context).appBarTheme.foregroundColor ??
              Colors.white,
        ),
        onPressed: () => Navigator.of(context).pop(),
      )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
