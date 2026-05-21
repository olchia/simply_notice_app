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

enum _State { empty, stable, warning, low }

_State _stateFromIndex(double index) {
  if (index < 0) return _State.empty;
  if (index >= 0.70) return _State.stable;
  if (index >= 0.40) return _State.warning;
  return _State.low;
}

const _colors = {
  _State.empty: Color(0xFF5EECD4),
  _State.stable: Color(0xFF5EECD4),
  _State.warning: Color(0xFFFBBF24),
  _State.low: Color(0xFFF87171),
};

class _Config {
  final int count;
  final double spreadMin;
  final double spreadMax;
  final double chaos;
  final double speedMult;

  const _Config({
    required this.count,
    required this.spreadMin,
    required this.spreadMax,
    required this.chaos,
    required this.speedMult,
  });
}

const _configs = {
  _State.empty: _Config(
    count: 24,
    spreadMin: 40,
    spreadMax: 110,
    chaos: 0.25,
    speedMult: 1.00,
  ),
  _State.stable: _Config(
    count: 90,
    spreadMin: 26,
    spreadMax: 80,
    chaos: 0.35,
    speedMult: 1.00,
  ),
  _State.warning: _Config(
    count: 85,
    spreadMin: 28,
    spreadMax: 100,
    chaos: 0.75,
    speedMult: 1.00,
  ),
  _State.low: _Config(
    count: 80,
    spreadMin: 32,
    spreadMax: 118,
    chaos: 1.50,
    speedMult: 1.00,
  ),
};

class StateParticleV6Widget extends StatefulWidget {
  const StateParticleV6Widget({
    super.key,
    this.width,
    this.height,
    required this.index,
  });

  final double? width;
  final double? height;
  final double index;

  @override
  State<StateParticleV6Widget> createState() => _StateParticleV6State();
}

class _StateParticleV6State extends State<StateParticleV6Widget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late _State _state;
  late List<_Particle> _particles;
  final Random _rng = Random();

  @override
  void initState() {
    super.initState();

    _state = _stateFromIndex(widget.index);
    _spawn();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(days: 1),
    )..repeat();
  }

  @override
  void didUpdateWidget(StateParticleV6Widget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.index != widget.index) {
      _state = _stateFromIndex(widget.index);
      _spawn();
    }
  }

  void _spawn() {
    final cfg = _configs[_state]!;

    _particles = List.generate(cfg.count, (_) {
      final w = pow(_rng.nextDouble(), 1.5).toDouble();

      return _Particle(
        angle: _rng.nextDouble() * 2 * pi,
        baseRad: cfg.spreadMin + w * (cfg.spreadMax - cfg.spreadMin),
        orbitSpeed: (0.0008 + _rng.nextDouble() * 0.0022) *
            cfg.speedMult *
            (_rng.nextBool() ? 1 : -1),
        wobble: _rng.nextDouble() * 2 * pi,
        wobbleSpeed: 0.010 + _rng.nextDouble() * 0.015,
        wobbleAmp: cfg.chaos * (0.40 + _rng.nextDouble() * 0.80),
        size: _state == _State.empty
            ? 0.9 + _rng.nextDouble() * 2.1
            : 0.8 + _rng.nextDouble() * 2.4,
        opacity: _state == _State.empty
            ? 0.18 + _rng.nextDouble() * 0.38
            : 0.38 + _rng.nextDouble() * 0.62,
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
    final color = _colors[_state]!;

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, __) {
          if (_state == _State.empty) {
            return CustomPaint(
              painter: _EmptyOrbitPainter(
                particles: _particles,
                color: color,
              ),
              child: const SizedBox.expand(),
            );
          }

          return CustomPaint(
            painter: _V6Painter(
              particles: _particles,
              color: color,
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

class _V6Painter extends CustomPainter {
  final List<_Particle> particles;
  final Color color;

  _V6Painter({
    required this.particles,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height * 0.48;
    final center = Offset(cx, cy);

    final glowR = size.width * 0.30;

    canvas.drawCircle(
      center,
      glowR,
      Paint()
        ..shader = RadialGradient(
          colors: [
            color.withOpacity(0.14),
            color.withOpacity(0.04),
            Colors.transparent,
          ],
        ).createShader(
          Rect.fromCircle(
            center: center,
            radius: glowR,
          ),
        ),
    );

    for (final p in particles) {
      p.angle += p.orbitSpeed;
      p.wobble += p.wobbleSpeed;

      final r = max(0.1, p.baseRad + sin(p.wobble) * p.wobbleAmp);
      final px = cx + cos(p.angle) * r;
      final py = cy + sin(p.angle) * r;

      canvas.drawCircle(
        Offset(px, py),
        max(0.1, p.size),
        Paint()..color = color.withOpacity(p.opacity),
      );
    }

    const coreLayers = [
      _CoreLayer(radius: 26.0, alpha: 0.07),
      _CoreLayer(radius: 14.0, alpha: 0.22),
      _CoreLayer(radius: 9.0, alpha: 0.72),
      _CoreLayer(radius: 4.0, alpha: 1.00),
    ];

    for (final layer in coreLayers) {
      final r = max(0.1, layer.radius);

      canvas.drawCircle(
        center,
        r,
        Paint()
          ..shader = RadialGradient(
            colors: [
              Colors.white.withOpacity(layer.alpha),
              color.withOpacity(layer.alpha),
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
  bool shouldRepaint(_V6Painter oldDelegate) => true;
}

class _EmptyOrbitPainter extends CustomPainter {
  final List<_Particle> particles;
  final Color color;

  _EmptyOrbitPainter({
    required this.particles,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFF0B0F1A),
    );
    final cx = size.width / 2;
    final cy = size.height * 0.54;
    final center = Offset(cx, cy);

    final orbitWidth = size.width * 0.52;
    final orbitHeight = size.height * 0.28;

    final outerOrbitWidth = size.width * 0.66;
    final outerOrbitHeight = size.height * 0.38;

    final glowR = size.width * 0.34;

    canvas.drawCircle(
      center,
      glowR,
      Paint()
        ..shader = RadialGradient(
          colors: [
            color.withOpacity(0.13),
            color.withOpacity(0.045),
            Colors.transparent,
          ],
          stops: const [0.0, 0.45, 1.0],
        ).createShader(
          Rect.fromCircle(
            center: center,
            radius: glowR,
          ),
        ),
    );

    final innerOrbitRect = Rect.fromCenter(
      center: center,
      width: orbitWidth,
      height: orbitHeight,
    );

    canvas.drawOval(
      innerOrbitRect,
      Paint()
        ..color = color.withOpacity(0.22)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.3,
    );

    final outerOrbitRect = Rect.fromCenter(
      center: center,
      width: outerOrbitWidth,
      height: outerOrbitHeight,
    );

    _drawDashedOval(
      canvas: canvas,
      rect: outerOrbitRect,
      paint: Paint()
        ..color = color.withOpacity(0.13)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.1,
      dashCount: 54,
      dashRatio: 0.44,
    );

    for (int i = 0; i < particles.length; i++) {
      final p = particles[i];

      p.angle += p.orbitSpeed;
      p.wobble += p.wobbleSpeed;

      final isOuter = i.isEven;

      final rx = (isOuter ? outerOrbitWidth : orbitWidth) / 2;
      final ry = (isOuter ? outerOrbitHeight : orbitHeight) / 2;

      final wobbleOffset = sin(p.wobble) * p.wobbleAmp;

      final px = cx + cos(p.angle) * (rx + wobbleOffset);
      final py = cy + sin(p.angle) * (ry + wobbleOffset * 0.35);

      canvas.drawCircle(
        Offset(px, py),
        max(0.1, p.size),
        Paint()..color = color.withOpacity(p.opacity),
      );
    }

    final quietDots = [
      Offset(cx - size.width * 0.30, cy - size.height * 0.24),
      Offset(cx + size.width * 0.31, cy - size.height * 0.22),
      Offset(cx - size.width * 0.35, cy + size.height * 0.16),
      Offset(cx + size.width * 0.26, cy + size.height * 0.18),
      Offset(cx - size.width * 0.12, cy - size.height * 0.31),
      Offset(cx + size.width * 0.10, cy - size.height * 0.33),
    ];

    for (final dot in quietDots) {
      canvas.drawCircle(
        dot,
        1.2,
        Paint()..color = color.withOpacity(0.24),
      );
    }

    const coreLayers = [
      _CoreLayer(radius: 24.0, alpha: 0.08),
      _CoreLayer(radius: 13.0, alpha: 0.18),
      _CoreLayer(radius: 7.0, alpha: 0.45),
      _CoreLayer(radius: 3.4, alpha: 0.95),
    ];

    for (final layer in coreLayers) {
      canvas.drawCircle(
        center,
        layer.radius,
        Paint()
          ..shader = RadialGradient(
            colors: [
              Colors.white.withOpacity(layer.alpha),
              color.withOpacity(layer.alpha),
              Colors.transparent,
            ],
            stops: const [0.0, 0.45, 1.0],
          ).createShader(
            Rect.fromCircle(
              center: center,
              radius: layer.radius,
            ),
          ),
      );
    }
  }

  void _drawDashedOval({
    required Canvas canvas,
    required Rect rect,
    required Paint paint,
    required int dashCount,
    required double dashRatio,
  }) {
    final path = Path()..addOval(rect);
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      final dashLength = metric.length / dashCount;
      final visibleLength = dashLength * dashRatio;

      for (double distance = 0;
          distance < metric.length;
          distance += dashLength) {
        final extractPath = metric.extractPath(
          distance,
          min(distance + visibleLength, metric.length),
        );

        canvas.drawPath(extractPath, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_EmptyOrbitPainter oldDelegate) => true;
}

class _Particle {
  double angle;
  final double baseRad;
  final double orbitSpeed;
  double wobble;
  final double wobbleSpeed;
  final double wobbleAmp;
  final double size;
  final double opacity;

  _Particle({
    required this.angle,
    required this.baseRad,
    required this.orbitSpeed,
    required this.wobble,
    required this.wobbleSpeed,
    required this.wobbleAmp,
    required this.size,
    required this.opacity,
  });
}
