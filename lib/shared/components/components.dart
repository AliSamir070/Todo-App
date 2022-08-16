import 'package:flutter/material.dart';
import 'package:test_app/shared/cubit/cubit.dart';

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
  bool isClickable;
  bool isReadable;
  bool isCursorShowed;
  DefaultFormField({
    required this.controller ,
    required this.text,
    required this.type,
    this.isObscured = false,
    required this.Prefix,
    required this.validator,
    this.Suffix,
    this.onTap,
    this.isClickable = true,
    this.isReadable = false,
    this.isCursorShowed = true
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
      enabled: widget.isClickable,
      readOnly: widget.isReadable,
      showCursor: widget.isCursorShowed,
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

class taskItem extends StatelessWidget {
  Map model;
  taskItem({required this.model});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key:Key(model['id'].toString()),
      onDismissed: (direction){
          AppCubit.get(context).deleteFromDatabase(model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(
                model['time'],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model['title'],
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    model['date'],
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey
                    ),
                  )
                ],
              ),
            ),
            IconButton(
                onPressed: (){
                  AppCubit.get(context).updateStatusDatabase("done", model["id"]);
                },
                icon: Icon(
                    Icons.check_circle_outline,
                  color: Colors.green,
                )
            ),
            IconButton(
                onPressed: (){
                  AppCubit.get(context).updateStatusDatabase("archive", model["id"]);
                },
                icon: Icon(
                  Icons.archive_outlined,
                  color: Colors.grey[600],
                )
            )
          ],
        ),
      ),
    );
  }
}
class errorMessage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.hourglass_empty,
            color: Colors.grey,
            size: 50,
          ),
          Text(
            'No tasks yet, please add some tasks',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

}


