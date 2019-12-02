// Flutter code sample for widgets.Expanded.2

// This example shows how to use an [Expanded] widget in a [Row] with multiple
// children expanded, utilizing the [flex] factor to prioritize available space.

import 'package:expanded_sample/pags/absorb_detail_page.dart';
import 'package:expanded_sample/pags/detail_page.dart';
import 'package:flutter/gestures.dart';
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


class MyListWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return MyListWidgetState();
  }
}

class MyListWidgetState extends State<MyListWidget> {
  bool _hasOpenedCell = false;
  int _openedCellIndex = -1;

  bool gestureResign = false;
  int tapNumber = 0;

  GlobalKey<SlideButtonState> slideButtonKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expanded Row Sample'),
      ),
      body: NotificationListener<ScrollNotification> (
        onNotification: _scrollKeepCellClose,
       child: Listener(
         onPointerDown: (_){
           tapNumber +=1;
//           print('onDown 111111111111 is best! tapNumber === $tapNumber ');
//           tapNumber > 1 ? cellCanDrag = false : cellCanDrag = true;
         _setCellDragStatus();
         },
         onPointerUp: (_){
           tapNumber -=1;
//           print('onDown 111111111111 is best! tapNumber === $tapNumber ');
           _setCellDragStatus();
         },

         child:_listViewBuild(),
       ),
      )
    );
  }

  void _setCellDragStatus() {
//    tapNumber > 1 ? canNotDrag = true : canNotDrag = false;
//  if (tapNumber > 1 ){
//    print("celll can't drag!!    aaaaaaaaa");
//  } else {
//    print("celll can drag!!    bbbbbbbb");
//  }
  setState(() {
    tapNumber = tapNumber;
    gestureResign = gestureResign;
  });
}

  Widget _listViewBuild() {
    return
//      AbsorbPointer(
//        absorbing: canNotDrag,
//        child:
      ListView.separated(
      addRepaintBoundaries: true,
      itemCount: 10,
      itemBuilder:(BuildContext context, int index) {///Cell
        return _slideItems(index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(///线
          height: 0.5,
          color: index == 0 ? Colors.white:Colors.black26,
        );
      }
//      ),
    );
  }

  ///cell 手势   IgnorePointer
  Widget _slideItems(int index) {
    return
      SlideButton (
        canDragNumber: tapNumber,
        index: index,
        singleButtonWidth: 100,
        onSlideStarted:() {
        },
        onSlideCompleted:(){
          if(_openedCellIndex != index) {
            _hasOpenedCell = true;
            _openedCellIndex = index;
          }
        },
        onSlideCanceled: () {
          _openedCellIndex = -1;
          _hasOpenedCell = false;
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
            behavior: HitTestBehavior.opaque,
          )
        ],
      );
  }

  ///cell
  Widget _itemView(int index) {

    return GestureDetector (
            onTap:() {
              if (!gestureResign) {
                print("$index cell pop  ! ");
                _cellAction(index);
              }
            },
            onPanDown:(_) {
              if (_hasOpenedCell ) {
                fireCloseCellEvent();
                gestureResign = true;
              } else {
                gestureResign = false;
              }
            },
              child: Container(
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
              ),
      );
  }

  _cellAction(int index) {
    // ignore: unnecessary_statements
    Widget builderWidget;
    if (index == 0) {
      builderWidget = DetailPage(pagIndex: index);
    } else {
      builderWidget = AbsorbDetailPage(pagIndex: index);
    }
    Navigator.push(context, MaterialPageRoute(builder: (context)=> builderWidget));
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

class AllowMultipleGestureRecognizer extends MultiTapGestureRecognizer {

  int tapTimes = 0;

  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
    print('the pointer is $pointer');
  }

}


class NotAllowMultipleGestureRecognizer extends HorizontalDragGestureRecognizer {
  @override
  void rejectGesture(int pointer) {//acceptGesture(pointer);
//    print('ABABABABAB the pointer is $pointer');
    acceptGesture(pointer);
  }

}