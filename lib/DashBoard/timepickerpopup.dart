import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberpicker/numberpicker.dart';

class  TimePicker extends StatefulWidget {
  const TimePicker({super.key});

  @override
  State<TimePicker> createState() => _TimePickerState();
}
class _TimePickerState extends State<TimePicker>{
  var hour = 0;
  var minute = 0;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'MARK YOUR PRAYER TIME',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            NumberPicker(
              minValue: 0,
              maxValue: 12,
              itemWidth: 80,
              itemHeight: 60,
              value: hour,
              zeroPad: true,
              infiniteLoop: true,
              onChanged: (value) {
                setState(() {
                  hour = value;
                });
              },
              textStyle: TextStyle(color: Colors.grey,fontSize: 20),
              selectedTextStyle: TextStyle(color: Colors.white,fontSize: 30),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.white
                  ),
                  bottom: BorderSide(
                    color: Colors.white
                  )

                )
              ),
            ),
            NumberPicker(
              minValue: 0,
              maxValue: 12,
              itemWidth: 80,
              itemHeight: 60,
              value: minute,
              zeroPad: true,
              infiniteLoop: true,
              onChanged: (value) {
                setState(() {
                  minute = value;
                });
              },
              textStyle: TextStyle(color: Colors.grey,fontSize: 20),
              selectedTextStyle: TextStyle(color: Colors.white,fontSize: 30),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: Colors.white
                      ),
                      bottom: BorderSide(
                          color: Colors.white
                      )

                  )
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
    }


  }

