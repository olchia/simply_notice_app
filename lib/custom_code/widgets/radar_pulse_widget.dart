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

/// RadarPulseWidget — анимация «радар-импульс»
///
/// Прозрачный фон: можно ставить поверх любого цвета.
///
/// От центра медленно расходятся концентрические круги. На фоне мягко мерцают
/// точки. В центре — ядро со свечением.
class RadarPulseWidget extends StatefulWidget {
  const RadarPulseWidget({
    super.key,
    this.width,
    this.height,
    this.pulseIntervalMs = 3500,
    this.accentColor = const Color(0xFF5EECD4),
    this.backgroundDotCount = 28,
  });

  final double? width;
  final double? height;

  /// Интервал между импульсами радара в миллисекундах.
  final int pulseIntervalMs;

  /// Основной цвет акцента.
  final Color accentColor;

  /// Количество фоновых мерцающих точек.
  final int backgroundDotCount;

  @override
  State<RadarPulseWidget> createState() => _RadarPulseState();
}

class _RadarPulseState extends State<RadarPulseWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late List<_Dot> _dots;

  final math.Random _rng = math.Random();
  final DateTime _startTime = DateTime.now();

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(days: 1),
    )..repeat();

    _spawnDots();
  }

  @override
  void didUpdateWidget(covariant RadarPulseWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.backgroundDotCount != widget.backgroundDotCount) {
      _spawnDots();
    }
  }

  void _spawnDots() {
    final int count = widget.backgroundDotCount.clamp(0, 200);

    _dots = List.generate(count, (_) {
      return _Dot(
        nx: _rng.nextDouble(),
        ny: _rng.nextDouble(),
        radius: 0.8 + _rng.nextDouble() * 1.6,
        opacity: 0.15 + _rng.nextDouble() * 0.35,
        flickerPhase: _rng.nextDouble() * 2 * math.pi,
      );
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, __) {
          final int tMs = DateTime.now().difference(_startTime).inMilliseconds;

          return CustomPaint(
            painter: _RadarPainter(
              tMs: tMs,
              dots: _dots,
              pulseIntervalMs: widget.pulseIntervalMs,
              color: widget.accentColor,
            ),
            child: const SizedBox.expand(),
          );
        },
      ),
    );
  }
}

class _RadarPainter extends CustomPainter {
  _RadarPainter({
    required this.tMs,
    required this.dots,
    required this.pulseIntervalMs,
    required this.color,
  });

  final int tMs;
  final List<_Dot> dots;
  final int pulseIntervalMs;
  final Color color;

  Color _withOpacity(Color c, double opacity) {
    return c.withOpacity(opacity.clamp(0.0, 1.0));
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final Offset center = Offset(cx, cy);

    // Радиус, до которого расходятся импульсы.
    // Можно менять:
    // 0.34 — компактно
    // 0.42 — крупнее
    // 0.48 — ещё крупнее
    final double maxRingRadius = math.min(size.width, size.height) * 0.42;

    // Расходящиеся круги.
    final List<int> offsets = [
      0,
      pulseIntervalMs ~/ 2.5,
    ];

    for (final int offset in offsets) {
      final int safeInterval = math.max(1, pulseIntervalMs);
      final double phase = ((tMs + offset) % safeInterval) / safeInterval;
      final double r = phase * maxRingRadius;
      final double alpha = (1 - phase) * 0.35;

      canvas.drawCircle(
        center,
        r,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2
          ..color = _withOpacity(color, alpha),
      );
    }

    // Фоновые мерцающие точки.
    final double tSec = tMs / 1000.0;

    for (final _Dot d in dots) {
      final double flick = (math.sin(tSec * 0.8 + d.flickerPhase) + 1) / 2;

      final double dx = d.nx * size.width;
      final double dy = d.ny * size.height;

      canvas.drawCircle(
        Offset(dx, dy),
        d.radius,
        Paint()
          ..color = _withOpacity(
            Colors.white,
            d.opacity * (0.5 + flick * 0.5),
          ),
      );
    }

    // Ядро со свечением.
    _drawCoreLayer(
      canvas: canvas,
      center: center,
      radius: 22.0,
      alpha: 0.10,
    );

    _drawCoreLayer(
      canvas: canvas,
      center: center,
      radius: 13.0,
      alpha: 0.28,
    );

    _drawCoreLayer(
      canvas: canvas,
      center: center,
      radius: 6.5,
      alpha: 0.70,
    );

    _drawCoreLayer(
      canvas: canvas,
      center: center,
      radius: 3.0,
      alpha: 1.00,
    );
  }

  void _drawCoreLayer({
    required Canvas canvas,
    required Offset center,
    required double radius,
    required double alpha,
  }) {
    final double safeRadius = math.max(0.1, radius);

    canvas.drawCircle(
      center,
      safeRadius,
      Paint()
        ..shader = RadialGradient(
          colors: [
            _withOpacity(Colors.white, alpha),
            _withOpacity(color, alpha),
            Colors.transparent,
          ],
          stops: const [0.0, 0.5, 1.0],
        ).createShader(
          Rect.fromCircle(
            center: center,
            radius: safeRadius,
          ),
        ),
    );
  }

  @override
  bool shouldRepaint(covariant _RadarPainter oldDelegate) => true;
}

class _Dot {
  _Dot({
    required this.nx,
    required this.ny,
    required this.radius,
    required this.opacity,
    required this.flickerPhase,
  });

  final double nx;
  final double ny;
  final double radius;
  final double opacity;
  final double flickerPhase;
}
