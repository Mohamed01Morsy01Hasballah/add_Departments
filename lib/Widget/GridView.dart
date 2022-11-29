
import 'dart:io';

import 'package:flutter/material.dart';

class ItemGrid extends StatelessWidget{
  const ItemGrid({
    Key? key,
  required  this.image,
   required this.title,
}):super(key:key);
  final String image;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(50),
      ),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius:40,
              backgroundImage: Image.file(File(image)).image
            ),
            SizedBox(height: 4,),
            Text(
              title,
              style: TextStyle(
                color: Colors.deepOrangeAccent,
                fontSize: 12,
                fontWeight: FontWeight.bold
              )
            )
          ],
        ),
      ),
    );
  }

}