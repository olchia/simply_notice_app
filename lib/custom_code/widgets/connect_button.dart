// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:math' as math;

/// ConnectButton — кнопка с тремя состояниями: idle, loading, success.
///
/// [label] — текст на кнопке в idle-состоянии (например "Подключить")
/// [successLabel] — текст после успеха (например "Подключено")
/// [loadingDurationMs] — сколько держать состояние loading до автоматического
/// перехода в success. Если 0 — не переключать автоматически, юзер должен
/// программно переключить через [state]. [state] — внешнее управление
/// состоянием (опционально): 0 = idle, 1 = loading, 2 = success. Если
/// передан, внутренняя логика таймера игнорируется. [height] — высота кнопки
/// (по умолчанию 56) [onTap] — Action, вызываемый при нажатии в
/// idle-состоянии. Здесь подключаешь свой реальный Action (например, запрос к
/// Apple Health). Если передан loadingDurationMs > 0, через это время кнопка
/// автоматически перейдёт в success.
class ConnectButton extends StatefulWidget {
  const ConnectButton({
    super.key,
    this.width,
    this.height = 56,
    this.label = 'Подключить',
    this.successLabel = 'Подключено',
    this.loadingDurationMs = 1800,
    this.state,
    this.onTap,
  });

  final double? width;
  final double height;
  final String label;
  final String successLabel;
  final int loadingDurationMs;
  final int? state;
  final Future Function()? onTap;

  @override
  State<ConnectButton> createState() => _ConnectButtonState();
}

class _ConnectButtonState extends State<ConnectButton>
    with TickerProviderStateMixin {
  static const int _idle = 0;
  static const int _loading = 1;
  static const int _success = 2;

  // Цветовая палитра кнопки
  static const Color _idleBg = Color(0xFFF0F1FB);
  static const Color _idleFg = Color(0xFF0B0F1A);
  static const Color _successBg = Color(0xFF1D9E75);
  static const Color _successFg = Color(0xFFFFFFFF);

  int _currentState = _idle;

  late final AnimationController _bgController; // переход цвета фона
  late final AnimationController _successController; // галочка и текст
  late final AnimationController _spinController; // вращение спиннера

  @override
  void initState() {
    super.initState();
    _currentState = widget.state ?? _idle;

    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
      value: _currentState == _success ? 1.0 : 0.0,
    );
    _successController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
      value: _currentState == _success ? 1.0 : 0.0,
    );
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    if (_currentState == _loading) {
      _spinController.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant ConnectButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state != null && widget.state != _currentState) {
      _setState(widget.state!);
    }
  }

  void _setState(int newState) {
    if (newState == _currentState) return;
    setState(() {
      _currentState = newState;
    });

    if (newState == _loading) {
      _spinController.repeat();
      _bgController.reverse();
      _successController.reverse();
    } else if (newState == _success) {
      _spinController.stop();
      _bgController.forward();
      _successController.forward();
    } else {
      _spinController.stop();
      _bgController.reverse();
      _successController.reverse();
    }
  }

  Future<void> _handleTap() async {
    if (_currentState != _idle) return;

    _setState(_loading);

    if (widget.onTap != null) {
      try {
        await widget.onTap!();
      } catch (_) {
        // MVP: ошибки пока просто игнорируем
      }
    }

    if (widget.state == null && widget.loadingDurationMs > 0) {
      await Future.delayed(Duration(milliseconds: widget.loadingDurationMs));
      if (mounted) _setState(_success);
    }
  }

  @override
  void dispose() {
    _bgController.dispose();
    _successController.dispose();
    _spinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: Listenable.merge([_bgController, _successController]),
        builder: (context, _) {
          final bgT = _bgController.value;
          final bg = Color.lerp(_idleBg, _successBg, bgT)!;
          final fg = Color.lerp(_idleFg, _successFg, bgT)!;

          return Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(18),
            ),
            alignment: Alignment.center,
            child: _buildContent(fg),
          );
        },
      ),
    );
  }

  Widget _buildContent(Color fg) {
    switch (_currentState) {
      case _loading:
        return _Spinner(
          controller: _spinController,
          color: _idleFg,
        );
      case _success:
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SuccessCheck(controller: _successController),
            const SizedBox(width: 8),
            _FadeInText(
              controller: _successController,
              text: widget.successLabel,
              color: fg,
            ),
          ],
        );
      case _idle:
      default:
        return Text(
          widget.label,
          style: TextStyle(
            color: fg,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        );
    }
  }
}

/// Вращающийся спиннер
class _Spinner extends StatelessWidget {
  const _Spinner({required this.controller, required this.color});
  final AnimationController controller;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Transform.rotate(
          angle: controller.value * 2 * math.pi,
          child: SizedBox(
            width: 22,
            height: 22,
            child: CustomPaint(
              painter: _SpinnerPainter(color: color),
            ),
          ),
        );
      },
    );
  }
}

class _SpinnerPainter extends CustomPainter {
  _SpinnerPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 1.5;

    // Светлый базовый круг
    final basePaint = Paint()
      ..color = color.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawCircle(center, radius, basePaint);

    // Яркий сегмент сверху
    final arcPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      math.pi / 2,
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(_) => false;
}

/// Анимация галочки: круг появляется с отскоком, чекмарк рисуется
class _SuccessCheck extends StatelessWidget {
  const _SuccessCheck({required this.controller});
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final circleT = (controller.value / 0.35).clamp(0.0, 1.0);
        final circleScale = Curves.easeOutBack.transform(circleT);
        final checkT = ((controller.value - 0.2) / 0.35).clamp(0.0, 1.0);

        return SizedBox(
          width: 22,
          height: 22,
          child: Transform.scale(
            scale: circleScale,
            child: CustomPaint(
              painter: _CheckPainter(progress: checkT),
            ),
          ),
        );
      },
    );
  }
}

class _CheckPainter extends CustomPainter {
  _CheckPainter({required this.progress});
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final circlePaint = Paint()
      ..color = const Color(0xFFFFFFFF).withValues(alpha: 0.2);
    canvas.drawCircle(center, radius, circlePaint);

    if (progress <= 0) return;

    final k = size.width / 24;
    final p1 = Offset(7 * k, 12.5 * k);
    final p2 = Offset(10.5 * k, 16 * k);
    final p3 = Offset(17 * k, 9 * k);

    final len1 = (p2 - p1).distance;
    final len2 = (p3 - p2).distance;
    final total = len1 + len2;
    final drawn = total * progress;

    final path = Path()..moveTo(p1.dx, p1.dy);
    if (drawn <= len1) {
      final t = drawn / len1;
      path.lineTo(
        p1.dx + (p2.dx - p1.dx) * t,
        p1.dy + (p2.dy - p1.dy) * t,
      );
    } else {
      path.lineTo(p2.dx, p2.dy);
      final t = (drawn - len1) / len2;
      path.lineTo(
        p2.dx + (p3.dx - p2.dx) * t,
        p2.dy + (p3.dy - p2.dy) * t,
      );
    }

    final checkPaint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path, checkPaint);
  }

  @override
  bool shouldRepaint(covariant _CheckPainter old) => old.progress != progress;
}

/// Текст, появляющийся с задержкой и лёгким сдвигом снизу
class _FadeInText extends StatelessWidget {
  const _FadeInText({
    required this.controller,
    required this.text,
    required this.color,
  });
  final AnimationController controller;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final t = ((controller.value - 0.5) / 0.4).clamp(0.0, 1.0);
        final eased = Curves.easeOut.transform(t);
        return Opacity(
          opacity: eased,
          child: Transform.translate(
            offset: Offset(0, (1 - eased) * 4),
            child: Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
    );
  }
}
