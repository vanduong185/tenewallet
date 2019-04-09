import "package:flutter/material.dart";

class Background extends StatefulWidget {
  final Widget child;

  Background({Key key, this.child}) : super(key: key) ;

  @override
  _BackgroundState createState() => _BackgroundState(child);
}

class _BackgroundState extends State<Background> {
  Widget child;

  _BackgroundState(this.child);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
//        width: screenWidth,
//        height: screenHeight,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [const Color(0xFF1980BA), const Color(0xFF4AB7E0)],
                tileMode: TileMode.repeated
            )
        ),
        child: child
    );
  }
}