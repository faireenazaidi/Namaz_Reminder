import 'package:flutter/material.dart';

import 'appColor.dart';
import 'myButton.dart';

class NoInternet extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const NoInternet({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/no_internet.webp',
          height: 150,width: 150,),
        Text(message,style: TextStyle(color: Colors.white70),),
        const SizedBox(height: 30,),
        MyButton(onPressed: (){
          Navigator.of(context).pop();
          onRetry();
        }, title: 'Retry',
          borderRadius: 10,color: AppColor.color,)
      ],
    );
  }
}
