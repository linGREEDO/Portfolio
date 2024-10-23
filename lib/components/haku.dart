import 'package:flutter/material.dart';

class HakuAnimation extends StatefulWidget {
  const HakuAnimation({super.key});

  @override
  HakuAnimationState createState() => HakuAnimationState();
}

class HakuAnimationState extends State<HakuAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _flyingAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 40),
      vsync: this,
    )..repeat();

    _flyingAnimation = Tween<Offset>(
      begin: const Offset(1.5, -0.2),
      end: const Offset(-1.5, 0.2),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: -0.05,
      end: 0.05,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _flyingAnimation,
      child: RotationTransition(
        turns: _rotationAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Image.asset(
            'assets/images/castle_flying.png',
            width: 200,
            height: 100,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
