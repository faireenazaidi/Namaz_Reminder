import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';
import 'package:numberpicker/numberpicker.dart';
import '../Drawer/drawerController.dart';
import '../Widget/appColor.dart';
import '../Widget/myButton.dart';
import 'dashboardController.dart';

class TimePicker extends StatefulWidget {
  final String? date;
  final String? prayerNames;
  final String? startTime;
  final String? endTime;
  final bool? isFromMissed;
  final DateTime? missedPrayerTime;
  final Future<dynamic> Function()? missedCallBack;
  const TimePicker({
    super.key, this.date,
    this.isFromMissed = false,
    this.missedCallBack,
    this.missedPrayerTime,
    this.prayerNames,
    this.startTime,
    this.endTime});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> with SingleTickerProviderStateMixin {
  final DashBoardController controller = Get.find();

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
    // int minHour24 = getHoursFromTime(dashBoardController.currentPrayerStartTime.value.toString());
    // int maxHour24 = getHoursFromTime(dashBoardController.currentPrayerEndTime.toString());
    // String minHour = "${(minHour24 % 12 == 0) ? 12 : minHour24 % 12} ${(minHour24 >= 12) ? "PM" : "AM"}";
    // String maxHour = "${(maxHour24 % 12 == 0) ? 12 : maxHour24 % 12} ${(maxHour24 >= 12) ? "PM" : "AM"}";
    // print("Min Hour24: $minHour, Max Hour: $maxHour");
    // if (dashBoardController.hour < minHour24 || dashBoardController.hour > maxHour24) {
    //   dashBoardController.hour = minHour24; // Set to minHour if out of range
    // }
    //
    //
    // // Ensure minute is within the range
    // int minMinute = getMinutesFromTime(dashBoardController.currentPrayerStartTime.value.toString());
    // int maxMinute = getMinutesFromTime(dashBoardController.currentPrayerEndTime.toString());
    // if (dashBoardController.minute < minMinute || dashBoardController.minute > maxMinute) {
    //   dashBoardController.minute = minMinute; // Set to minMinute if out of range
    // }


    // Get screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    print(getMinutesFromTime(dashBoardController.currentPrayerEndTime.toString()).toString());
    final CustomDrawerController customDrawerController = Get.find<CustomDrawerController>();

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Dialog(
        backgroundColor:customDrawerController.isDarkMode == false ? AppColor.gray: AppColor.circleIndicator.withOpacity(0.8),
      //  AppColor.gray,
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
            decoration: const BoxDecoration(
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
                      style: MyTextTheme.mustard2.copyWith(color: customDrawerController.isDarkMode == false ? AppColor.circleIndicator: Colors.black,)
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    SvgPicture.asset(
                        "assets/namz.svg",height: 45,color:  customDrawerController.isDarkMode == false ? AppColor.circleIndicator: Colors.black,),

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
                        minValue:  1,
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
                            color:customDrawerController.isDarkMode == true ? Colors.black87: Colors.grey,
                            fontSize: screenWidth * 0.08,
                            fontWeight: FontWeight.w300
                        ),
                        selectedTextStyle: TextStyle(
                          color: customDrawerController.isDarkMode == false ? AppColor.white: Colors.black,
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
                        color: customDrawerController.isDarkMode == false ? AppColor.white: Colors.black,
                      ),
                    ),
                    // Minute picker
                    Flexible(
                      child: NumberPicker(
                        itemCount:5,
                        minValue: 0,
                        maxValue: 59,
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
                          color:customDrawerController.isDarkMode == true ? Colors.black87: Colors.grey,
                          fontSize: screenWidth * 0.08,
                          fontWeight: FontWeight.w300
                        ),
                        selectedTextStyle: TextStyle(
                          color: customDrawerController.isDarkMode == false ? AppColor.white: Colors.black,
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
                                  color: customDrawerController.isDarkMode==false&&!isAm ? Colors.white : Colors.grey,
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
                      // side: BorderSide(
                      //   color: customDrawerController.isDarkMode == true ? Colors.black87: Colors.grey,
                      //   width: 1.5
                      // ),
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
                      style: MyTextTheme.smallWCN.copyWith(fontSize: 12,color: customDrawerController.isDarkMode == false ? AppColor.circleIndicator: Colors.black,),
                      overflow: TextOverflow.ellipsis, // Prevent overflow
                    ),
                  ],
                ),
                MyButton(
                  borderRadius: 8,
                  elevation: 2,
                  title: "Submit",
                  color:customDrawerController.isDarkMode == false ? AppColor.circleIndicator: Colors.black,
                  onPressed: () {
                    dashBoardController.isAm = isAm;
                    print("isAm ${dashBoardController.isAm}");
                    // Lottie.asset("assets/Crown.lottie",
                    //     decoder: customDecoder, height: 60);
                    dashBoardController.submitPrayer(valDate: widget.date,
                        isFromMissed: widget.isFromMissed,prayerNames:widget.prayerNames,startTime:widget.startTime,endTime: widget.endTime,
                        missedCallBack: widget.missedCallBack, context: context);

                    print("valDate: ${widget.date}");
                    print("isFromMissed: ${widget.isFromMissed}");
                    print("prayerNames: ${widget.prayerNames}");
                    print("startTime: ${widget.startTime}");
                    print("endTime: ${widget.endTime}");
                    print("missedCallBack: ${widget.missedCallBack}");
                    print("context: $context");
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

// Function to extract hours and minutes as minutes from midnight
// int getMinutesFromTime(String time) {
//   List<String> timeParts = time.split(' ');
//   String timeOnly = timeParts[0]; // "12:15"
//   String period = timeParts[1]; // "AM" or "PM"
//
//   List<String> hourMinuteParts = timeOnly.split(':');
//   int hours = int.parse(hourMinuteParts[0]);
//   print(hours);
//   int minutes = int.parse(hourMinuteParts[1]);
//   print("ggrdf"+minutes.toString());
//
//   // Convert to 24-hour format
//   if (period == "PM" && hours != 12) {
//     hours += 12;
//   } else if (period == "AM" && hours == 12) {
//     hours = 0;
//   }
//   // Return total minutes from midnight
//   return hours * 60 + minutes;
//
// }
int getHoursFromTime(String time) {
  List<String> timeParts = time.split(' ');
  String timeOnly = timeParts[0]; // "12:15"
  String period = timeParts[1]; // "AM" or "PM"

  List<String> hourMinuteParts = timeOnly.split(':');
  int hours = int.parse(hourMinuteParts[0]);

  // Convert to 24-hour format
  if (period == "PM" && hours != 12) {
    hours += 12;
  } else if (period == "AM" && hours == 12) {
    hours = 0;
  }
  return hours; // Return only the hours in 24-hour format
}

int getMinutesFromTime(String time) {
  List<String> timeParts = time.split(' ');
  String timeOnly = timeParts[0]; // "12:15"
  List<String> hourMinuteParts = timeOnly.split(':');
  return int.parse(hourMinuteParts[1]); // Return only the minutes
}




