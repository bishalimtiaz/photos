import 'package:flutter/material.dart';
import 'package:photos/app/core/constants/app_values.dart';

class PrimaryButton extends StatelessWidget {
  final Function()? onTap;
  final Widget child;

  const PrimaryButton({
    required this.child,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xFF66FFB6)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppValues.dimen_50,
            ),
          ),
        ),
      ),
      onPressed: onTap,
      child: child,
    );
  }
}
