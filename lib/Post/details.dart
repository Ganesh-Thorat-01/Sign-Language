import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import '../HomePage.dart';
import '../Post/model/models.dart';

import '../main.dart';
import 'clipped_container.dart';

class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen({
    Key key,
    this.datalist,
  }) : super(key: key);

  final datalist;

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: ()async {
        
        return true;
        
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Post")),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _PostImage(datalist: datalist),
              _PostInformation(datalist: datalist),
            ],
          ),
        ),
      ),
    );
  }
}

class _PostInformation extends StatelessWidget {
  const _PostInformation({Key key, this.datalist}) : super(key: key);

  final DataModel datalist;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 40,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          //padding: EdgeInsets.only(top:1.0,bottom: 2.0),
          children: [
            Text(
              """${datalist.title}""",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              "About",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              """${datalist.description}
              """,
              textAlign: TextAlign.justify,
              style:
                  Theme.of(context).textTheme.bodyMedium.copyWith(fontSize: 16),
            ),
          ]),
    );
  }
}

class _PostImage extends StatelessWidget {
  const _PostImage({
    Key key,
    @required this.datalist,
  }) : super(key: key);

  final DataModel datalist;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ClippedContainer(
          height: 425,
        ),
        Hero(
          tag: '${datalist.title}',
          child: ClippedContainer(imageName: datalist.imageName),
        ),
      ],
    );
  }
}
