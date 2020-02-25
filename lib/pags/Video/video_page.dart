import 'dart:ui' as ui;

import 'package:flutter/material.dart';


class VideoPage extends StatefulWidget {



@override
State<VideoPage> createState() {
  return _VideoPageState();
}

}

class _VideoPageState extends State <VideoPage> {

  double windowHeight;
  double windowWidth ;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    windowHeight = ui.window.physicalSize.height /
        MediaQuery.of(context).devicePixelRatio;
    windowWidth = ui.window.physicalSize.width /
        MediaQuery.of(context).devicePixelRatio;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidget(context);
  }

  Widget _buildWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
          title: Text("Title Absorb"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              tooltip: 'search',
              onPressed: _run,
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              tooltip: 'refresh',
              onPressed: _run,
            ),
          ]
      ),
      body: Listener(
        onPointerDown:(_){
          print("\n _onPointerDown："); ///+ _.toString()
        },
        onPointerUp: (_) {
          print("\n onPointerUp：" );
        },
        child: Container(
          width: windowWidth,
          height: windowHeight,
          padding: EdgeInsets.fromLTRB(10, 20 , 10, 0),
          color: Colors.blueAccent,
          child: AbsorbPointer(
            absorbing: false,
            child: Listener(
              onPointerDown:(_){
                print("\n 11111 _onPointerDown：" );
              },

              onPointerUp: (_) {
                print("\n 11111 onPointerUp：" );
              },

              child: Container(
                color: Colors.yellowAccent,
                width: 300.0,
                height: 200.0,
              ),
            ),
          ),
        ),
      ),

    );
  }


  _run() {
    print("refresh action!!");
  }

}
