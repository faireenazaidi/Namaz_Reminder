import 'package:flutter/material.dart';

class PrayerTimeCard extends StatelessWidget {
  final String title;
  final String startTime;
  final String endTime;
  final bool isCurrent;

  PrayerTimeCard({
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCurrent ? Colors.blueAccent : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isCurrent ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Starts at $startTime',
                style: TextStyle(
                  fontSize: 16,
                  color: isCurrent ? Colors.white70 : Colors.black87,
                ),
              ),
              Text(
                'Ends at $endTime',
                style: TextStyle(
                  fontSize: 16,
                  color: isCurrent ? Colors.white70 : Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}