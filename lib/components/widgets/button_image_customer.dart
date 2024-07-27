import 'package:flutter/material.dart';

class ButtonImageCustomer extends StatelessWidget {
  ButtonImageCustomer(
      {super.key,
      required this.onTap,
      required this.path,
      required this.title,
      this.height = 50,
      this.width = double.infinity,
      this.titleStyle = const TextStyle(fontSize: 16, color: Colors.black),
      this.backgroundColor = Colors.blue});
  VoidCallback onTap;
  String path;
  Color backgroundColor;
  String title;
  TextStyle titleStyle;
  double height;
  double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              blurRadius: 3,
              color: Color.fromARGB(255, 193, 193, 193),
              offset: Offset(2, 2),
            )
          ]),
      child: InkWell(
          onTap: onTap,
          // borderRadius: BorderRadius.circular(30),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: backgroundColor,
                backgroundImage: AssetImage(path),
              ),
              const Spacer(flex: 1),
              Text(
                maxLines: 1,
                title,
                style: titleStyle,
              ),
              const Spacer(flex: 2),
            ],
          )),
    );
  }
}
