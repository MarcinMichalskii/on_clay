import 'package:flutter/material.dart';
import 'package:on_clay/utils/debouncer.dart';

class TouchableOpacity extends StatefulWidget {
  TouchableOpacity(
      {Key? key,
      required this.child,
      this.onTap,
      this.onLongPress,
      this.opacity = 0.5,
      this.disabled = false,
      this.animationDuration = const Duration(milliseconds: 50),
      this.delayDuration = const Duration(milliseconds: 80)})
      : _debouncer = Debouncer(duration: delayDuration),
        super(key: key);

  final Widget child;
  final double opacity;
  final Duration animationDuration;
  final Duration delayDuration;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool disabled;
  final Debouncer _debouncer;

  @override
  _TouchableOpacityState createState() => _TouchableOpacityState();
}

class _TouchableOpacityState extends State<TouchableOpacity> {
  bool _isDown = false;

  @override
  void dispose() {
    widget._debouncer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.disabled) {
      return Container(child: widget.child);
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isDown = true),
      onExit: (_) => setState(() => _isDown = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isDown = true),
        onTapUp: (_) => widget._debouncer.run(() {
          setState(() => _isDown = false);
        }),
        onTapCancel: () => setState(() => _isDown = false),
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        child: AnimatedOpacity(
          duration: widget.animationDuration,
          opacity: _isDown ? widget.opacity : 1,
          child: widget.child,
        ),
      ),
    );
  }
}
