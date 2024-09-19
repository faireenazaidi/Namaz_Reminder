

import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:namaz_reminders/Widget/text_theme.dart';




class MyCustomSD extends StatefulWidget {

  final InputDecoration? decoration;
  final ValueChanged onChanged;
  final List listToSearch;
  final String? label;
  final String valFrom;
  final Widget? prefixIcon;
  final List? initialValue;
  final bool? hideSearch;
  final double? height;
  final Color? borderColor;

  const MyCustomSD({Key? key,

    this.decoration,
    this.label,
    this.prefixIcon,
    required this.listToSearch,
    this.initialValue,
    this.hideSearch,
    this.height,
    this.borderColor,
    required this.valFrom,
    required this.onChanged,}) : super(key: key);

  @override
  _MyCustomSDState createState() => _MyCustomSDState();
}

class _MyCustomSDState extends State<MyCustomSD> {

  bool obscure=false;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border=OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(
          color: Colors.grey,
          width: 1
      ),
    );
    return CustomSearchableDropDown(
      prefixIcon: widget.prefixIcon,
      searchBarHeight: 40,
      padding: const EdgeInsets.all(0),
      initialValue: widget.initialValue,
      primaryColor: Colors.white,
      hideSearch: widget.hideSearch?? false,
      menuHeight: widget.height??80,
      menuMode: true,
      labelStyle: TextStyle(fontSize: 14,color: Colors.black),
      items: widget.listToSearch,
      label: widget.label??'Select Name',
      dropdownItemStyle: TextStyle(color: Colors.black),


      dropDownMenuItems: widget.listToSearch.map((item) {
        return item[widget.valFrom];
      }).toList(),
      onChanged: (val){
        widget.onChanged(val);
      },
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(
              color: Colors.white,
              width: 1
          )
      ),


    );
  }
}


