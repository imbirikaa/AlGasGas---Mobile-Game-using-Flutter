import 'package:flutter/material.dart';

/// Neo-brutalist decoration shared by cards and tiles: flat fill,
/// thick black border, hard offset shadow (no blur).
BoxDecoration brutalBoxDecoration({
  required Color color,
  double borderRadius = 8,
  Offset shadowOffset = const Offset(6, 6),
}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(borderRadius),
    border: Border.all(color: Colors.black, width: 3),
    boxShadow: [
      BoxShadow(
        color: Colors.black,
        offset: shadowOffset,
        blurRadius: 0,
      ),
    ],
  );
}

/// A chunky, hard-edged button matching the app's neo-brutalist style.
/// Presses inward (shadow shrinks) on tap for tactile feedback.
class BrutalButton extends StatefulWidget {
  const BrutalButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.color,
    this.dimWhenDisabled = true,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? color;

  /// When false, a disabled button (onPressed: null) still renders at full
  /// opacity — used to keep a highlighted answer vibrant after selection.
  final bool dimWhenDisabled;

  @override
  State<BrutalButton> createState() => _BrutalButtonState();
}

class _BrutalButtonState extends State<BrutalButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null;
    final dimmed = !enabled && widget.dimWhenDisabled;
    final fill = widget.color ?? Theme.of(context).colorScheme.onSecondary;
    final textColor = Theme.of(context).colorScheme.primary;
    final offset = _pressed ? const Offset(1, 1) : const Offset(4, 4);

    return GestureDetector(
      onTapDown: enabled ? (_) => setState(() => _pressed = true) : null,
      onTapUp: enabled ? (_) => setState(() => _pressed = false) : null,
      onTapCancel: enabled ? () => setState(() => _pressed = false) : null,
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(
          _pressed ? 3 : 0,
          _pressed ? 3 : 0,
          0,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: dimmed ? fill.withAlpha(130) : fill,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.black, width: 3),
          boxShadow: enabled || !widget.dimWhenDisabled
              ? [
                  BoxShadow(
                    color: Colors.black,
                    offset: enabled ? offset : const Offset(4, 4),
                    blurRadius: 0,
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.icon != null) ...[
              Icon(widget.icon, color: textColor, size: 22),
              const SizedBox(width: 8),
            ],
            Text(
              widget.label,
              style: TextStyle(
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: dimmed ? textColor.withAlpha(160) : textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
