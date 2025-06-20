import 'package:flutter/material.dart';

class Uihelper {
  static CustomTextField(
    TextEditingController controller,
    String text,
    IconData iconData,
    bool toHide,
  ) {
    return TextField(
      controller: controller,
      obscureText: toHide,
      decoration: InputDecoration(
        hintText: text,
        suffixIcon: Icon(iconData),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
      ),
    );
  }

  static CustomButton(VoidCallback voidCallback, String text) {
    return SizedBox(
      height: 50,
      width: 300,
      child: ElevatedButton(onPressed: () {
        voidCallback();
      },style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),backgroundColor: Color(0xff232323)), child: Text(text, style: TextStyle(fontSize: 20, color: Colors.white),)),
    );
  }

  static CustomAlertBox(BuildContext context, String text){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text(text),
        actions: [
          TextButton(onPressed: (){}, child: TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("OK")))
        ],
      );
    });
  }
}

