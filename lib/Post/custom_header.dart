import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({Key key, this.title,}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child:Container(
        alignment: Alignment.topLeft,
        child: Column(

        children: [
          Text(
            title,
            textAlign: TextAlign.left,
            textDirection: TextDirection.ltr,
            style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(fontWeight: FontWeight.bold),
          ),
        ])
      
      ));
  }
}