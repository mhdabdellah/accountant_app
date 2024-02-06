// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class BarChartSample2 extends StatefulWidget {
//   final List<double> expenses;
//   final List<double> incomes;

//   const BarChartSample2(
//       {super.key, required this.expenses, required this.incomes});

//   @override
//   State<StatefulWidget> createState() => BarChartSample2State();
// }

// class BarChartSample2State extends State<BarChartSample2> {
//   final double width = 7;
//   late List<BarChartGroupData> barGroups;

//   @override
//   void initState() {
//     super.initState();
//     barGroups = _generateBarGroups();
//   }

//   List<BarChartGroupData> _generateBarGroups() {
//     List<BarChartGroupData> groups = [];
//     for (int i = 0; i < widget.expenses.length; i++) {
//       double expense = widget.expenses[i];
//       double income = widget.incomes[i];
//       BarChartGroupData group = makeGroupData(i, expense, income);
//       groups.add(group);
//     }
//     return groups;
//   }

//   BarChartGroupData makeGroupData(int x, double expense, double income) {
//     return BarChartGroupData(
//       barsSpace: 4,
//       x: x,
//       barRods: [
//         BarChartRodData(
//           toY: expense,
//           color: Colors.red,
//           width: width,
//         ),
//         BarChartRodData(
//           toY: income,
//           color: Colors.green,
//           width: width,
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: BarChart(
//           BarChartData(
//             maxY: widget.expenses.reduce((a, b) => a > b ? a : b),
//             barTouchData: BarTouchData(
//               touchTooltipData: BarTouchTooltipData(
//                 tooltipBgColor: Colors.grey,
//                 getTooltipItem: (a, b, c, d) => null,
//               ),
//               touchCallback: (FlTouchEvent event, response) {},
//             ),
//             titlesData: FlTitlesData(
//               show: true,
//               rightTitles: SideTitles(showTitles: false),
//               topTitles: const SideTitles(showTitles: false),
//               bottomTitles: SideTitles(
//                 showTitles: true,
//                 showTitles: (value) {
//                   return value.toInt().toString();
//                 },
//               ),
//               leftTitles: SideTitles(
//                 showTitles: true,
//                 interval: 1,
//               ),
//             ),
//             borderData: FlBorderData(
//               show: false,
//             ),
//             barGroups: barGroups,
//             gridData: FlGridData(show: false),
//           ),
//         ),
//       ),
//     );
//   }
// }
