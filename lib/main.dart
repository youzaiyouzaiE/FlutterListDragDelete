// Flutter code sample for widgets.Expanded.2

// This example shows how to use an [Expanded] widget in a [Row] with multiple
// children expanded, utilizing the [flex] factor to prioritize available space.

import 'package:flutter/material.dart';
import 'package:expanded_sample/slide_widget.dart';
import 'package:expanded_sample/normal_events.dart';
import 'package:expanded_sample/biz_eventbus.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {

  final String _title = 'List View Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyListWidget(),
    );
  }
}



/// This is the stateless widget that the main application instantiates.
class MyListWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return MyListWidgetState();
  }

}


class MyListWidgetState extends State<MyListWidget> {
  bool _hasOpenedCell = false;
  int _openedCellIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expanded Row Sample'),
      ),
      body:NotificationListener<ScrollNotification> (
      onNotification: _scrollKeepCellClose,
        child: ListView.separated(
          addRepaintBoundaries: true,
          itemCount: 10,
          itemBuilder:(BuildContext context, int index) {///Cell
            return _slideItems(index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Container(///线
              height: 0.5,
              color: index == 0 ? Colors.white:Colors.black26,
            );},
        ),
      )

    );
  }

  ///cell
  Widget _slideItems(int index) {
    return SlideButton (
      index: index,
      singleButtonWidth: 100,
      onSlideCompleted:(){
        if(_openedCellIndex != index) {
          _hasOpenedCell = true;
          _openedCellIndex = index;
        }
//        print("cell opened !");
      },
      onSlideCanceled: () {
         _openedCellIndex = -1;
         _hasOpenedCell = false;
//         print("cell closed !");
      },
      child:_itemView(index),
      buttons: <Widget>[
        GestureDetector(
          onTap:(){
            print("delete Button Action !");
          },
          child: Container(
            width: 120,
            color: Colors.red,
            child:Center (
              child:Text("删除",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  ///cell
  Widget _itemView(int index) {
    bool gestureResign = false;
    return GestureDetector (
            onTap:() {
              if (gestureResign) return ;
              print("$index cell pop  ! ");
            },
            onPanDown:(_) {
              if (_hasOpenedCell ) {
                fireCloseCellEvent();
                print("$index cell pan fire ! ");
                gestureResign = true;
              } else {
                gestureResign = false;
              }
            },
            child:Container(
              height: 100,
              color: Colors.red[200],
              child: Center(
                child: Text(
                  "第 $index 个",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            )
      );

  }

  void fireCloseCellEvent() {
    EventBusInstance().bus.fire(CloseOpenedCellEvent(closeIndex: _openedCellIndex));
    _hasOpenedCell = false;
    _openedCellIndex = -1;
  }

  bool _scrollKeepCellClose(ScrollNotification notification) {
    if (_hasOpenedCell) {
      fireCloseCellEvent();
    }
    return true;
  }

  void _setState() {
    setState(() {
    });
  }

}

