import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

int calcSleepMinutes(
  int sleepHours,
  int sleepMinutes,
) {
  return sleepHours * 60 + sleepMinutes;
}

double calcAverageIntList(List<int> values) {
  if (values.isEmpty) {
    return 0.0;
  }

  final sum = values.reduce((a, b) => a + b);
  return sum / values.length;
}

double calcSleepDeviation(
  int sleepDurationMinutes,
  double sleepBaseline,
) {
  return sleepDurationMinutes - sleepBaseline;
}

double calcSleepZoneScore(int sleepDurationMinutes) {
  if (sleepDurationMinutes >= 420 && sleepDurationMinutes <= 540) {
    return 1.0;
  } else if (sleepDurationMinutes >= 360 && sleepDurationMinutes < 420) {
    return 0.5;
  } else {
    return 0.0;
  }
}

double calcSleepDeviationScore(
  double sleepDurationMinutes,
  double sleepBaseline,
) {
  if (sleepBaseline <= 0) {
    return 0.0;
  }

  if (sleepDurationMinutes >= sleepBaseline) {
    return 1.0;
  } else {
    return sleepDurationMinutes / sleepBaseline;
  }
}

double calcAverageTwoDoubles(
  double a,
  double b,
) {
  return (a + b) / 2;
}

double calcPositiveDeviationScore(double deviation) {
  if (deviation > 0) {
    return 1.0;
  } else if (deviation == 0) {
    return 0.5;
  } else {
    return 0.0;
  }
}

DateTime getStartOfDay(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, dateTime.day);
}

int roundDoubleToInt(double value) {
  final int lower = value.floor();
  final double decimalPart = value - lower;

  if (decimalPart >= 0.5) {
    return lower + 1;
  }

  return lower;
}

double calcIntDeviation(
  int currentValue,
  double baseline,
) {
  return currentValue - baseline;
}

double calcPositiveRatioScore(
  int currentValue,
  double baseline,
) {
  if (baseline <= 0) {
    return 0.0;
  }

  if (currentValue >= baseline) {
    return 1.0;
  } else {
    return currentValue / baseline;
  }
}

double calcNegativeRatioScore(
  int currentValue,
  double baseline,
) {
  if (baseline <= 0) {
    return 0.0;
  }

  if (currentValue <= baseline) {
    return 1.0;
  } else {
    return baseline / currentValue;
  }
}

double calcAverageThreeDoubles(
  double a,
  double b,
  double c,
) {
  return (a + b + c) / 3;
}

String calcStateZone(double overallScore) {
  if (overallScore >= 0.7) {
    return 'good';
  } else if (overallScore >= 0.4) {
    return 'warning';
  } else {
    return 'bad';
  }
}

double getSleepBarHeight(
  double valueMinutes,
  bool hasData,
) {
  const double minHeight = 24.0;
  const double maxHeight = 90.0;
  const double maxMinutes = 720.0; // 12 часов

// Если данных нет — оставляем видимый приглушенный столбик.
  if (hasData != true) {
    return 50.0;
  }

// Ограничиваем значение диапазоном 0–720 минут.
  final double clampedValue = valueMinutes.clamp(0.0, maxMinutes);

  return minHeight + (clampedValue / maxMinutes) * (maxHeight - minHeight);
}

double getStepsBarHeight(
  double? valueSteps,
  bool? hasData,
) {
  const double minHeight = 24.0;
  const double maxHeight = 90.0;
  const double maxSteps = 15000.0;

  if (hasData != true || valueSteps == null) {
    return 50.0;
  }

  final double steps = valueSteps.toDouble();
  final double clampedValue = steps.clamp(0.0, maxSteps);

  return minHeight + (clampedValue / maxSteps) * (maxHeight - minHeight);
}

double getScaleBarHeight(
  double? value,
  bool? hasData,
) {
  const double minHeight = 24.0;
  const double maxHeight = 90.0;
  const double minValue = 1.0;
  const double maxValue = 5.0;

  if (hasData != true || value == null) {
    return 70.0;
  }

  final double clampedValue = value.clamp(minValue, maxValue);

  return minHeight +
      ((clampedValue - minValue) / (maxValue - minValue)) *
          (maxHeight - minHeight);
}

String getMarkerStatusLabel(
  String markerType,
  int? currentValue,
  double? baselineValue,
) {
  const double lowerIsWorseBaselineThreshold = 3.0;
  const double higherIsBetterBaselineThreshold = 3.0;

  // Для нового пользователя или технических placeholder-документов.
  // Значения 0 не считаем реальными данными, потому что шкала маркеров — от 1 до 5.
  if (currentValue == null ||
      baselineValue == null ||
      currentValue <= 0 ||
      baselineValue <= 0) {
    return 'Недостаточно данных';
  }

  final String type = markerType.toLowerCase().trim();
  final double current = currentValue.toDouble();

  // Округляем baseline для сравнения с текущим значением,
  // чтобы статус совпадал с тем, что пользователь видит на экране.
  // Например: baseline = 3.24 отображается как 3,
  // и current = 3 не должен считаться ниже/выше нормы.
  final double baselineRounded = baselineValue.round().toDouble();

  // Маркеры, где больше = хуже.
  final bool lowerIsBetter = type == 'stress' || type == 'exhaustion';

  // Маркеры, где больше = лучше.
  final bool higherIsBetter =
      type == 'energy' || type == 'social_support' || type == 'social';

  // ===============================
  // STRESS / EXHAUSTION
  // Больше = хуже
  // ===============================

  if (lowerIsBetter) {
    final bool currentIsHigh = current >= 4.0;
    final bool baselineIsUnfavorable =
        baselineValue >= lowerIsWorseBaselineThreshold;
    final bool currentIsWorseThanBaseline = current > baselineRounded;

    // 1. Сегодня показатель высокий И личная норма за 14 дней тоже повышенная.
    // Даже если current равен baseline, это всё равно неблагоприятный высокий фон.
    if (currentIsHigh && baselineIsUnfavorable) {
      if (type == 'exhaustion') {
        return 'Существенно повышено';
      }

      return 'Существенно повышен';
    }

    // 2. Сегодня показатель высокий, но личная норма ещё не повышенная.
    if (currentIsHigh && !baselineIsUnfavorable) {
      if (type == 'exhaustion') {
        return 'Заметно повышено';
      }

      return 'Заметно повышен';
    }

    // 3. Сегодня показатель выше личной нормы.
    if (currentIsWorseThanBaseline) {
      return 'Выше вашей нормы';
    }

    // 4. Сегодня показатель не выше личной нормы,
    // но сама личная норма за 14 дней уже повышенная.
    if (baselineIsUnfavorable) {
      return 'Личная норма повышена';
    }

    // 5. Всё ок.
    return 'В пределах нормы';
  }

  // ===============================
  // ENERGY / SOCIAL SUPPORT
  // Больше = лучше
  // ===============================

  if (higherIsBetter) {
    final bool currentIsLow = current <= 2.0;
    final bool baselineIsUnfavorable =
        baselineValue <= higherIsBetterBaselineThreshold;
    final bool currentIsWorseThanBaseline = current < baselineRounded;

    // 1. Сегодня показатель низкий И личная норма за 14 дней тоже сниженная.
    // Даже если current равен baseline, это всё равно сниженный фон.
    if (currentIsLow && baselineIsUnfavorable) {
      return 'Существенно снижена';
    }

    // 2. Сегодня показатель низкий, но личная норма ещё не сниженная.
    if (currentIsLow && !baselineIsUnfavorable) {
      return 'Заметно снижена';
    }

    // 3. Сегодня показатель ниже личной нормы.
    if (currentIsWorseThanBaseline) {
      return 'Ниже вашей нормы';
    }

    // 4. Сегодня показатель не ниже личной нормы,
    // но сама личная норма за 14 дней уже сниженная.
    if (baselineIsUnfavorable) {
      return 'Личная норма снижена';
    }

    // 5. Всё ок.
    return 'В пределах нормы';
  }

  return 'В пределах нормы';
}

String getSleepStatusLabel(
  int? currentSleepMinutes,
  int? baselineSleepMinutes,
) {
  const int veryLowSleepMinutes = 360; // 6 часов
  const int recommendedSleepMinutes = 420; // 7 часов

  // Для нового пользователя или технических placeholder-документов.
  // 0 минут сна и 0 минут baseline не считаем реальными данными.
  if (currentSleepMinutes == null ||
      baselineSleepMinutes == null ||
      currentSleepMinutes <= 0 ||
      baselineSleepMinutes <= 0) {
    return 'Недостаточно данных';
  }

  final int current = currentSleepMinutes;
  final int baseline = baselineSleepMinutes;

  final bool currentIsVeryLow = current < veryLowSleepMinutes;
  final bool baselineIsBelowRecommended = baseline < recommendedSleepMinutes;
  final bool currentIsBelowBaseline = current < baseline;

  // 1. Сегодня сон выраженно короткий,
  // личная норма тоже ниже рекомендуемой зоны,
  // и сегодня сон ниже даже этой сниженной нормы.
  if (currentIsVeryLow &&
      baselineIsBelowRecommended &&
      currentIsBelowBaseline) {
    return 'Продолжительность сна существенно снижена';
  }

  // 2. Сегодня сон выраженно короткий,
  // но при этом он НЕ ниже личной нормы.
  if (currentIsVeryLow &&
      baselineIsBelowRecommended &&
      !currentIsBelowBaseline) {
    return 'Норма продолжительности сна снижена';
  }

  // 3. Сегодня сон выраженно короткий,
  // но личная норма в целом находится в рекомендуемой зоне.
  if (currentIsVeryLow && !baselineIsBelowRecommended) {
    return 'Продолжительность сна снижена';
  }

  // 4. Сегодня сон ниже личной нормы,
  // и сама личная норма уже ниже рекомендуемой зоны.
  if (!currentIsVeryLow &&
      currentIsBelowBaseline &&
      baselineIsBelowRecommended) {
    return 'Продолжительность сна ниже сниженной нормы';
  }

  // 5. Сегодня сон ниже личной нормы,
  // но сама личная норма в рекомендуемой зоне.
  if (!currentIsVeryLow &&
      currentIsBelowBaseline &&
      !baselineIsBelowRecommended) {
    return 'Продолжительность сна ниже вашей нормы';
  }

  // 6. Сегодня сон не ниже личной нормы,
  // но обычная продолжительность сна за 14 дней снижена.
  if (!currentIsBelowBaseline && baselineIsBelowRecommended) {
    return 'Личная норма сна снижена';
  }

  // 7. Всё ок.
  return 'В пределах нормы';
}

String getStepsStatusLabel(
  int? currentSteps,
  double? baselineSteps,
) {
  const int lowActivityThreshold = 5000;

  // Для нового пользователя или технических placeholder-документов.
  // 0 шагов и 0 baseline не считаем реальными данными для интерпретации.
  if (currentSteps == null ||
      baselineSteps == null ||
      currentSteps <= 0 ||
      baselineSteps <= 0) {
    return 'Недостаточно данных';
  }

  final int current = currentSteps;
  final double baseline = baselineSteps;

  // Округляем baseline, чтобы не было ситуации:
  // на экране baseline выглядит как 3000,
  // а функция считает 3000 < 3000.42 и пишет "ниже нормы".
  final int baselineRounded = baseline.round();

  final bool currentIsLow = current < lowActivityThreshold;
  final bool baselineIsLow = baseline < lowActivityThreshold;
  final bool currentIsBelowBaseline = current < baselineRounded;

  // 1. Сегодня активность низкая, baseline тоже низкий,
  // и сегодня ниже даже этой сниженной нормы.
  if (currentIsLow && baselineIsLow && currentIsBelowBaseline) {
    return 'Активность существенно снижена';
  }

  // 2. Сегодня активность низкая, baseline тоже низкий,
  // но сегодня НЕ ниже личной нормы.
  if (currentIsLow && baselineIsLow && !currentIsBelowBaseline) {
    return 'Норма активности низкая';
  }

  // 3. Сегодня активность низкая,
  // но обычно активность не относится к низкой.
  if (currentIsLow && !baselineIsLow) {
    return 'Активность снижена';
  }

  // 4. Сегодня активность не низкая по абсолютному порогу,
  // но ниже личной нормы.
  if (!currentIsLow && currentIsBelowBaseline) {
    return 'Ниже вашей нормы';
  }

  // 5. Сегодня активность не ниже личной нормы,
  // но сама личная норма за 14 дней низкая.
  if (!currentIsLow && baselineIsLow) {
    return 'Личная норма активности низкая';
  }

  // 6. Всё ок.
  return 'В пределах нормы';
}

String? getSleepStatusInterpretation(String? sleepStatus) {
  if (sleepStatus == null || sleepStatus.trim().isEmpty) {
    return 'Пока недостаточно данных, чтобы сравнить текущий сон с вашей личной нормой. Когда данных станет больше, интерпретация будет точнее.';
  }

  final String status = sleepStatus.trim();

  if (status == 'Недостаточно данных') {
    return 'Пока недостаточно данных, чтобы сравнить текущий сон с вашей личной нормой. Когда данных станет больше, интерпретация будет точнее.';
  }

  if (status == 'Продолжительность сна существенно снижена') {
    return 'Сегодня длительность сна заметно ниже как вашей обычной продолжительности, так и уровня, который обычно поддерживает восстановление. Такой сигнал стоит учитывать, особенно если он повторяется.';
  }

  if (status == 'Личная норма сна снижена') {
    return 'Ваша обычная продолжительность сна сейчас ниже уровня, который обычно считается более благоприятным для восстановления. Даже если сегодня сон близок к вашей норме, организму может не хватать времени на отдых.';
  }

  if (status == 'Продолжительность сна снижена') {
    return 'Сегодня сон был заметно ниже уровня, который обычно поддерживает восстановление, хотя ваша личная норма в целом выглядит более устойчивой. Это может временно отразиться на энергии и самочувствии.';
  }

  if (status == 'Продолжительность сна ниже сниженной нормы') {
    return 'Сегодня сон был короче вашей обычной продолжительности, при этом сама личная норма сна сейчас находится ниже уровня, который требуется для восстановления. Это может быть признаком того, что ресурса на восстановление стало меньше.';
  }

  if (status == 'Продолжительность сна ниже вашей нормы') {
    return 'Сегодня сон был короче вашей личной нормы. Даже если снижение не выглядит выраженным, оно может быть заметным для восстановления.';
  }

  if (status == 'В пределах нормы') {
    return 'Сегодняшняя продолжительность сна выглядит стабильной относительно вашей личной нормы и не показывает выраженного снижения. По этому показателю заметного сигнала ухудшения нет.';
  }

  return 'Пока недостаточно данных, чтобы корректно интерпретировать этот показатель.';
}

String getStepsStatusInterpretation(String? stepsStatus) {
  if (stepsStatus == null || stepsStatus.trim().isEmpty) {
    return 'Пока недостаточно данных, чтобы сравнить сегодняшнюю активность с вашей личной нормой. Когда данных станет больше, интерпретация будет точнее.';
  }

  final String status = stepsStatus.trim();

  if (status == 'Недостаточно данных') {
    return 'Пока недостаточно данных, чтобы сравнить сегодняшнюю активность с вашей личной нормой. Когда данных станет больше, интерпретация будет точнее.';
  }

  if (status == 'Активность существенно снижена') {
    return 'Сегодня количество шагов ниже как вашей обычной активности, так и уровня, который обычно связывают с малоподвижным образом жизни. Такой сигнал стоит учитывать, особенно если он повторяется.';
  }

  if (status == 'Личная норма активности низкая') {
    return 'Ваша обычная активность сейчас находится в зоне низкой подвижности. Даже если сегодня вы близки к своей норме, организму может не хватать движения в течение дня.';
  }

  if (status == 'Активность снижена') {
    return 'Сегодня активность ниже уровня, который используется как ориентир для низкой подвижности, хотя ваша личная норма обычно выглядит более устойчивой. Это может быть разовым снижением активности.';
  }

  if (status == 'Ниже вашей нормы') {
    return 'Сегодня количество шагов ниже вашей личной нормы. Даже если активность не относится к низкой, снижение относительно обычного уровня может быть заметным для общего тонуса.';
  }

  if (status == 'В пределах нормы') {
    return 'Сегодняшняя активность выглядит стабильной относительно вашей личной нормы и не находится в зоне низкой подвижности. По этому показателю заметного сигнала ухудшения нет.';
  }

  return 'Пока недостаточно данных, чтобы корректно интерпретировать этот показатель.';
}

String getMarkerStatusInterpretation(String? markerStatus) {
  if (markerStatus == null || markerStatus.trim().isEmpty) {
    return 'Пока недостаточно данных, чтобы сравнить текущее значение показателя с вашей личной нормой. Когда данных станет больше, интерпретация будет точнее.';
  }

  final String status = markerStatus.trim();

  if (status == 'Недостаточно данных') {
    return 'Пока недостаточно данных, чтобы сравнить текущее значение показателя с вашей личной нормой. Когда данных станет больше, интерпретация будет точнее.';
  }

  // Для показателей, где повышение = менее благоприятно:
  // стресс, истощение.
  if (status == 'Существенно повышен' || status == 'Существенно повышено') {
    return 'Сегодня значение показателя находится на высоком уровне, и ваша личная норма по нему тоже повышена. Это может означать, что такая динамика является устойчивым фоном, а не только разовым отклонением.';
  }

  if (status == 'Заметно повышен' || status == 'Заметно повышено') {
    return 'Сегодня значение показателя находится на высоком уровне, хотя обычно он не выглядит настолько выраженным. Такой сигнал стоит учитывать, особенно если он повторяется.';
  }

  if (status == 'Выше вашей нормы') {
    return 'Сегодня значение показателя выше вашей личной нормы. Даже если повышение не выглядит резким, оно может быть заметным для общего состояния и восстановления.';
  }

  if (status == 'Личная норма повышена') {
    return 'Ваша личная норма по этому показателю сейчас находится выше благоприятного уровня. Даже если сегодня значение близко к вашей норме, общий фон может оставаться напряжённым.';
  }

  // Для показателей, где снижение = менее благоприятно:
  // энергия, социальная поддержка.
  if (status == 'Существенно снижена') {
    return 'Сегодня значение показателя находится на низком уровне, и ваша личная норма по нему тоже снижена. Это может означать, что такая динамика является устойчивым фоном, а не только разовым отклонением.';
  }

  if (status == 'Заметно снижена') {
    return 'Сегодня значение показателя находится на низком уровне, хотя обычно он выглядит более устойчивым. Такой сигнал стоит учитывать, особенно если он повторяется.';
  }

  if (status == 'Ниже вашей нормы') {
    return 'Сегодня значение показателя ниже вашей личной нормы. Даже если снижение не выглядит резким, оно может быть заметным для общего состояния и восстановления.';
  }

  if (status == 'Личная норма снижена') {
    return 'Ваша личная норма по этому показателю сейчас находится ниже благоприятного уровня. Даже если сегодня значение близко к вашей норме, общий запас ресурса может оставаться сниженным.';
  }

  if (status == 'В пределах нормы') {
    return 'Сегодняшнее значение выглядит стабильным относительно вашей личной нормы и не показывает выраженного неблагоприятного отклонения. По этому показателю заметного сигнала ухудшения нет.';
  }

  return 'Пока недостаточно данных, чтобы корректно интерпретировать этот показатель.';
}
