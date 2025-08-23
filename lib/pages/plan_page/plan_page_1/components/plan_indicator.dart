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
      setState(() {
        _currentPage = widget.controller.hasClients ? widget.controller.page ?? widget.controller.initialPage.toDouble() : 0.0;
      });
    };
    widget.controller.addListener(_listener);
    _currentPage = widget.controller.hasClients ? widget.controller.page ?? widget.controller.initialPage.toDouble() : 0.0;
  }

  @override
  void didUpdateWidget(covariant PlanIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_listener);
      widget.controller.addListener(_listener);
      _currentPage = widget.controller.hasClients ? widget.controller.page ?? widget.controller.initialPage.toDouble() : 0.0;
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.count, (index) {
        final selected = (_currentPage.round() == index);
        final progress = (_currentPage - index).abs().clamp(0.0, 1.0);
        final width = selected
            ? ui.lerpDouble(widget.dotActiveWidth, widget.dotSize, progress)!
            : widget.dotSize;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin:  EdgeInsets.symmetric(horizontal: width * 0.4),
          width: width,
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
