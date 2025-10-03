import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ViolationChart extends StatelessWidget {
  final Map<String, int> data;
  const ViolationChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final bars = data.entries.toList();
    return BarChart(
      BarChartData(
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, meta) {
              final idx = v.toInt();
              if (idx < 0 || idx >= bars.length) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(bars[idx].key, style: const TextStyle(fontSize: 10)),
              );
            }),
          ),
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: true)),
        ),
        barGroups: [
          for (int i = 0; i < bars.length; i++)
            BarChartGroupData(x: i, barRods: [BarChartRodData(toY: bars[i].value.toDouble())])
        ],
      ),
    );
  }
}
