import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'a2sl/audio_record.dart';

class MyHomePage extends StatefulWidget {
  //const MyHomePage({ Key? key }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext contesxt) {
                return [
                  PopupMenuItem(
                    child: Text("About Us"),
                    value: "About Us",
                  ),
                  PopupMenuItem(
                    child: Text("Settings"),
                    value: "Settings",
                  ),
                  
                ];
              },
            )
          ],
          bottom: TabBar(
            //indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50), // Creates border
                color: Colors.lightBlueAccent),
            tabs: [
              Tooltip(
                  message: "Audio to Sign Language",
                  child: Tab(icon: Icon(Icons.mic))),
              Tooltip(
                  message: "Sign Language to Audio/Text",
                  child: Tab(icon: Icon(Icons.camera_alt))),
              Tooltip(
                  message: "Stories",
                  child: Tab(icon: Icon(Icons.collections_bookmark_sharp))),
            ],
          ),
          title: Text('Sign Language'),
        ),
        body: TabBarView(
          children: [
            AudioRecord(),
            Icon(Icons.directions_transit, size: 350),
            Icon(Icons.directions_car, size: 350),
          ],
        ),
      ),
    );
  }
}
