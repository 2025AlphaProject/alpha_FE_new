import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui' as ui;

class PlanIndicator extends StatefulWidget {
  final PageController controller;
  final int count;
  final double dotSize;
  final double dotActiveWidth;

  const PlanIndicator({
    Key? key,
    required this.controller,
    required this.count,
    required this.dotSize,
    required this.dotActiveWidth,
  }) : super(key: key);

  @override
  State<PlanIndicator> createState() => _PlanIndicatorState();
}

class _PlanIndicatorState extends State<PlanIndicator> {
  double _currentPage = 0.0;
  late final VoidCallback _listener;

  @override
  void initState() {
    super.initState();
    _listener = () {
      if (!mounted) return;
      if (widget.controller.hasClients && widget.controller.positions.length == 1) {
        setState(() {
          _currentPage = widget.controller.page ?? widget.controller.initialPage.toDouble();
        });
      }
    };
    widget.controller.addListener(_listener);
    if (widget.controller.hasClients && widget.controller.positions.length == 1) {
      _currentPage = widget.controller.page ?? widget.controller.initialPage.toDouble();
    }
  }

  @override
  void didUpdateWidget(covariant PlanIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_listener);
      widget.controller.addListener(_listener);
      if (widget.controller.hasClients && widget.controller.positions.length == 1) {
        _currentPage = widget.controller.page ?? widget.controller.initialPage.toDouble();
      }
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.count, (index) {
        final selected = (_currentPage.round() == index);
        final progress = (_currentPage - index).abs().clamp(0.0, 1.0);
        final dotWidth = selected
            ? ui.lerpDouble(widget.dotActiveWidth, widget.dotSize, progress)!
            : widget.dotSize;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(horizontal:screenWidth*0.01 ),
          width: dotWidth,
          height: widget.dotSize,
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xCCD3351E)
                : const Color(0x33555555),
            borderRadius: BorderRadius.circular(widget.dotSize),
          ),
        );
      }),
    );
  }
}
