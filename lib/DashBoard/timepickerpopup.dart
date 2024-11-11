import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';
import 'package:numberpicker/numberpicker.dart';
import '../LocationSelectionPage/locationPageView.dart';
import '../Widget/appColor.dart';
import '../Widget/myButton.dart';
import 'dashboardController.dart';

class TimePicker extends StatefulWidget {
  final String? date;
  final bool? isFromMissed;
  final DateTime? missedPrayerTime;
  final Future<dynamic> Function()? missedCallBack;
  const TimePicker({super.key, this.date, this.isFromMissed = false, this.missedCallBack, this.missedPrayerTime});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> with SingleTickerProviderStateMixin {


  bool isAm = true;


  // AnimationController for ScaleTransition
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  DashBoardController dashBoardController = Get.put(DashBoardController());

  @override
  void initState() {
    super.initState();

    // Initialize hour and minute to current time
    final now = widget.missedPrayerTime??DateTime.now();
    dashBoardController.hour = now.hour % 12; // Convert to 12-hour format
    if (dashBoardController.hour == 0) dashBoardController.hour = 12; // Handle 0 hour case
    dashBoardController.minute = now.minute;
    isAm = now.hour < 12;

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 500), // Duration of the scaling animation
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
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context).pop();
          },
          child: Container(
            width: screenWidth * 0.70,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 3,),
                    Text(
                      'MARK YOUR PRAYER TIME',
                      style: MyTextTheme.mustard2
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    SvgPicture.asset(
                        "assets/namz.svg",height: 45,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                // Hour and Minute Pickers
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Hour picker
                    Flexible(
                      child: NumberPicker(
                        itemCount: 5,
                        minValue: 1,
                        maxValue: 12,
                        // itemWidth: screenWidth * 0.15,
                        // itemHeight: screenHeight * 0.12,
                        value: dashBoardController.hour,
                        haptics: false,
                        zeroPad: true,
                        infiniteLoop: true, // Prevent going forward
                        onChanged: (value) {
                          setState(() {
                            dashBoardController.hour = value;
                            print("ddddd "+dashBoardController.hour.toString());
                          });
                        },
                        textStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: screenWidth * 0.08,
                            fontWeight: FontWeight.w300
                        ),
                        selectedTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.11,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),



                    // Colon separator
                    Text(
                      " : ",
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    // Minute picker
                    Flexible(
                      child: NumberPicker(
                        itemCount: 5,
                        minValue: 0,
                        maxValue: 59,
                        // itemWidth: screenWidth * 0.15,
                        // itemHeight: screenHeight * 0.12,
                        value: dashBoardController.minute,
                        zeroPad: true,
                        infiniteLoop: true,
                        onChanged: (value) {
                          setState(() {
                            dashBoardController.minute = value;
                            print("sdss"+dashBoardController.minute.toString());


                          });
                        },
                        textStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: screenWidth * 0.08,
                          fontWeight: FontWeight.w300
                        ),
                        selectedTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.11,
                          fontWeight: FontWeight.w400,
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
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8.0,8,8,4),
                              child: Text(
                                "AM",
                                style: TextStyle(
                                  color: isAm ? Colors.white: Colors.grey,
                                  fontSize: isAm  ? 20.0 : 16.0,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isAm = false;
                              });
                            },
                            child:
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8.0,4,8,8),
                              child: Text(
                                "PM",
                                style: TextStyle(
                                  color: !isAm ? Colors.white : Colors.grey,
                                  fontSize: !isAm  ? 20.0 : 16.0,
                                ),
                              ),
                            ),

                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Checkbox(
                      value: dashBoardController.prayedAtMosque.value,
                      activeColor: AppColor.circleIndicator,
                      onChanged: (bool? value) {
                        setState(() {
                          dashBoardController.prayedAtMosque.value = value ?? false;
                          print("sssss "+dashBoardController.prayedAtMosque.value.toString());
                        });
                      },
                    ),
                    Text(
                      "Prayed at Mosque / Jamat time",
                      style: MyTextTheme.smallWCN.copyWith(
                       fontSize: 12// Adjust font size dynamically
                      ),
                      overflow: TextOverflow.ellipsis, // Prevent overflow
                    ),
                  ],
                ),
                MyButton(
                  borderRadius: 8,
                  elevation: 2,
                  title: "Submit",
                  color: AppColor.circleIndicator,
                  onPressed: () {
                    dashBoardController.isAm = isAm;
                    print("isAm ${dashBoardController.isAm}");
                    Lottie.asset("assets/Crown.lottie",
                        decoder: customDecoder, height: 60);
                    dashBoardController.submitPrayer(valDate: widget.date,isFromMissed: widget.isFromMissed,missedCallBack: widget.missedCallBack);
                  },
                ),
                // Submit Button

              ],
            ),
          ),
        ),
      ),
    );
  }
}

 showCustomTimePicker(BuildContext context) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return  TimePicker();
    },
  );
}

