import 'package:flutter/material.dart';
import 'model/models.dart';

class ClippedContainer extends StatelessWidget {
  const ClippedContainer({
    Key key,
    this.height=400,
    this.imageName,
    this.color,
  }) : super(key: key);

  final double height;
  final String imageName;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _CustomClipper(),
      child: Container(
        height:height,
        color: (imageName==null)? Colors.indigoAccent : null,
        decoration: (imageName!=null)? 
        
        BoxDecoration(
          image: DecorationImage(image: NetworkImage(imageName),
          fit: BoxFit.cover,
        ),
      ):null
                ),
    );
  }
}

class _CustomClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
  
  Path path= Path();

  path.lineTo(0,size.height*0.7);
  path.quadraticBezierTo(
                    size.width*0.1,
                    size.height*0.85,
                    size.width*0.3,
                    size.height*0.85
                    );
  path.lineTo(size.width*0.7, size.height*0.85);
  path.quadraticBezierTo(
                    size.width*0.9,
                    size.height*0.85,
                    size.width*1,
                    size.height*1
                    );
  path.lineTo(size.width, 0);
  return path;

    }



  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
  
}