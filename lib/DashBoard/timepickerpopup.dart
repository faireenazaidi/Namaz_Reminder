import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:intl/intl.dart'; // Add this import to get current time

import '../LocationSelectionPage/locationPageView.dart';
import '../Widget/appColor.dart';
import '../Widget/myButton.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({super.key});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> with SingleTickerProviderStateMixin {
  var hour = 1;
  var minute = 0;
  bool isAm = true;
  bool prayedAtMosque = false;

  // AnimationController for ScaleTransition
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize hour and minute to current time
    final now = DateTime.now();
    hour = now.hour % 12; // Convert to 12-hour format
    if (hour == 0) hour = 12; // Handle 0 hour case
    minute = now.minute;
    isAm = now.hour < 12;

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300), // Duration of the scaling animation
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeOut,
    ).drive(Tween<double>(begin: 0.8, end: 1.0)); // Scale from 0.8 to 1.0

    // Start the scaling animation
    _scaleController.forward();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Dialog(
        backgroundColor: AppColor.gray,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/blacknet.png'),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'MARK YOUR PRAYER TIME',
                      style: MyTextTheme.mustardS,
                    ),
                    SizedBox(width: 25),
                    Image.asset("assets/container.png"),
                  ],
                ),
                const SizedBox(height: 20),
                // Hour and Minute Pickers
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Wrap Hour picker in Flexible to avoid overflow
                    Flexible(
                      child: NumberPicker(
                        minValue: 1,
                        maxValue: 12,
                        itemWidth: 60,
                        itemHeight: 80,
                        value: hour,
                        zeroPad: true,
                        infiniteLoop: false, // Prevent going forward
                        onChanged: (value) {
                          setState(() {
                            hour = value;
                          });
                        },
                        textStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                        selectedTextStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Colon separator
                    const Text(
                      " : ",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    // Wrap Minute picker in Flexible to avoid overflow
                    Flexible(
                      child: NumberPicker(
                        minValue: 0,
                        maxValue: 59,
                        itemWidth: 60,
                        itemHeight: 80,
                        value: minute,
                        zeroPad: true,
                        infiniteLoop: false, // Prevent going forward
                        onChanged: (value) {
                          setState(() {
                            minute = value;
                          });
                        },
                        textStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                        selectedTextStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // AM/PM Selector wrapped in Flexible to avoid overflow
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isAm = true;
                              });
                            },
                            child: Text(
                              "AM",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: isAm ? Colors.white : Colors.grey,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isAm = false;
                              });
                            },
                            child: Text(
                              "PM",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: !isAm ? Colors.white : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Checkbox for Mosque/Jamat
                Row(
                  children: [
                    Checkbox(
                      value: prayedAtMosque,
                      activeColor: AppColor.circleIndicator,
                      onChanged: (bool? value) {
                        setState(() {
                          prayedAtMosque = value ?? false;
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        "Prayed at Mosque / Jamat time",
                        style: MyTextTheme.smallWCN,
                        overflow: TextOverflow.ellipsis, // Prevent overflow
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Submit Button
                MyButton(
                  borderRadius: 10,
                  elevation: 2,
                  title: "Submit",
                  color: AppColor.circleIndicator,
                  onPressed: () {
                    Lottie.asset("assets/Crown.lottie",
                        decoder: customDecoder, height: 60);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showCustomTimePicker(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const TimePicker();
    },
  );
}
