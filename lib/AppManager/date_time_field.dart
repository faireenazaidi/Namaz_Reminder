
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import '../Widget/appColor.dart';
import '../Widget/text_theme.dart';







class MyDateTimeField extends StatelessWidget {
  final String? hintText;
  final DateTimePickerType? dateTimePickerType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final int? maxLine;
  final int? maxLength;
  final bool? enabled;
  final bool? useAsTimeField;
  final bool? useFutureDate;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final InputDecoration? decoration;
  final ValueChanged? onChanged;
  final String? initialValue;
  final Color? borderColor;
  final Widget? label;
  final BorderRadius? borderRadius;
  final Function? onTap;

  const MyDateTimeField({Key? key, this.hintText, this.controller,
    this.validator,
    this.dateTimePickerType,
    this.prefixIcon,
    this.useAsTimeField,
    this.suffixIcon,
    this.maxLength,
    this.enabled,
    this.textAlign,
    this.keyboardType,
    this.decoration,
    this.onChanged,
    this.initialValue,
    this.useFutureDate,
    this.borderColor,
    this.label,
    this.borderRadius,
    this.onTap,
    this.maxLine}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border=OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(
          color: borderColor??Colors.grey,
          width: 1
      ),
    );
    return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light().copyWith(
             primary: AppColor.buttonColor,
          ),
        ),
        child: DateTimePicker(
          enabled: enabled??true,
          //  locale: Locale('en_US', 'en'),
          controller: controller,
          minLines: maxLine,
          maxLines: maxLine==null? 1:100,
          maxLength: maxLength,
          textAlign: textAlign?? TextAlign.start,
          onChanged:  onChanged==null? null:(val){
            onChanged!(val);
          },
          type: dateTimePickerType?? DateTimePickerType.date,
          dateMask: (dateTimePickerType==DateTimePickerType.dateTime)?'yyyy/MM/dd    hh:mm a':
          (dateTimePickerType==DateTimePickerType.time)?
              'hh:mm a'
              :
          'yyyy/MM/dd',
          initialValue: initialValue,
          firstDate: (useFutureDate?? false)? DateTime.now():DateTime(1980),
          lastDate: (useFutureDate?? false)? DateTime.now().add(const Duration(days: 30)):DateTime.now(),
          icon: const Icon(Icons.event),

          selectableDayPredicate: (date) {
            // Disable weekend days to select from the calendar
            return true;
          },
          // onSaved: (val) => print(val),
          style:  MyTextTheme.mediumBCN,
          decoration: decoration??InputDecoration(
            label: label,
            filled: true,
            isDense: true,
            fillColor: Colors.white,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            counterText: '',
            //contentPadding: isPasswordField==null? EdgeInsets.all(5):isPasswordField? EdgeInsets.fromLTRB(5,5,5,5):EdgeInsets.all(5),
            contentPadding: const EdgeInsets.all(12),
            hintText: hintText,
            hintStyle: MyTextTheme.mediumBCN.copyWith(
                color: Colors.grey
            ),
            errorStyle: MyTextTheme.mediumBCB.copyWith(
                color: Colors.red
            ),
            prefixIcon: prefixIcon,
            prefixIconConstraints:const BoxConstraints(minWidth: 30, maxHeight: 30),
            suffixIconConstraints:const BoxConstraints(minWidth: 30, maxHeight: 30),
            focusedBorder: border,
            enabledBorder: border,
            disabledBorder: border,
            errorBorder: border,
            focusedErrorBorder: border,
          ),
          validator: validator,
        )
    );
  }
}

