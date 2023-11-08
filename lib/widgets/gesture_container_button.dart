import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget GestureConButton({onPrees,title}){
  return GestureDetector(
    onTap:onPrees,
    child: Container(
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(child: Text(title,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
    ),
  );
}