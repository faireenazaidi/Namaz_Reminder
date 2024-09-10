import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';
import 'myButton.dart';

class AlertDialogue {
  show(context, {
    String? msg,
    String? firstButtonName,
    Function? firstButtonPressEvent,
    String? secondButtonName,
    Function? secondButtonPressEvent,
    bool? showCancelButton,
    bool? showOkButton,
    bool? disableDuration,
    bool? checkIcon,
    List<Widget>? newWidget,
    String? title,
    String? subTitle,
  }) {
    var canPressOk = true;
    return WidgetsBinding.instance.addPostFrameCallback((_) {
      showCupertinoModalBottomSheet(
        shadow: BoxShadow(blurRadius: 0, color: newWidget == null ? Colors.transparent : Colors.black12, spreadRadius: 0),
        backgroundColor: Colors.transparent,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) => Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            alignment: Alignment.bottomCenter,
            child: newWidget != null ? ListView(
              shrinkWrap: true,
              children: [
                Center(
                  child: Container(
                    width: 200,
                    height: 5,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    decoration: const BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,  // Black background
                    image: DecorationImage(
                      image: const AssetImage('assets/whiteNet.png'), // Transparent image
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.4),  // Adjust the opacity of the image here
                        BlendMode.dstATop,  // Blending mode to keep black background and apply image transparency
                      ),
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: title != null,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title.toString(),
                                      style: MyTextTheme.mustard,
                                    ),
                                    Visibility(
                                      visible: subTitle != null,
                                      child: Text(
                                        subTitle.toString(),
                                        style: MyTextTheme.mustard,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (canPressOk) {
                                    canPressOk = false;
                                    Navigator.pop(context);
                                  }
                                },
                                icon: const Icon(
                                  Icons.clear,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: newWidget,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ) : ListView(
              shrinkWrap: true,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    image: DecorationImage(
                      image: const AssetImage(''), // Transparent image
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.4),  // Adjust the image opacity here
                        BlendMode.dstATop,
                      ),
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    border: Border.all(color: Colors.red),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                              child: Text(
                                msg.toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Row(
                                children: [
                                  (showCancelButton ?? false)
                                      ? Expanded(
                                    child: Visibility(
                                      visible: showCancelButton ?? false,
                                      child: MyButton(
                                        title: 'Cancel',
                                        onPressed: () {
                                          if (canPressOk) {
                                            canPressOk = false;
                                            Navigator.pop(context);
                                          }
                                        },
                                      ),
                                    ),
                                  )
                                      : Container(),
                                  SizedBox(width: 20),
                                  (firstButtonName != null)
                                      ? Expanded(
                                    child: Visibility(
                                      visible: firstButtonName != null,
                                      child: MyButton(
                                        title: firstButtonName.toString(),
                                        onPressed: () {
                                          if (canPressOk) {
                                            canPressOk = false;
                                            firstButtonPressEvent!();
                                          }
                                        },
                                      ),
                                    ),
                                  )
                                      : Container(),
                                  (showOkButton ?? false)
                                      ? Expanded(
                                    child: Visibility(
                                      visible: showOkButton ?? false,
                                      child: MyButton(
                                        title: 'Ok',
                                        onPressed: () {
                                          if (canPressOk) {
                                            canPressOk = false;
                                            Navigator.pop(context);
                                          }
                                        },
                                      ),
                                    ),
                                  )
                                      : Container(),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
