import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Drawer/drawerController.dart';
import '../Widget/appColor.dart';
import '../Widget/text_theme.dart';
import 'FAQsController.dart';

class FAQSView extends StatelessWidget {
  const FAQSView({super.key});

  @override
  Widget build(BuildContext context) {
    final FAQController faqController = Get.put(FAQController());
    final CustomDrawerController customDrawerController = Get.find<CustomDrawerController>();

    return Scaffold(
      backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text('FAQs', style: MyTextTheme.mediumBCD.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Divider(
            height: 1.5,
            color: customDrawerController.isDarkMode == true? AppColor.scaffBg:AppColor.packageGray,
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
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12.0,),
                      title: Text(faq['question'],style: MyTextTheme.mediumBCD.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color)),
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
                            style: MyTextTheme.smallGCN.copyWith(color: Theme.of(context).textTheme.titleSmall?.color)
                          ),
                        ),
                      ),
                     Divider(
                       color: Theme.of(context).dividerColor,
                    ),
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
