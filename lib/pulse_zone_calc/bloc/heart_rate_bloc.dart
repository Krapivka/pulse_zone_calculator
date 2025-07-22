import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_zone_calc/pulse_zone_calc/bloc/heart_rate_event.dart';
import 'package:pulse_zone_calc/pulse_zone_calc/bloc/heart_rate_state.dart';
import 'package:pulse_zone_calc/pulse_zone_calc/models/heart_rate_zone.dart';

class HeartRateBloc extends Bloc<HeartRateEvent, HeartRateState> {
  HeartRateBloc() : super(HeartRateState.initial()) {
    on<HeartRateCompute>(_onHeartRateCompute);
  }

  double _calculateAverageMaxHR(int age, {String gender = 'male'}) {
    // Формулы maxHR
    final hr1 = 220 - age; // Хаскелл-Фокс
    final hr2 = 206.3 - 0.711 * age; // Лондери-Мешбергер
    final hr3 = 217 - 0.85 * age; // Миллер
    final hr4 = 206.9 - 0.67 * age; // Джексон
    final hr5 = 208 - 0.7 * age; // Танака
    final hr6 = 205.8 - 0.685 * age; // Робергс-Ландвер
    final hr9 = 205.8 - 0.685 * age; // Из калькулятора (дубль Робергс-Ландвер)

    // Формула для спортсменов
    final hr7 = 214 - 0.8 * age; // Мужчины
    final hr8 = 209 - 0.7 * age; // Женщины

    // Учитываем пол
    final athleteHR = (gender == 'female') ? hr8 : hr7;

    // Список всех значений
    final values = [hr1, hr2, hr3, hr4, hr5, hr6, athleteHR, hr9];

    // Считаем среднее
    final average = values.reduce((a, b) => a + b) / values.length;
    return average;
  }

  void _onHeartRateCompute(
      HeartRateCompute event, Emitter<HeartRateState> emit) {
    final maxHr = _calculateAverageMaxHR(event.age, gender: event.gender);

    final minHr = event.restingPulse;
    final zones = [
      HeartRateZone(
        "Зона 1 (50–59%)",
        "Низкая интенсивность: прогулка, разминка.",
        ((maxHr - minHr) * 0.50).round() + minHr,
        ((maxHr - minHr) * 0.59).round() + minHr,
      ),
      HeartRateZone(
        "Зона 2 (60–69%)",
        "Быстрая ходьба. Улучшение выносливости и похудение.",
        ((maxHr - minHr) * 0.60).round() + minHr,
        ((maxHr - minHr) * 0.69).round() + minHr,
      ),
      HeartRateZone(
        "Зона 3 (70–79%)",
        "Лёгкий бег. Аэробная зона, укрепление сердца.",
        ((maxHr - minHr) * 0.70).round() + minHr,
        ((maxHr - minHr) * 0.79).round() + minHr,
      ),
      HeartRateZone(
        "Зона 4 (80–89%)",
        "Интервальные тренировки, спринт. Анаэробная зона.",
        ((maxHr - minHr) * 0.80).round() + minHr,
        ((maxHr - minHr) * 0.89).round() + minHr,
      ),
      HeartRateZone(
        "Зона 5 (90–100%)",
        "Максимальная зона. Только для опытных спортсменов.",
        ((maxHr - minHr) * 0.9).round() + minHr,
        ((maxHr - minHr) * 1).round() + minHr,
      ),
    ];

    emit(HeartRateState(
      age: event.age,
      restingPulse: event.restingPulse,
      gender: event.gender,
      zones: zones,
    ));
  }
}
