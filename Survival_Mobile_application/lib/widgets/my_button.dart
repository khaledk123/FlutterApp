import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  // const MyButton({
  //   Key? key,
  // }) : super(key: key);
  const MyButton(
      {required this.color, required this.onPressed, required this.title});
  final Color color;
  final String title;
  final VoidCallback
      onPressed; //we changed it from 'Function' type to 'voidcallback' to be able to put 'onpressed' and 'onpressed' equal to eath other
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Material(
          elevation: 5,
          color: color,
          borderRadius: BorderRadius.circular(10),
          child: MaterialButton(
            onPressed: onPressed,
            minWidth: 200,
            height: 42,
            child: Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ));
  }
}
