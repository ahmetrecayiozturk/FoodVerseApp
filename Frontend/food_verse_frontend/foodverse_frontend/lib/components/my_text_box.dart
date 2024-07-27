import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final Function()? onpressed;

  const MyTextBox(
      {super.key,
      required this.text,
      required this.sectionName,
      required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.red,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //sectionName
              Text(sectionName, style: TextStyle(color: Colors.white)),
              //edit button
              IconButton(
                icon: Icon(Icons.settings, color: Colors.grey),
                onPressed: onpressed,
              ),
            ],
          )
        ],
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  const MyTextBox({super.key, required this.text, required this.sectionName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //border: Border.all(color: Colors.grey),
        //borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
      ),
      padding: EdgeInsets.only(left: 0, right: 0),
      margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
      child: Column(
        children: [
          //sectionName
          Text(
            sectionName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            text,
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
*/