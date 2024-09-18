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
    // Get screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Dialog(
        backgroundColor: AppColor.gray,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: screenWidth * 0.85,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.02,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/blacknet.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'MARK YOUR PRAYER TIME',
                    style: MyTextTheme.mustardS.copyWith(
                      fontSize: screenWidth * 0.045, // Dynamic font size
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.05),
                  Image.asset(
                    "assets/container.png",
                    width: screenWidth * 0.1, // Dynamic size for image
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Hour and Minute Pickers
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Hour picker
                  Flexible(
                    child: NumberPicker(
                      minValue: 1,
                      maxValue: 12,
                      itemWidth: screenWidth * 0.15,
                      itemHeight: screenHeight * 0.12,
                      value: hour,
                      zeroPad: true,
                      infiniteLoop: false, // Prevent going forward
                      onChanged: (value) {
                        setState(() {
                          hour = value;
                        });
                      },
                      textStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: screenWidth * 0.04,
                      ),
                      selectedTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.08,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Colon separator
                  Text(
                    " : ",
                    style: TextStyle(
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  // Minute picker
                  Flexible(
                    child: NumberPicker(
                      minValue: 0,
                      maxValue: 59,
                      itemWidth: screenWidth * 0.15,
                      itemHeight: screenHeight * 0.12,
                      value: minute,
                      zeroPad: true,
                      infiniteLoop: false, // Prevent going forward
                      onChanged: (value) {
                        setState(() {
                          minute = value;
                        });
                      },
                      textStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: screenWidth * 0.04,
                      ),
                      selectedTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.08,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // AM/PM Selector
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
                              fontSize: screenWidth * 0.05,
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
                              fontSize: screenWidth * 0.05,
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
                      style: MyTextTheme.smallWCN.copyWith(
                        fontSize: screenWidth * 0.04, // Adjust font size dynamically
                      ),
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
