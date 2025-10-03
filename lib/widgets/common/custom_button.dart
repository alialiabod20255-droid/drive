import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final IconData? icon;
  const CustomButton({super.key, required this.label, this.onPressed, this.loading = false, this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: loading ? null : onPressed,
        icon: icon != null ? Icon(icon) : const SizedBox.shrink(),
        label: loading
            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
            : Text(label),
      ),
    );
  }
}
