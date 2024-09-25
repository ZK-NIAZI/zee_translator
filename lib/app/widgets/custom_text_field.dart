import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  TextEditingController controller;
  final String hintText;
  final String errorText;
  final double height;
  final Color bgColor;
  final ValueChanged<String>? onChanged;

  CustomTextField({super.key, required this.hintText,required this.controller,  this.errorText='',  this.height=150, required this.bgColor, this.onChanged});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: widget.height,
      decoration:  BoxDecoration(color: widget.bgColor),
      child: TextField(
        onChanged: widget.onChanged,
        controller: widget.controller,
        maxLines: 4,
        keyboardType: TextInputType.text,
        cursorColor: Colors.black,
        cursorWidth: 4,
        style: const TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.normal),
        cursorErrorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 20,left: 10,right: 10),
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.normal),
          errorText: widget.errorText,
          errorStyle: const TextStyle(color: Colors.red,fontSize: 12,fontWeight: FontWeight.normal),

        ),

      ),
    );

  }
}
