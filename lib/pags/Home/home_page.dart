import 'package:expanded_sample/Event/biz_eventbus.dart';
import 'package:expanded_sample/Event/normal_events.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../Widget/slide_widget.dart';
import 'Detail/absorb_detail_page.dart';
import 'Detail/detail_page.dart';


class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  bool _hasOpenedCell = false;
  int _openedCellIndex = -1;

  bool gestureResign = false;
  int tapNumber = 0;

  List <String> titles;


  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    titles = ['自定义手势事件','屏蔽点击事件：AbsorbPointer & IgnorePointer','anmiation'];
  }

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
              _setCellDragStatus();
            },
            onPointerUp: (_){
              tapNumber -=1;
              _setCellDragStatus();
            },

            child:_listViewBuild(),
          ),
        )
    );
  }

  void _setCellDragStatus() {
    setState(() {
      tapNumber = tapNumber;
      gestureResign = gestureResign;
    });
  }

  Widget _listViewBuild() {
    return
      ListView.separated(
          addRepaintBoundaries: true,
          itemCount: titles.length,
          itemBuilder:(BuildContext context, int index) {///Cell
            return _slideItems(index);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Container(///线
              height: 0.5,
              color: index == 0 ? Colors.white:Colors.black26,
            );
          }
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
            titles[index],
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
    String title = titles[index];
    if (index == 0) {
      builderWidget = DetailPage(pagIndex: index, title:title);
    } else {
      builderWidget = AbsorbDetailPage(pagIndex: index, title:title);
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