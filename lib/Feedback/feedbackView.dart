import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Feedback/feedbackController.dart';
import '../Routes/approutes.dart';
import '../Widget/appColor.dart';
import '../Widget/text_theme.dart';

class FeedbackView extends GetView<FeedbackController>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.white,
     appBar: AppBar(
       backgroundColor: Colors.white,
       centerTitle: true,
       title: Text('Feedback', style: MyTextTheme.mediumBCD),
       bottom: PreferredSize(
         preferredSize: const Size.fromHeight(1.0),
         child: Divider(
           height: 1.0,
           color: AppColor.packageGray,
         ),
       ),
       leading: InkWell(
         onTap: () {
           Get.toNamed(AppRoutes.dashboardRoute);
         },
         child: Icon(Icons.arrow_back_ios_new,size: 20,),
       ),
   
     ),
     body: Padding(
       padding: const EdgeInsets.all(16.0),
       child: SingleChildScrollView(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(
               'Leave us a feedback',
               style: MyTextTheme.largeCustomBCB
             ),
             SizedBox(height: 16),
            Row(
              children: [
                Text("Mail address (optional)",style: TextStyle(color: AppColor.greyDark),)
              ],
            ),
             SizedBox(
               height: 10,
             ),

             TextFormField(
               cursorColor: AppColor.circleIndicator,
               decoration:  InputDecoration(
                 focusedBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(10),
                   borderSide: const BorderSide(
                     color: Colors.grey,
                     width: 1.5,
                   ),
                 ),
                 enabled: true,
                 enabledBorder:  OutlineInputBorder(
                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
                   borderSide: BorderSide(color:AppColor.packageGray,width: 1.5),
                 ),
                 hintText: 'Enter your email address',
                   hintStyle: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400),
                   border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(10)),
                   ),

               onChanged: (value) {
                 controller.setEmail(value);
               },
               keyboardType: TextInputType.emailAddress,
               autofillHints: const [AutofillHints.email],
               validator: (value) =>
               value != null && value.isNotEmpty
                   ? null
                   : 'Required',
             ),

             SizedBox(height: 16),
             // Rating scale
             Text('On a scale of 1-5 how likely you are to recommend this tool to someone you know?',style: TextStyle(color: AppColor.greyDark),),
             SizedBox(height: 8),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: List.generate(5, (index) {
                 return Obx(() {
                  return RawChip(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: AppColor.packageGray, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    selectedColor: AppColor.circleIndicator,
                    backgroundColor: Colors.white,
                    label: Text('${index + 1}'),
                    labelStyle: TextStyle(color: Colors.black),
                    selected: controller.rating.value == index + 1,
                    showCheckmark: false, // This removes the tick mark
                    onSelected: (isSelected) {
                      controller.setRating(index + 1);
                    },
                    padding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 8.0),  // Increases the overall size of the chip
                    labelPadding: EdgeInsets.symmetric(horizontal: 8.0), // Adds padding around the label
                  );


                 });
               }),
             ),
             SizedBox(height: 5),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text('Not likely at all',style: TextStyle(color: AppColor.greyDark,fontSize: 12)),
                 Text('Extremely likely',style: TextStyle(color: AppColor.greyDark,fontSize: 12)),
               ],
             ),
             SizedBox(height: 16),
             Row(
               children: [
                 Text("Suggestion or comment, if any",style: TextStyle(color: AppColor.greyDark),)
               ],
             ),
            SizedBox(height: 10,),
             TextField(
               cursorColor: AppColor.circleIndicator,
               decoration: InputDecoration(
                 hintText: 'Say something here...',
                 hintStyle:TextStyle(color: Colors.grey,fontWeight: FontWeight.w400),
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(15),
                 ),
                 enabledBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(10),
                   borderSide: const BorderSide(
                     color: Colors.grey,
                     width: 1.5,
                   ),
                 ),
                 focusedBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(10),
                   borderSide: const BorderSide(
                     color: Colors.grey,
                     width: 1.5,
                   ),
                 ),
               ),
               maxLines: 5,
               onChanged: (value) {
                 controller.setComment(value);
               },
             ),
             SizedBox(height: 24),
            
             // Submit button
             Obx(() {
               return ElevatedButton(

                 onPressed: controller.isFormValid ? controller.submitFeedback : null,
                 style: ElevatedButton.styleFrom(
                   backgroundColor: controller.isFormValid ? AppColor.circleIndicator: AppColor.greyColor, // Button color
                   minimumSize: Size(double.infinity, 50),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(10)
                   )
                 ),
                 child: Text('Submit',style: TextStyle(color: Colors.white),),
               );
             }),
           ],
         ),
       ),
     ),
   );
  }
}
