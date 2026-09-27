import 'package:flutter/material.dart';

class ExitConfirmationScope extends StatelessWidget {
  const ExitConfirmationScope({
    required this.onConfirm,
    required this.child,
    this.message = "هل أنت متأكد تبي ترجع ؟",
    this.subtitle = "لن يتم حفظ التغييرات لو رجعت.",
    super.key,
  });

  final VoidCallback onConfirm;
  final Widget child;
  final String message;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await showExitConfirmationDialog(
          context,
          message: message,
          subtitle: subtitle,
          onConfirm: onConfirm,
        );
      },
      child: child,
    );
  }
}

Future<bool> showExitConfirmationDialog(
  BuildContext context, {
  required VoidCallback onConfirm,
  String message = "هل أنت متأكد تبي ترجع ؟",
  String? subtitle = "لن يتم حفظ التغييرات لو رجعت.",
}) async {
  final shouldGoBack = await showDialog<bool>(
    context: context,
    builder: (context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Text(
            "تأكيد",
            style: TextStyle(
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              if (subtitle != null) ...[
                SizedBox(height: 10),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                "لا",
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            TextButton(
              onPressed: onConfirm,
              child: Text(
                "نعم",
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.redAccent,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
  return shouldGoBack ?? false;
}
