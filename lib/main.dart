import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'dart:io' show File;
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';


main(){

  runApp(MyApp());
  
  }

Future<String> _getDirPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }
  
  void checkFile() async{
    final dirPath = await _getDirPath();
    bool directoryExists = await Directory("$dirPath/speechoutput.json").exists();
    bool fileExists = await File("$dirPath/speechoutput.json").exists();

    if(directoryExists || fileExists) {
      
    }
    else{
      final data={"text":"Press the button and start speaking"};
      final data_f=jsonEncode(data);
      File('$dirPath/speechoutput.json').writeAsStringSync(data_f.toString());
    }
  }

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    checkFile();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SignMate',
      theme: ThemeData(
        fontFamily: "OpenSans",
        primarySwatch: Colors.indigo,
        
      ),
      home: MyHomePage(),
    );
  }
}

