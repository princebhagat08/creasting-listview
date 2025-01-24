import 'dart:math';

import 'package:flutter/material.dart';
import 'package:youbloomdemo/config/color/color.dart';

class CustomLoader extends StatefulWidget {
  final double size;
  final Color? primaryColor;
  final Color? secondaryColor;
  final Duration duration;

  const CustomLoader({
    super.key,
    this.size = 50.0,
    this.primaryColor,
    this.secondaryColor,
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  State<CustomLoader> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = widget.primaryColor ?? AppColor.primaryColor;
    final secondaryColor =
        widget.secondaryColor ?? primaryColor.withOpacity(0.5);

    return Center(
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.rotate(
              angle: _controller.value * 2 * 3.14,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _buildDot(0, primaryColor),
                  _buildDot(1, secondaryColor),
                  _buildDot(2, primaryColor),
                  _buildDot(3, secondaryColor),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDot(int index, Color color) {
    final double angle = index * (3.14 / 2); // 90 degrees spacing
    final double radius = widget.size * 0.35;

    return Transform(
      transform: Matrix4.identity()
        ..translate(
          radius * cos(angle),
          radius * sin(angle),
        ),
      child: Container(
        width: widget.size * 0.2,
        height: widget.size * 0.2,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
    );
  }
}
