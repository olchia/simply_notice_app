// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:math';

class TransitionParticleV7Widget extends StatefulWidget {
  const TransitionParticleV7Widget({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  State<TransitionParticleV7Widget> createState() =>
      _TransitionParticleV7WidgetState();
}

class _TransitionParticleV7WidgetState extends State<TransitionParticleV7Widget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late List<_Particle> _particles;
  final Random _rng = Random();

  static const Color _colorStable = Color(0xFF5EECD4); // бирюзовый
  static const Color _colorWarning = Color(0xFFFBBF24); // янтарный

  static const double _stableSpreadMin = 16.0;
  static const double _stableSpreadMax = 65.0;
  static const double _stableChaos = 0.30;
  static const double _stableSpeedMult = 1.00;

  static const double _warnSpreadMin = 28.0;
  static const double _warnSpreadMax = 100.0;
  static const double _warnChaos = 0.75;
  static const double _warnSpeedMult = 1.65;

  static const int _particleCount = 88;

  @override
  void initState() {
    super.initState();

    _spawnParticles();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  void _spawnParticles() {
    _particles = List.generate(_particleCount, (_) {
      final w = pow(_rng.nextDouble(), 1.5).toDouble();

      return _Particle(
        angle: _rng.nextDouble() * 2 * pi,
        normRad: w,
        baseSpeed:
            (0.0008 + _rng.nextDouble() * 0.0022) * (_rng.nextBool() ? 1 : -1),
        wobble: _rng.nextDouble() * 2 * pi,
        wobbleSpeed: 0.010 + _rng.nextDouble() * 0.015,
        wobbleNorm: 0.40 + _rng.nextDouble() * 0.80,
        size: 0.9 + _rng.nextDouble() * 2.3,
        opacity: 0.38 + _rng.nextDouble() * 0.60,
      );
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  // t = 0 — стабильное бирюзовое состояние
  // t = 1 — состояние внимания, янтарный оттенок
  // цикл: бирюзовый → янтарный → бирюзовый
  double get _t {
    final phase = _ctrl.value;
    final raw = (sin(phase * 2 * pi - pi / 2) + 1) / 2;

    return raw < 0.5 ? 4 * raw * raw * raw : 1 - pow(-2 * raw + 2, 3) / 2.0;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, __) {
          return CustomPaint(
            painter: _V7Painter(
              particles: _particles,
              t: _t,
            ),
            child: const SizedBox.expand(),
          );
        },
      ),
    );
  }
}

class _CoreLayer {
  final double radius;
  final double alpha;

  const _CoreLayer({
    required this.radius,
    required this.alpha,
  });
}

class _V7Painter extends CustomPainter {
  final List<_Particle> particles;
  final double t;

  _V7Painter({
    required this.particles,
    required this.t,
  });

  Color _lerpColor(Color a, Color b, double t) {
    return Color.lerp(a, b, t) ?? a;
  }

  double _lerp(double a, double b, double t) {
    return a + (b - a) * t;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height * 0.48;
    final center = Offset(cx, cy);

    final color = _lerpColor(
      _TransitionParticleV7WidgetState._colorStable,
      _TransitionParticleV7WidgetState._colorWarning,
      t,
    );

    final spreadMin = _lerp(
      _TransitionParticleV7WidgetState._stableSpreadMin,
      _TransitionParticleV7WidgetState._warnSpreadMin,
      t,
    );

    final spreadMax = _lerp(
      _TransitionParticleV7WidgetState._stableSpreadMax,
      _TransitionParticleV7WidgetState._warnSpreadMax,
      t,
    );

    final chaos = _lerp(
      _TransitionParticleV7WidgetState._stableChaos,
      _TransitionParticleV7WidgetState._warnChaos,
      t,
    );

    final speedMult = _lerp(
      _TransitionParticleV7WidgetState._stableSpeedMult,
      _TransitionParticleV7WidgetState._warnSpeedMult,
      t,
    );

    final glowR = _lerp(size.width * 0.28, size.width * 0.35, t);

    // Мягкое свечение вокруг центра
    canvas.drawCircle(
      center,
      glowR,
      Paint()
        ..shader = RadialGradient(
          colors: [
            color.withValues(alpha: _lerp(0.12, 0.20, t)),
            color.withValues(alpha: _lerp(0.04, 0.07, t)),
            Colors.transparent,
          ],
        ).createShader(
          Rect.fromCircle(
            center: center,
            radius: glowR,
          ),
        ),
    );

    // Частицы
    for (final p in particles) {
      p.angle += p.baseSpeed * speedMult;
      p.wobble += p.wobbleSpeed;

      final baseRad = spreadMin + p.normRad * (spreadMax - spreadMin);

      final rad = max(
        0.1,
        baseRad + sin(p.wobble) * chaos * p.wobbleNorm,
      );

      final px = cx + cos(p.angle) * rad;
      final py = cy + sin(p.angle) * rad;

      canvas.drawCircle(
        Offset(px, py),
        max(0.1, p.size),
        Paint()..color = color.withValues(alpha: p.opacity),
      );
    }

    // Ядро
    final coreLayers = [
      _CoreLayer(
        radius: _lerp(26, 30, t),
        alpha: _lerp(0.07, 0.10, t),
      ),
      _CoreLayer(
        radius: _lerp(14, 16, t),
        alpha: _lerp(0.22, 0.28, t),
      ),
      const _CoreLayer(
        radius: 9.0,
        alpha: 0.72,
      ),
      const _CoreLayer(
        radius: 4.0,
        alpha: 1.00,
      ),
    ];

    for (final layer in coreLayers) {
      final r = max(0.1, layer.radius);

      canvas.drawCircle(
        center,
        r,
        Paint()
          ..shader = RadialGradient(
            colors: [
              Colors.white.withValues(alpha: layer.alpha),
              color.withValues(alpha: layer.alpha),
              Colors.transparent,
            ],
            stops: const [0, 0.4, 1],
          ).createShader(
            Rect.fromCircle(
              center: center,
              radius: r,
            ),
          ),
      );
    }
  }

  @override
  bool shouldRepaint(_V7Painter oldDelegate) => true;
}

class _Particle {
  double angle;
  final double normRad;
  final double baseSpeed;
  double wobble;
  final double wobbleSpeed;
  final double wobbleNorm;
  final double size;
  final double opacity;

  _Particle({
    required this.angle,
    required this.normRad,
    required this.baseSpeed,
    required this.wobble,
    required this.wobbleSpeed,
    required this.wobbleNorm,
    required this.size,
    required this.opacity,
  });
}
