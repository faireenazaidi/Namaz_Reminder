import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:namaz_reminders/Widget/appColor.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';

class MyDateTimeField extends StatelessWidget {
  final String? hintText;
  final DateTimePickerType? dateTimePickerType;
  final Widget? suffixIcon;
  final Icon? prefixIcon;
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

  const  MyDateTimeField({Key? key, this.hintText, this.controller,
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
    return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light().copyWith(
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
          dateMask: (dateTimePickerType==DateTimePickerType.dateTime)?'MM/dd/yyyy    hh:mm a':
          (dateTimePickerType==DateTimePickerType.time)?
          'hh:mm a'
              :
          'MM/dd/yyyy',
          initialValue: initialValue,
          firstDate: (useFutureDate?? false)? DateTime.now():DateTime(1800),
          lastDate: (useFutureDate?? false)? DateTime.now().add(const Duration(days: 30)):DateTime.now(),
          icon: const Icon(Icons.event),

          selectableDayPredicate: (date) {
            // Disable weekend days to select from the calendar
            return true;
          },
          // onSaved: (val) => print(val),
          style:  MyTextTheme.mediumBCN.copyWith(fontSize: 15),
          decoration: decoration??InputDecoration(
            label: label,
            filled: true,
            isDense: true,
            fillColor: enabled==false?  AppColor.cream:Colors.white,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            counterText: '',
            contentPadding: const EdgeInsets.fromLTRB(12, 10, 0, 10),
            hintText: hintText,
            hintStyle: MyTextTheme.mediumBCN.copyWith(fontSize: 14,
                color: Colors.grey
            ),
            errorStyle: MyTextTheme.mediumBCN.copyWith(
                color: Colors.red
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,

            suffixIconConstraints: const BoxConstraints(
              minHeight: 10,
              minWidth: 10,
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius?? const BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                  color: borderColor?? AppColor.packageGray,
                  width: 0.5
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius?? const BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                color: borderColor?? AppColor.amberColor,

              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: borderRadius?? const BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                color: borderColor?? AppColor.amberColor,

              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: borderRadius?? const BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                color: borderColor?? AppColor.amberColor,

              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: borderRadius?? const BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                color: borderColor?? AppColor.amberColor,
              ),
            ),
          ),
          validator: validator,
        )
    );
  }
}


