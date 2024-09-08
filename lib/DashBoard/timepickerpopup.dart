import 'package:flutter/material.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';
import 'package:numberpicker/numberpicker.dart';

import '../Widget/appColor.dart';
import '../Widget/myButton.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({super.key});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> with SingleTickerProviderStateMixin {
  var hour = 1;
  var minute = 54;
  bool isAm = true;
  bool prayedAtMosque = false;

  // AnimationController and OffsetAnimation
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1), // Slow motion animation
      vsync: this,
    );

    // Initialize the _offsetAnimation directly in initState
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1), // Start above the screen
      end: Offset.zero, // End at the center
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Dialog(
        backgroundColor: Colors.black87,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/blacknet.png')
            )
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
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
                    SizedBox(width: 10,),
                    Image.asset("assets/container.png")
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
                        infiniteLoop: true,
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
                        infiniteLoop: true,
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
                      activeColor:AppColor.circleIndicator,
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
                  onPressed: () {},
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
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    transitionDuration: const Duration(seconds: 1), // Control transition speed
    pageBuilder: (context, anim1, anim2) {
      return const TimePicker(); // The dialog widget
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -1),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: anim1,
          curve: Curves.easeOut,
        )),
        child: child,
      );
    },
  );
}
