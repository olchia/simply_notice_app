// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!

import 'dart:math' as math;

class CheckinSlider extends StatefulWidget {
  const CheckinSlider({
    super.key,
    this.width,
    this.height,
    required this.value,
    required this.isFilled,
    required this.trackStartColor,
    required this.trackMidColor,
    required this.trackEndColor,
    required this.thumbColor1,
    required this.thumbColor2,
    required this.thumbColor3,
    required this.thumbColor4,
    required this.thumbColor5,
    required this.onChanged,
  });

  final double? width;
  final double? height;

  final double value;
  final bool isFilled;

  final Color trackStartColor;
  final Color trackMidColor;
  final Color trackEndColor;

  final Color thumbColor1;
  final Color thumbColor2;
  final Color thumbColor3;
  final Color thumbColor4;
  final Color thumbColor5;

  final Future Function(double newValue) onChanged;

  @override
  State<CheckinSlider> createState() => _CheckinSliderState();
}

class _CheckinSliderState extends State<CheckinSlider> {
  static const double minValue = 1.0;
  static const double maxValue = 5.0;

  static const double trackHeight = 8.0;
  static const double thumbSize = 30.0;
  static const double thumbBorderWidth = 3.0;
  static const double thumbFontSize = 12.0;
  static const double thumbGlowBlur = 10.0;
  static const double thumbGlowSpread = 1.0;

  double _clampAndRound(double raw) {
    return raw.clamp(minValue, maxValue).roundToDouble();
  }

  double _valueFromDx(double dx, double width) {
    final safeWidth = math.max(width, 1.0);
    final percent = (dx / safeWidth).clamp(0.0, 1.0);
    final rawValue = minValue + percent * (maxValue - minValue);
    return _clampAndRound(rawValue);
  }

  Color _thumbColorForValue(double value) {
    final v = value.round();

    if (v <= 1) return widget.thumbColor1;
    if (v == 2) return widget.thumbColor2;
    if (v == 3) return widget.thumbColor3;
    if (v == 4) return widget.thumbColor4;
    return widget.thumbColor5;
  }

  Future<void> _handleTouch(Offset localPosition, double width) async {
    final newValue = _valueFromDx(localPosition.dx, width);
    await widget.onChanged(newValue);
  }

  @override
  Widget build(BuildContext context) {
    final currentValue = _clampAndRound(widget.value);
    final filled = widget.isFilled;
    final thumbColor = _thumbColorForValue(currentValue);

    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? 40,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final trackWidth = constraints.maxWidth;
          final percent = ((currentValue - minValue) / (maxValue - minValue))
              .clamp(0.0, 1.0);

          final thumbX = trackWidth * percent;

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (details) =>
                _handleTouch(details.localPosition, trackWidth),
            onHorizontalDragUpdate: (details) =>
                _handleTouch(details.localPosition, trackWidth),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                // Затемнённый базовый трек.
                Container(
                  height: trackHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    gradient: LinearGradient(
                      colors: [
                        widget.trackStartColor.withOpacity(0.40),
                        widget.trackMidColor.withOpacity(0.40),
                        widget.trackEndColor.withOpacity(0.40),
                      ],
                    ),
                  ),
                ),

                // Активный градиент появляется после выбора.
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 180),
                  opacity: filled ? 1.0 : 0.0,
                  child: Container(
                    height: trackHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      gradient: LinearGradient(
                        colors: [
                          widget.trackStartColor,
                          widget.trackMidColor,
                          widget.trackEndColor,
                        ],
                      ),
                    ),
                  ),
                ),

                // Внутренние tick marks: только 3 деления, без крайних.
                Positioned.fill(
                  child: LayoutBuilder(
                    builder: (context, tickConstraints) {
                      final w = tickConstraints.maxWidth;

                      return Stack(
                        alignment: Alignment.centerLeft,
                        children: List.generate(3, (index) {
                          final i = index + 1;
                          final tickX = w * i / 4;

                          return Positioned(
                            left: tickX - 1.5,
                            child: Container(
                              width: 3,
                              height: 8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(999),
                                color: Colors.black.withOpacity(0.25),
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ),

                // Thumb появляется только после касания.
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 160),
                  curve: Curves.easeOut,
                  left: (thumbX - thumbSize / 2).clamp(
                    0.0,
                    math.max(trackWidth - thumbSize, 0.0),
                  ),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 160),
                    opacity: filled ? 1.0 : 0.0,
                    child: Container(
                      width: thumbSize,
                      height: thumbSize,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: thumbColor,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.90),
                          width: thumbBorderWidth,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: thumbColor.withOpacity(0.70),
                            blurRadius: thumbGlowBlur,
                            spreadRadius: thumbGlowSpread,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.35),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Text(
                        currentValue.toInt().toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: thumbFontSize,
                          fontWeight: FontWeight.w800,
                          height: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
