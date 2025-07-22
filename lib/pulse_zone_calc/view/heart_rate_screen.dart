import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse_zone_calc/pulse_zone_calc/bloc/heart_rate_bloc.dart';
import 'package:pulse_zone_calc/pulse_zone_calc/bloc/heart_rate_event.dart';
import 'package:pulse_zone_calc/pulse_zone_calc/bloc/heart_rate_state.dart';

class HeartRateScreen extends StatefulWidget {
  const HeartRateScreen({super.key});

  @override
  State<HeartRateScreen> createState() => _HeartRateScreenState();
}

class _HeartRateScreenState extends State<HeartRateScreen> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController restingPulseController = TextEditingController();
  bool isMale = true; // true = мужской, false = женский

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Калькулятор пульсовых зон')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: ageController,
              decoration:
                  const InputDecoration(labelText: 'Введите ваш возраст'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: restingPulseController,
              decoration:
                  const InputDecoration(labelText: 'Введите пульс в покое'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Checkbox(
                  value: isMale,
                  onChanged: (value) {
                    setState(() {
                      isMale = value ?? true;
                    });
                  },
                ),
                const Text('Мужской'),
                const SizedBox(width: 20),
                Checkbox(
                  value: !isMale,
                  onChanged: (value) {
                    setState(() {
                      isMale = !(value ?? false);
                    });
                  },
                ),
                const Text('Женский'),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                final age = int.tryParse(ageController.text) ?? 0;
                final restingPulse =
                    int.tryParse(restingPulseController.text) ?? 0;
                final gender = isMale ? 'male' : 'female';

                context
                    .read<HeartRateBloc>()
                    .add(HeartRateCompute(age, restingPulse, gender));
              },
              child: const Text('Рассчитать зоны'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<HeartRateBloc, HeartRateState>(
                builder: (context, state) {
                  if (state.zones.isEmpty) {
                    return const Center(
                        child: Text('Пожалуйста, введите данные.'));
                  }

                  return ListView.builder(
                    itemCount: state.zones.length,
                    itemBuilder: (context, index) {
                      final zone = state.zones[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(zone.title),
                          subtitle: Text(zone.description),
                          trailing:
                              Text('${zone.minBpm}–${zone.maxBpm} уд/мин'),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
