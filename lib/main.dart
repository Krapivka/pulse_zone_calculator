import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_zone_calc/pulse_zone_calc/bloc/heart_rate_bloc.dart';
import 'package:pulse_zone_calc/pulse_zone_calc/view/heart_rate_screen.dart';

void main() {
  runApp(const HeartRateApp());
}

class HeartRateApp extends StatelessWidget {
  const HeartRateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор пульсовых зон',
      theme: ThemeData(primarySwatch: Colors.red),
      home: BlocProvider(
        create: (_) => HeartRateBloc(),
        child: const HeartRateScreen(),
      ),
    );
  }
}
