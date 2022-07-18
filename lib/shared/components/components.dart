import 'package:flutter/material.dart';

class AuthenticationButton extends StatelessWidget {
  double width;
  VoidCallback onPressed;
  String text;
  Color color;
  bool isUpper;
  AuthenticationButton({
    this.width = double.infinity ,
    required this.onPressed ,
    required this.text ,
    this.color = Colors.blue,
    this.isUpper = true
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 40,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              padding: EdgeInsetsDirectional.all(12),
              primary: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              )
          ),
          child: Text(
            isUpper ? text.toUpperCase() : text,
            style: TextStyle(
                color: Colors.white
            ),
          )
      ),
    );
  }
}
class DefaultFormField extends StatefulWidget {
  TextEditingController controller;
  String text;
  TextInputType type;
  String? Function(String?) validator;
  bool isObscured;
  Icon Prefix;
  IconButton? Suffix;
  VoidCallback? onTap;
  DefaultFormField({
    required this.controller ,
    required this.text,
    required this.type,
    this.isObscured = false,
    required this.Prefix,
    required this.validator,
    this.Suffix,
    this.onTap
  });
  @override
  State<DefaultFormField> createState() => _DefaultFormFieldState();
}

class _DefaultFormFieldState extends State<DefaultFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isObscured,
      controller: widget.controller,
      keyboardType: widget.type,
      onTap: widget.onTap,
      decoration: InputDecoration(
          hintText: widget.text,
          prefixIcon: widget.Prefix,
          hintStyle: TextStyle(
              fontSize: 20,
              color: Colors.grey
          ),
          suffixIcon: widget.Suffix,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7)
          )
      ),
      validator: widget.validator,

    );
  }
}

