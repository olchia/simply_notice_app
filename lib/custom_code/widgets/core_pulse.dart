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
import 'dart:ui' as ui;
import 'package:flutter/scheduler.dart';

/// CorePulse — анимация частиц вокруг ядра.
///
/// Фон виджета прозрачный — виджет можно ставить на любой фон (тёмный экран,
/// градиент, изображение). Атмосферная дымка укладывается внутри виджета и
/// плавно растворяется до прозрачности раньше, чем достигнет края — границы
/// виджета не видны.
///
/// [state]: 0.0 = стабильно, 0.5 = внимание, 1.0 = критично. Значения между
/// интерполируются плавно.
///
/// [transitionDuration]: длительность плавного перехода при изменении state,
/// в миллисекундах.
class CorePulse extends StatefulWidget {
  const CorePulse({
    super.key,
    this.width,
    this.height,
    this.state = 0.0,
    this.transitionDuration = 1200,
  });

  final double? width;
  final double? height;
  final double state;
  final int transitionDuration;

  @override
  State<CorePulse> createState() => _CorePulseState();
}

class _CorePulseState extends State<CorePulse> with TickerProviderStateMixin {
  late final Ticker _ticker;
  late final AnimationController _transitionController;
  late Animation<double> _stateAnimation;

  double _currentState = 0.0;
  double _previousTarget = 0.0;
  double _elapsedSeconds = 0.0;
  Duration _lastElapsed = Duration.zero;

  late final List<_NebulaDot> _nebulaDots;
  late final List<_Particle> _particles;

  static const int _nebulaCount = 45;
  static const int _particleCount = 110;

  @override
  void initState() {
    super.initState();
    _currentState = widget.state.clamp(0.0, 1.0);
    _previousTarget = _currentState;

    _transitionController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.transitionDuration),
    );
    _stateAnimation = AlwaysStoppedAnimation<double>(_currentState);

    _nebulaDots = _createNebula();
    _particles = _createParticles();

    _ticker = createTicker(_onTick)..start();
  }

  @override
  void didUpdateWidget(covariant CorePulse oldWidget) {
    super.didUpdateWidget(oldWidget);
    final target = widget.state.clamp(0.0, 1.0);
    if ((target - _previousTarget).abs() > 0.001) {
      _stateAnimation = Tween<double>(
        begin: _currentState,
        end: target,
      ).animate(CurvedAnimation(
        parent: _transitionController,
        curve: Curves.easeInOutCubic,
      ));
      _transitionController
        ..reset()
        ..forward();
      _previousTarget = target;
    }
  }

  void _onTick(Duration elapsed) {
    final dtMicros = (elapsed - _lastElapsed).inMicroseconds;
    _lastElapsed = elapsed;
    final dt = (dtMicros / 1e6).clamp(0.0, 0.05);
    _elapsedSeconds += dt;

    _currentState = _stateAnimation.value;

    final eased = _easeInOut(_currentState);
    for (final p in _particles) {
      final speed = _lerp(p.speedStable, p.speedCritical, eased);
      p.angle += speed * dt;
      p.pulsePhase += p.pulseSpeed * dt;
    }
    for (final d in _nebulaDots) {
      d.angle += d.angleSpeed * dt;
      d.radiusPhase += d.radiusSpeed * dt;
    }

    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _ticker.dispose();
    _transitionController.dispose();
    super.dispose();
  }

  List<_NebulaDot> _createNebula() {
    final rnd = math.Random(42);
    final list = <_NebulaDot>[];
    for (int i = 0; i < _nebulaCount; i++) {
      final r2 = rnd.nextDouble();
      double visThreshold;
      if (r2 < 0.18) {
        visThreshold = 1.0;
      } else if (r2 < 0.55) {
        visThreshold = 0.7;
      } else {
        visThreshold = 0.4;
      }
      list.add(_NebulaDot(
        angle: rnd.nextDouble() * math.pi * 2,
        radius: rnd.nextDouble() * 0.09,
        angleSpeed: (rnd.nextDouble() - 0.5) * 0.6,
        radiusPhase: rnd.nextDouble() * math.pi * 2,
        radiusSpeed: 0.8 + rnd.nextDouble() * 1.2,
        size: 0.6 + rnd.nextDouble() * 1.1,
        brightness: 0.7 + rnd.nextDouble() * 0.3,
        visibilityThreshold: visThreshold,
      ));
    }
    return list;
  }

  List<_Particle> _createParticles() {
    final rnd = math.Random(17);
    final list = <_Particle>[];
    for (int i = 0; i < _particleCount; i++) {
      final dir = rnd.nextBool() ? 1.0 : -1.0;
      final r = rnd.nextDouble();

      _Role role;
      if (r < 0.5) {
        role = _Role.inner;
      } else if (r < 0.88) {
        role = _Role.orbit;
      } else {
        role = _Role.free;
      }

      double rStable, rAttention, rCritical;
      final t = rnd.nextDouble();
      switch (role) {
        case _Role.inner:
          rStable = 0.10 + t * 0.15;
          rAttention = 0.18 + t * 0.22;
          rCritical = 0.35 + t * 0.35;
          break;
        case _Role.orbit:
          rStable = 0.26 + t * 0.18;
          rAttention = 0.42 + t * 0.28;
          rCritical = 0.65 + t * 0.35;
          break;
        case _Role.free:
          rStable = 0.48 + t * 0.22;
          rAttention = 0.65 + t * 0.30;
          rCritical = 0.85 + t * 0.25;
          break;
      }

      double visibilityThreshold;
      final r2 = rnd.nextDouble();
      switch (role) {
        case _Role.inner:
          if (r2 < 0.15) {
            visibilityThreshold = 1.0;
          } else if (r2 < 0.5) {
            visibilityThreshold = 0.7;
          } else {
            visibilityThreshold = 0.4;
          }
          break;
        case _Role.orbit:
          if (r2 < 0.4) {
            visibilityThreshold = 1.0;
          } else if (r2 < 0.75) {
            visibilityThreshold = 0.85;
          } else {
            visibilityThreshold = 0.55;
          }
          break;
        case _Role.free:
          if (r2 < 0.5) {
            visibilityThreshold = 1.0;
          } else {
            visibilityThreshold = 0.8;
          }
          break;
      }

      final roleMul = role == _Role.inner
          ? 1.3
          : role == _Role.orbit
              ? 0.85
              : 0.5;
      final roleMulCrit = role == _Role.inner
          ? 1.0
          : role == _Role.orbit
              ? 0.65
              : 0.35;

      final size = role == _Role.inner
          ? 1.3 + rnd.nextDouble() * 1.2
          : role == _Role.orbit
              ? 1.7 + rnd.nextDouble() * 1.6
              : 1.5 + rnd.nextDouble() * 1.3;

      final brightness = role == _Role.free
          ? 0.55 + rnd.nextDouble() * 0.35
          : 0.75 + rnd.nextDouble() * 0.25;

      list.add(_Particle(
        angle: rnd.nextDouble() * math.pi * 2,
        rStable: rStable,
        rAttention: rAttention,
        rCritical: rCritical,
        speedStable: (0.15 + rnd.nextDouble() * 0.06) * dir * roleMul,
        speedCritical: (0.04 + rnd.nextDouble() * 0.28) * dir * roleMulCrit,
        pulsePhase: rnd.nextDouble() * math.pi * 2,
        pulseSpeed: 0.3 + rnd.nextDouble() * 0.8,
        size: size,
        brightness: brightness,
        role: role,
        visibilityThreshold: visibilityThreshold,
        noiseOffset: rnd.nextDouble() * 1000,
        noiseOffset2: rnd.nextDouble() * 1000,
        noiseOffset3: rnd.nextDouble() * 1000,
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: CustomPaint(
        painter: _CorePulsePainter(
          state: _currentState,
          time: _elapsedSeconds,
          nebulaDots: _nebulaDots,
          particles: _particles,
        ),
        size: Size.infinite,
      ),
    );
  }

  static double _lerp(double a, double b, double t) => a + (b - a) * t;
  static double _easeInOut(double t) {
    if (t < 0.5) return 2 * t * t;
    return 1.0 - math.pow(-2 * t + 2, 2).toDouble() / 2.0;
  }
}

enum _Role { inner, orbit, free }

class _NebulaDot {
  double angle;
  double radius;
  final double angleSpeed;
  double radiusPhase;
  final double radiusSpeed;
  final double size;
  final double brightness;
  final double visibilityThreshold;

  _NebulaDot({
    required this.angle,
    required this.radius,
    required this.angleSpeed,
    required this.radiusPhase,
    required this.radiusSpeed,
    required this.size,
    required this.brightness,
    required this.visibilityThreshold,
  });
}

class _Particle {
  double angle;
  final double rStable;
  final double rAttention;
  final double rCritical;
  final double speedStable;
  final double speedCritical;
  double pulsePhase;
  final double pulseSpeed;
  final double size;
  final double brightness;
  final _Role role;
  final double visibilityThreshold;
  final double noiseOffset;
  final double noiseOffset2;
  final double noiseOffset3;

  double renderX = 0.0;
  double renderY = 0.0;
  double renderR = 0.0;
  double renderAlpha = 0.0;
  double renderSize = 0.0;
  double renderDistNorm = 0.0;
  double renderVis = 0.0;
  Color renderColor = const Color(0xFFFFFFFF);

  _Particle({
    required this.angle,
    required this.rStable,
    required this.rAttention,
    required this.rCritical,
    required this.speedStable,
    required this.speedCritical,
    required this.pulsePhase,
    required this.pulseSpeed,
    required this.size,
    required this.brightness,
    required this.role,
    required this.visibilityThreshold,
    required this.noiseOffset,
    required this.noiseOffset2,
    required this.noiseOffset3,
  });
}

class _Palette {
  final Color atmosphere;
  final Color coreCloud;
  final Color particleClose;
  final Color particleFar;

  const _Palette({
    required this.atmosphere,
    required this.coreCloud,
    required this.particleClose,
    required this.particleFar,
  });

  static Color mix(Color a, Color b, double t) {
    return Color.from(
      alpha: a.a + (b.a - a.a) * t,
      red: a.r + (b.r - a.r) * t,
      green: a.g + (b.g - a.g) * t,
      blue: a.b + (b.b - a.b) * t,
    );
  }

  static _Palette lerp(_Palette a, _Palette b, double t) {
    return _Palette(
      atmosphere: mix(a.atmosphere, b.atmosphere, t),
      coreCloud: mix(a.coreCloud, b.coreCloud, t),
      particleClose: mix(a.particleClose, b.particleClose, t),
      particleFar: mix(a.particleFar, b.particleFar, t),
    );
  }
}

class _CorePulsePainter extends CustomPainter {
  _CorePulsePainter({
    required this.state,
    required this.time,
    required this.nebulaDots,
    required this.particles,
  });

  final double state;
  final double time;
  final List<_NebulaDot> nebulaDots;
  final List<_Particle> particles;

  static const _stable = _Palette(
    atmosphere: Color(0xFF5ADCC8),
    coreCloud: Color(0xFF96F0E1),
    particleClose: Color(0xFFEBFFF8),
    particleFar: Color(0xFF5FD7C8),
  );
  static const _attention = _Palette(
    atmosphere: Color(0xFFDCB482),
    coreCloud: Color(0xFFF0D7AA),
    particleClose: Color(0xFFFCF0DC),
    particleFar: Color(0xFFDCAF7D),
  );
  static const _critical = _Palette(
    atmosphere: Color(0xFFD26E69),
    coreCloud: Color(0xFFEBA096),
    particleClose: Color(0xFFFADCD7),
    particleFar: Color(0xFFD26964),
  );

  _Palette _paletteFor(double s) {
    if (s < 0.5) {
      return _Palette.lerp(_stable, _attention, s / 0.5);
    }
    return _Palette.lerp(_attention, _critical, (s - 0.5) / 0.5);
  }

  double _lerp(double a, double b, double t) => a + (b - a) * t;
  double _easeInOut(double t) {
    if (t < 0.5) return 2 * t * t;
    return 1.0 - math.pow(-2 * t + 2, 2).toDouble() / 2.0;
  }

  double _radiusAt(_Particle p, double s) {
    if (s < 0.5) {
      return _lerp(p.rStable, p.rAttention, s / 0.5);
    }
    return _lerp(p.rAttention, p.rCritical, (s - 0.5) / 0.5);
  }

  double _visibility(double threshold, double s) {
    if (threshold >= 0.99) return 1.0;
    final fadeStart = math.max(0.0, threshold - 0.18);
    final fadeEnd = threshold;
    if (s <= fadeStart) return 1.0;
    if (s >= fadeEnd) return 0.0;
    return 1.0 - (s - fadeStart) / (fadeEnd - fadeStart);
  }

  Color _withOp(Color c, double a) {
    return c.withValues(alpha: a.clamp(0.0, 1.0));
  }

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w / 2;
    final cy = h / 2;
    // maxR — базовая шкала для орбит частиц.
    // Важно: это НЕ радиус дымки. Дымка теперь считается отдельно.
    final maxR = math.min(w, h) * 0.68;

    // atmoRadius — радиус атмосферной дымки. Делаем его МЕНЬШЕ
    // половины минимальной стороны, чтобы дымка успевала раствориться
    // в прозрачность до того, как упрётся в край виджета.
    // 0.42 = чуть меньше 50%. К краю идёт уверенный нуль.
    final atmoRadius = math.min(w, h) * 0.42;

    final s = state.clamp(0.0, 1.0);
    final eased = _easeInOut(s);
    final pal = _paletteFor(s);

    final coreIntensity = _lerp(1.0, 0.35, eased);

    // Атмосферная дымка — теперь строго внутри виджета
    final atmoAlpha = _lerp(0.30, 0.08, eased);
    final atmoShader = ui.Gradient.radial(
      Offset(cx, cy),
      atmoRadius,
      [
        _withOp(pal.atmosphere, atmoAlpha),
        _withOp(pal.atmosphere, atmoAlpha * 0.4),
        _withOp(pal.atmosphere, atmoAlpha * 0.1),
        _withOp(pal.atmosphere, 0.0),
      ],
      // Последняя точка — полная прозрачность ДО достижения края.
      // 0.85 вместо 1.0 означает, что последние 15% радиуса — гарантированно 0 альфа.
      [0.0, 0.35, 0.7, 0.95],
    );
    // Рисуем круг вместо прямоугольника — так дымка не может
    // обрезаться по прямоугольным границам виджета.
    canvas.drawCircle(
      Offset(cx, cy),
      atmoRadius,
      Paint()..shader = atmoShader,
    );

    // Облако вокруг ядра
    final cloudAlpha = _lerp(0.55, 0.15, eased);
    final cloudRadius = maxR * _lerp(0.32, 0.18, eased);
    final cloudShader = ui.Gradient.radial(
      Offset(cx, cy),
      cloudRadius,
      [
        _withOp(pal.coreCloud, cloudAlpha * coreIntensity),
        _withOp(pal.coreCloud, cloudAlpha * 0.5 * coreIntensity),
        _withOp(pal.coreCloud, cloudAlpha * 0.15 * coreIntensity),
        _withOp(pal.coreCloud, 0.0),
      ],
      [0.0, 0.3, 0.7, 1.0],
    );
    canvas.drawCircle(
      Offset(cx, cy),
      cloudRadius,
      Paint()..shader = cloudShader,
    );

    // Туманность из ярких точек (additive)
    final nebulaPaint = Paint()..blendMode = BlendMode.plus;
    for (final d in nebulaDots) {
      final vis = _visibility(d.visibilityThreshold, s);
      if (vis <= 0.01) continue;

      final r = (d.radius + math.sin(d.radiusPhase) * 0.01) *
          maxR *
          _lerp(1.0, 1.4, eased);
      final x = cx + math.cos(d.angle) * r;
      final y = cy + math.sin(d.angle) * r;
      final alpha = d.brightness *
          coreIntensity *
          (0.7 + math.sin(d.radiusPhase * 0.7) * 0.3) *
          vis;
      final sz = d.size * (1 + math.sin(d.radiusPhase) * 0.2);

      nebulaPaint.shader = ui.Gradient.radial(
        Offset(x, y),
        sz * 5,
        [
          _withOp(pal.particleClose, alpha * 0.9),
          _withOp(pal.particleClose, alpha * 0.3),
          _withOp(pal.particleClose, 0.0),
        ],
        [0.0, 0.4, 1.0],
      );
      canvas.drawCircle(Offset(x, y), sz * 5, nebulaPaint);

      nebulaPaint.shader = null;
      nebulaPaint.color = _withOp(pal.particleClose, alpha);
      canvas.drawCircle(Offset(x, y), sz, nebulaPaint);
    }

    // Считаем позиции орбитальных частиц
    final now = time * 1000;
    for (final p in particles) {
      final vis = _visibility(p.visibilityThreshold, s);
      p.renderVis = vis;
      if (vis <= 0.01) continue;

      final baseR = _radiusAt(p, s) * maxR;
      final breatheAmp =
          _lerp(1.2, 5.0, eased) + (p.role == _Role.free ? 1.5 : 0.8);
      final breathe = math.sin(p.pulsePhase) * breatheAmp;
      final driftAmp =
          _lerp(0.3, 4.5, eased) * (p.role == _Role.free ? 1.3 : 1.0);
      final drift = math.sin(now * 0.00035 + p.noiseOffset) * driftAmp;
      final tangential =
          math.cos(now * 0.00028 + p.noiseOffset2) * eased * 0.03;
      final wobble = math.sin(now * 0.0005 + p.noiseOffset3) * 1.5;

      final r = baseR + breathe + drift + wobble;
      final ang = p.angle + tangential;
      p.renderX = cx + math.cos(ang) * r;
      p.renderY = cy + math.sin(ang) * r;
      p.renderR = r;

      final distNorm = math.min(r / maxR, 1.0);
      final colorMix = ((distNorm - 0.15) / 0.35).clamp(0.0, 1.0);
      p.renderColor =
          _Palette.mix(pal.particleClose, pal.particleFar, colorMix);
      final distBrightness = 0.75 + distNorm * 0.25;
      p.renderAlpha =
          p.brightness * distBrightness * _lerp(1.0, 0.75, eased) * vis;
      p.renderSize = p.size * (1 + math.sin(p.pulsePhase * 0.8) * 0.15);
      p.renderDistNorm = distNorm;
    }

    // Гало для ближних частиц (additive)
    final haloPaint = Paint()..blendMode = BlendMode.plus;
    for (final p in particles) {
      if (p.renderVis <= 0.01 || p.renderDistNorm > 0.35) continue;

      final haloStrength = 1 - math.min(1.0, p.renderDistNorm / 0.35);
      final haloSize = p.renderSize * (2.5 + haloStrength * 2);

      haloPaint.shader = ui.Gradient.radial(
        Offset(p.renderX, p.renderY),
        haloSize,
        [
          _withOp(p.renderColor, p.renderAlpha * 0.5 * haloStrength),
          _withOp(p.renderColor, p.renderAlpha * 0.2 * haloStrength),
          _withOp(p.renderColor, 0.0),
        ],
        [0.0, 0.5, 1.0],
      );
      canvas.drawCircle(Offset(p.renderX, p.renderY), haloSize, haloPaint);
    }

    // Тела частиц (обычный blending)
    final bodyPaint = Paint();
    for (final p in particles) {
      if (p.renderVis <= 0.01) continue;
      final dist = p.renderDistNorm;
      final color = p.renderColor;
      final alpha = p.renderAlpha;
      final sz = p.renderSize;
      final center = Offset(p.renderX, p.renderY);

      if (dist < 0.25) {
        final softSize = sz * 1.8;
        bodyPaint.shader = ui.Gradient.radial(
          center,
          softSize,
          [
            _withOp(color, alpha * 0.7),
            _withOp(color, alpha * 0.4),
            _withOp(color, 0.0),
          ],
          [0.0, 0.4, 1.0],
        );
        canvas.drawCircle(center, softSize, bodyPaint);
      } else if (dist < 0.45) {
        final midSize = sz * 1.3;
        bodyPaint.shader = ui.Gradient.radial(
          center,
          midSize,
          [
            _withOp(color, alpha * 0.95),
            _withOp(color, alpha * 0.75),
            _withOp(color, 0.0),
          ],
          [0.0, 0.55, 1.0],
        );
        canvas.drawCircle(center, midSize, bodyPaint);
      } else {
        final edge = sz + 0.6;
        bodyPaint.shader = ui.Gradient.radial(
          center,
          edge,
          [
            _withOp(color, alpha),
            _withOp(color, alpha),
            _withOp(color, 0.0),
          ],
          [0.0, 0.88, 1.0],
        );
        canvas.drawCircle(center, edge, bodyPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _CorePulsePainter oldDelegate) => true;
}
