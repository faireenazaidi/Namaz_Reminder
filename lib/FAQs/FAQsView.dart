import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../DashBoard/dashboardView.dart';
import '../Routes/approutes.dart';
import '../Widget/appColor.dart';
import '../Widget/text_theme.dart';
import 'FAQsController.dart';

class FAQSView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FAQController faqController = Get.put(FAQController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('FAQs', style: MyTextTheme.mediumBCD),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Divider(
            height: 1.5,
            color: AppColor.packageGray,
          ),
        ),
        leading: InkWell(
          onTap: () {
            // Get.back();
            Get.to(
                  () => DashBoardView(),
              transition: Transition.leftToRight,
              duration: Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          },
          child: const Icon(Icons.arrow_back_ios_new,size: 20,),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GetBuilder<FAQController>(
          builder: (controller) {
            return ListView.builder(
              itemCount: faqController.faqs.length,
              itemBuilder: (context, index) {
                final faq = faqController.faqs[index];
                return Column(
                  children: [
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.0,),

                      title: Text(faq['question'],style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                      trailing: Icon(faq['isExpanded'] ? Icons.remove : Icons.add),
                      onTap: () {
                        faqController.toggleExpansion(index);
                      },
                    ),
                    if (faq['isExpanded'])
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            faq['answer'],
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                      ),
                    Divider(),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
