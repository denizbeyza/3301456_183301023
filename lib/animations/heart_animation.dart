import 'package:flutter/material.dart';

class HeartAnimationWidget extends StatefulWidget {
  const HeartAnimationWidget({
    Key? key,
    required this.child,
    required this.isAnimating,
    this.onEnd,
  }) : super(key: key);
  final Widget child;
  final bool isAnimating;
  final VoidCallback? onEnd;
  @override
  State<HeartAnimationWidget> createState() => _HeartAnimationWidgetState();
}

class _HeartAnimationWidgetState extends State<HeartAnimationWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    scale = Tween<double>(
      begin: 1,
      end: 1.2,
    ).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant HeartAnimationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimating != oldWidget.isAnimating) {
      doAnimation();
    }
  }

  Future doAnimation() async {
    if (widget.isAnimating) {
      await controller.forward();
      await controller.reverse();
      await Future.delayed(const Duration(milliseconds: 400));
      if (widget.onEnd != null) {
        widget.onEnd!();
      }
      widget.onEnd!();
    }
  }

  late Animation<double> scale;
  late AnimationController controller;
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}
