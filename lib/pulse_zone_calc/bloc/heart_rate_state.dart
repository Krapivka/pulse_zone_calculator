import 'package:equatable/equatable.dart';
import 'package:pulse_zone_calc/pulse_zone_calc/models/heart_rate_zone.dart';

class HeartRateState extends Equatable {
  final int age;
  final int restingPulse;
  final String gender;
  final List<HeartRateZone> zones;

  const HeartRateState({
    required this.age,
    required this.restingPulse,
    required this.gender,
    required this.zones,
  });

  factory HeartRateState.initial() =>
      const HeartRateState(age: 0, restingPulse: 0, gender: 'male', zones: []);

  @override
  // TODO: implement props
  List<Object?> get props => [age, restingPulse, gender, zones];
}
