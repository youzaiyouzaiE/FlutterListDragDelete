
import 'package:expanded_sample/Widget/time_choice_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {

  final int pagIndex;

  final String title;

  DetailPage({this.pagIndex, this.title});

  @override
  State<DetailPage> createState() {
    return _DetailPageState();
  }

}

class _DetailPageState extends State<DetailPage> {

  String _value = '';

  @override
  void initState() {
   super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

//  @override
//  bool get userGestureInProgress => true;

  @override
  Widget build(BuildContext context) {
    return buildWidget(context);
  }



  Widget buildWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(title: Text(widget.title), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          tooltip: 'Run again',
          onPressed: _run,
        ),
      ]
      ),
      body:GestureDetector (
        onHorizontalDragDown:(_){
          print("back gesture !");
        },
        onHorizontalDragStart:(_){
          print("back gesture onHorizontalDragStart!");
        },
        onHorizontalDragUpdate:(_){
          print("back gesture onHorizontalDragUpdate!");
        },
        child:RawGestureDetector(
          gestures: {
            DetailNotAllowMultipleGestureRecognizer: GestureRecognizerFactoryWithHandlers<DetailNotAllowMultipleGestureRecognizer> (
                  () => DetailNotAllowMultipleGestureRecognizer(), //构造函数
                  (DetailNotAllowMultipleGestureRecognizer instance) { //初始化器
//              instance.onTap = () => print('Episode 4 is best! (parent container) ');
                instance.onTap = (int pointer) => print(' BBBBBBBBB 4 is best! (parent container) ');

                instance.onTapDown = (int pointer, TapDownDetails details) => print('BBBBBBBB  onDown 111111111111 is best! ');
//                   instance.onUpdate = (_)=> print('onUpdate 2222222222222 is best!');
                instance.onTapUp  = (int pointer, TapUpDetails details) => print('  BBBBBBB  onUpdate 33333333333333 is best!');
              },
            )
          },
          behavior: HitTestBehavior.deferToChild,
          child: Container(
            color: Colors.blueAccent,
            child: Center(
              //用 RawGestureDetector 将两个容器包裹起来
              child: GestureDetector(
                onTap:(){
                  print(" on Tap Action !");
                },
                //在第一个容器中创建嵌套容器。
                child: Container(
                  color: Colors.white,
                  width: 300.0,
                  height: 400.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bodyWidget() {
    int formIndex = widget.pagIndex;
    return SafeArea (
      child: Container(
//          color: Colors.red,
        child: Center(
          child:Text('来自第 $formIndex 条的数据!'),
        ),
        ),
      );
  }

  _run() {
    print("run action!!");
//    _selectTime();
    TimeChoiceDialog.show(context).then((Map<int,String> items){
      print("$items");
    });
  }
}

class DetailNotAllowMultipleGestureRecognizer extends MultiTapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {//acceptGesture(pointer);
    rejectGesture(pointer);
    print('BBBBBBBBBBB the pointer is $pointer');
  }

}