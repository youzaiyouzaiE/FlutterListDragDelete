import 'dart:ui' as ui;

import 'package:expanded_sample/Widget/week_choice_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AbsorbDetailPage extends StatefulWidget {

  final int pagIndex;
  final String title;

  AbsorbDetailPage({this.pagIndex, this.title});

  @override
  State<AbsorbDetailPage> createState() {
    return _AbsorbDetailPageState();
  }

}

class _AbsorbDetailPageState extends State <AbsorbDetailPage> {

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
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              tooltip: 'again',
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
          child: AbsorbPointer( ///屏蔽事件响应
            absorbing: false,
            child: Listener(
              onPointerDown:(_){
                print("\n 11111 _onPointerDown：" );
              },
              onPointerUp: (_) {
                print("\n 11111 onPointerUp：" );
              },

              child: Container(
                color: Colors.orange,
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
      WeekChoiceDialog.show(context).then((List<int> items) {
        print("$items");
      });
  }

}
