import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:namaz_reminders/Feedback/feedbackController.dart';
import '../Drawer/drawerController.dart';
import '../Widget/appColor.dart';
import '../Widget/text_theme.dart';


class FeedbackView extends GetView<FeedbackController>{
  const FeedbackView({super.key});

  @override
  Widget build(BuildContext context) {
    final FeedbackController feedbackController = Get.put(FeedbackController());
    final CustomDrawerController customDrawerController = Get.find<CustomDrawerController>();


    return Scaffold(
     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
     appBar: AppBar(
       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
       centerTitle: true,
       title: Text('Feedback', style: MyTextTheme.mediumBCD.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color)
           ),
       bottom: PreferredSize(
         preferredSize: const Size.fromHeight(1.0),
         child: Divider(
           height: 1.0,
           color:  Theme.of(context).dividerColor,
         ),
       ),
       leading: InkWell(
         onTap: () {
           Get.back();
         },
         child: Transform.scale(
           scale:
           MediaQuery.of(context).size.width <360 ? 0.6: 0.7,
           child:   CircleAvatar(
               radius: 12,
               backgroundColor: customDrawerController.isDarkMode == false ? AppColor.cardbg: Colors.white12,
               child: const Icon(Icons.arrow_back_ios_new,size: 20,)),
         ),
       ),
     ),
     body: Padding(
       padding: const EdgeInsets.all(10.0),
       child: SingleChildScrollView(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text('Leave us a feedback',style: MyTextTheme.largeCustomBCB.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color)),
             SizedBox(height: 16),
            Row(
              children: [
                Text("Mail address (optional)",style: MyTextTheme.smallGCN.copyWith(color: Theme.of(context).textTheme.titleSmall?.color))
              ],
            ),
             SizedBox(height: 10,),
             TextFormField(
               controller: feedbackController.emailController,
                 cursorColor: AppColor.circleIndicator,
                 decoration:  InputDecoration(
                   filled: true,
                   fillColor: customDrawerController.isDarkMode == false ? AppColor.cardbg: Colors.white12,
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
                   hintStyle: MyTextTheme.smallGCN.copyWith(color: Theme.of(context).textTheme.titleSmall?.color,),
                   border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(10)),
                 ),
                 onChanged: (value) {
                   feedbackController.setEmail(value);
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
             Text('On a scale of 1-5 how likely you are to recommend this tool to someone you know?',
                 style: MyTextTheme.smallGCN.copyWith(color: Theme.of(context).textTheme.titleSmall?.color)),
             SizedBox(height: 8),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: List.generate(5, (index) {
                 return Obx(() {
                  return RawChip(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: AppColor.packageGray, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    selectedColor: AppColor.circleIndicator,
                    backgroundColor: customDrawerController.isDarkMode == false ? AppColor.cardbg: Colors.white12,
                    label: Text('${index + 1}'),
                    labelStyle:  MyTextTheme.smallGCN.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color),
                    selected: feedbackController.rating.value == index + 1,
                    showCheckmark: false, // This removes the tick mark
                    onSelected: (isSelected) {
                      feedbackController.setRating(index + 1);
                    },
                    padding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 8.0),
                    labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  );
                 });
               }),
             ),
             const SizedBox(height: 5),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text('Not likely at all',style: MyTextTheme.smallGCN.copyWith(color: Theme.of(context).textTheme.titleSmall?.color,fontSize:12 )),
                 Text('Extremely likely',style: MyTextTheme.smallGCN.copyWith(color: Theme.of(context).textTheme.titleSmall?.color,fontSize:12 )),
               ],
             ),
             SizedBox(height: 16),
             Row(
               children: [
                 Text("Suggestion or comment, if any",style: MyTextTheme.smallGCN.copyWith(color: Theme.of(context).textTheme.titleSmall?.color,))
               ],
             ),
            const SizedBox(height: 10,),

             TextField(
               controller: feedbackController.commentController,
               cursorColor: AppColor.circleIndicator,
               decoration: InputDecoration(
                 filled: true,
                 fillColor: customDrawerController.isDarkMode == false ? AppColor.cardbg: Colors.white12,
                 hintText: 'Say something here...',
                 hintStyle:MyTextTheme.smallGCN.copyWith(color: Theme.of(context).textTheme.titleSmall?.color),
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
                 feedbackController.setComment(value);
               },
             ),
            const SizedBox(height: 24),
             // Submit button
             Obx(() {
               return ElevatedButton(
                 onPressed: feedbackController.isFormValid ? feedbackController.submitFeedback : null,
                 style: ElevatedButton.styleFrom(
                   backgroundColor: feedbackController.isFormValid ? AppColor.circleIndicator: AppColor.greyColor, // Button color
                   minimumSize: const Size(double.infinity, 50),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(10)
                   )
                 ),
                 child: const Text('Submit',style: TextStyle(color: Colors.white),),
               );
             }),
           ],
         ),
       ),
     ),
       );
  }
}

