import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> station;

  const ViewDetailsScreen({super.key, required this.station});

  String formatDateTime(String dateTime) {
    final parsedDate = DateTime.parse(dateTime);
    return DateFormat('yyyy-MM-dd, hh:mm a').format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          station['name'],
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 1,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: const SingleChildScrollView(

        ),
      ),
    );
  }
}
