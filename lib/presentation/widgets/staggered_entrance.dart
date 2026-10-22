import 'package:fitness_app/constants/number_constant.dart';
import 'package:flutter/material.dart';

class StaggeredEntrance extends StatefulWidget {
  final int index;
  final Widget child;
  final Duration? delay;

  const StaggeredEntrance({super.key, required this.index, required this.child, this.delay,});

  @override
  State<StaggeredEntrance> createState() => _StaggeredEntranceState();
}

class _StaggeredEntranceState extends State<StaggeredEntrance> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: NumberConstant.animEntranceMs),);
    final curve = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic,);
    _opacity = curve;
    _slide = Tween<Offset>(begin: const Offset(0, NumberConstant.animSlideOffset), end: Offset.zero,).animate(curve);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (MediaQuery.disableAnimationsOf(context)) {
        _controller.value = 1;
        return;
      }
      final delay = widget.delay ?? Duration(milliseconds: widget.index * NumberConstant.animStaggerMs);
      Future.delayed(delay, () {
        if (mounted) _controller.forward();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _slide, child: widget.child,),
    );
  }
}
