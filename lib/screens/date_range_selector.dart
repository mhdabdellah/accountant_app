// import 'package:flutter/material.dart';

// class DateRangeSelector extends StatefulWidget {
//   const DateRangeSelector({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _DateRangeSelectorState createState() => _DateRangeSelectorState();
// }

// class _DateRangeSelectorState extends State<DateRangeSelector> {
//   late DateTime? startDate;
//   late DateTime? endDate;

//   @override
//   Widget build(BuildContext context) {
//     final authTransactionProvider =
//         Provider.of<AuthTransactionProvider>(context);
//     return ElevatedButton(
//       onPressed: () async {
//         DateTimeRange? picked = await showDateRangePicker(
//           context: context,
//           firstDate: DateTime(2021),
//           lastDate: DateTime(2025),
//           initialDateRange: DateTimeRange(
//             start: startDate ?? DateTime.now(),
//             end: endDate ?? DateTime.now(),
//           ),
//         );

//         if (picked != null) {
//           setState(() {
//             startDate = picked.start;
//             endDate = picked.end;
//           });

//           // Optionally, you can fetch transactions here
//           await authTransactionProvider.getTransactionsInDateRange(
//               startDate!, endDate!);

//           Navigator.pop(context); // Close bottom sheet
//         }
//       },
//       child: const Text('Select Date Range'),
//     );
//   }
// }
