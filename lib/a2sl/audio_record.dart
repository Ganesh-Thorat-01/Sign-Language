import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_list_sample/a2sl/loading.dart';
import 'speechscreen.dart';
import 'loading.dart';



class AudioRecord extends StatefulWidget{
  //const AudioRecord({ Key? key }) : super(key: key);
 

  @override
  State<AudioRecord> createState() => _AudioRecordState();
}

class _AudioRecordState extends State<AudioRecord> with AutomaticKeepAliveClientMixin {
   @override
  bool get wantKeepAlive=>true;
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      
      body: Center(child: SpeechScreen()),
    
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'translatebtn',
        onPressed: ()
        {   
              
          {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Loading()),
          );
        }
         
        }
        ,
        icon : Icon(Icons.play_arrow),
        label: Text('Translate'),
        tooltip: "Translate",
      ),
    );
  }
}

