import 'package:equatable/equatable.dart';

class HeartRateCompute extends HeartRateEvent {
  final int age;
  final int restingPulse;
  final String gender; // 'male' или 'female'
  HeartRateCompute(this.age, this.restingPulse, this.gender);

  @override
  List<Object?> get props => [age, restingPulse, gender];
}

abstract class HeartRateEvent extends Equatable {}
