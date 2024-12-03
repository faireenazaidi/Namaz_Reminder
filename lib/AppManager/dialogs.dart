import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Widget/appColor.dart';

class Dialogs{
  static void actionBottomSheet({String? title,required String subTitle,required Function okPressEvent,
    Function? cancelPressEvent,Color? okButtonColor,Color? cancelButtonColor,
    String? cancelButtonName, String? okButtonName}) {
    Get.bottomSheet(
        isDismissible: true,
        elevation: 20.0,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            )),
        Padding(
          padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              //Divider(thickness: 4,indent: 150,endIndent: 150,height:25 ),
              if(title!=null)
                Text(title,style:const TextStyle(
                  fontSize: 18,fontWeight: FontWeight.bold,
                ),),
              const SizedBox(height: 18,),
              Text(textAlign: TextAlign.center,style: const TextStyle(
                  letterSpacing: 1,fontSize: 16,color:Colors.black
              ),
                  subTitle),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(onPressed: (){
                      Get.back();
                      if(cancelPressEvent!=null){
                        cancelPressEvent();
                      }
                    },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(160,42),
                        elevation: 0,textStyle:const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,letterSpacing: 1),
                        backgroundColor:cancelButtonColor?? AppColor.circleIndicator,
                        // Colors.grey.shade100,
                        //padding:EdgeInsets.symmetric(horizontal: 50,vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),

                      ), child: Text(cancelButtonName??"Cancel",style: TextStyle(
                        color:cancelButtonColor??Colors.white,
                      ),),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: ElevatedButton(onPressed: (){
                      okPressEvent();
                    },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:AppColor.circleIndicator,
                        fixedSize: const Size(160,42),
                        elevation: 0,textStyle:const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,letterSpacing: 1,),
                        //padding:EdgeInsets.symmetric(horizontal: 50,vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),

                      ), child: Text(okButtonName??"Ok",style: TextStyle(color: okButtonColor!=null?Colors.white:null),),
                    ),
                  ),
                ],
              )

            ],
          ),
        )
    );
  }
  static Future<void> showConfirmationDialog({
    required BuildContext context,
    required Future<bool> Function() onConfirmed,
    VoidCallback? onCancelled,
    String initialMessage = "ARE YOU SURE?",
    String confirmButtonText = "Yes, Remove",
    String cancelButtonText = "No, Go Back",
    String? successMessage,
    String? failureMessage,
    String? loadingMessage,
    bool showCancelButton = true,
    Color? confirmButtonColor,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true, // Prevent dismiss on touch outside while processing
      builder: (BuildContext context) {
        return _ConfirmationDialog(
          onConfirmed: onConfirmed,
          onCancelled: onCancelled,
          initialMessage: initialMessage,
          confirmButtonText: confirmButtonText,
          cancelButtonText: cancelButtonText,
          successMessage: successMessage,
          failureMessage: failureMessage,
          showCancelButton: showCancelButton,
          confirmButtonColor: confirmButtonColor,
          loadingMessage: loadingMessage,
        );
      },
    );
  }
  static BuildContext? _dialogContext;
  static void showLoading(BuildContext context, {String message = "Loading..."}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        _dialogContext = context; // Store the dialog's context
        return Stack(
          children: [
            // Blurred background
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.3), // Semi-transparent overlay
              ),
            ),
            Center(
              child: Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 15,width: 15,child: CircularProgressIndicator(strokeWidth: 2.0,)),
                      const SizedBox(width: 20),
                      Flexible(child: Text(message,style: const TextStyle(fontSize: 12),)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static void hideLoading() {
    if (_dialogContext != null) {
      Navigator.of(_dialogContext!, rootNavigator: true).pop();
      _dialogContext = null; // Reset the context after hiding the dialog
    }
  }
}


class _ConfirmationDialog extends StatefulWidget {
  final Future<bool> Function() onConfirmed;
  final VoidCallback? onCancelled;
  final String initialMessage;
  final String confirmButtonText;
  final String cancelButtonText;
  final String? successMessage;
  final String? failureMessage;
  final String? loadingMessage;
  final bool showCancelButton;
  final Color? confirmButtonColor;

  _ConfirmationDialog({
    required this.onConfirmed,
    this.onCancelled,
    this.initialMessage = "ARE YOU SURE?",
    this.confirmButtonText = "Yes, Remove",
    this.cancelButtonText = "No, Go Back",
    this.successMessage,
    this.failureMessage,
    this.loadingMessage,
    this.showCancelButton = true,
    this.confirmButtonColor,
  });

  @override
  State<_ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<_ConfirmationDialog> {
  String message = "";
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    message = widget.initialMessage;
  }

  void _startProcessing() async {
    setState(() {
      isProcessing = true;
      message =widget.loadingMessage?? "Processing...";
    });

    bool success = await widget.onConfirmed();

    setState(() {
      message = success
          ? widget.successMessage ?? "Action completed successfully!"
          : widget.failureMessage ?? "Action failed.";
      isProcessing = false;
    });

    // Delay before closing the dialog so the user can see the result
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey, // Dark background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
    decoration: BoxDecoration(
                      image: const DecorationImage(
                        opacity: 9,
                        image: AssetImage("assets/net.png"),
                        fit: BoxFit.cover,
                      ),
                      color: AppColor.gray,
                      borderRadius: BorderRadius.circular(15),
                    ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              "assets/container.png",
              width: 40,
              height: 50,
            ),
            const SizedBox(height: 10),
            Text(
              message,
              style: const TextStyle(
                color: Colors.orange,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (widget.showCancelButton && !isProcessing)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (widget.onCancelled != null) {
                        widget.onCancelled!();
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      widget.cancelButtonText,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    widget.confirmButtonColor ?? Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: isProcessing ? null : _startProcessing,
                  child: Text(
                    widget.confirmButtonText,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}