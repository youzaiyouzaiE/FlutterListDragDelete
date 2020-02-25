
import 'package:expanded_sample/Event/biz_eventbus.dart';
import 'package:expanded_sample/Event/event_bus.dart';
import 'package:expanded_sample/Event/normal_events.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SlideButton extends StatefulWidget {
  final int index;
  final Widget child;
  final List<Widget> buttons;
  final GlobalKey<SlideButtonState> slideButtonKey;
  final double singleButtonWidth;//

  final VoidCallback onSlideStarted;
  final VoidCallback onSlideCompleted;
  final VoidCallback onSlideCanceled;

  final int canDragNumber;///1,0 可以 drag , >1 不可

  SlideButton({this.slideButtonKey,
        @required this.child,
        @required this.singleButtonWidth,
        @required this.buttons,
        this.canDragNumber,
        this.index,
        this.onSlideStarted,
        this.onSlideCompleted,
        this.onSlideCanceled,
        })
      : super(key: slideButtonKey);

  @override
  State<StatefulWidget> createState() {
    return SlideButtonState();
  }

}

class SlideButtonState extends State<SlideButton> with TickerProviderStateMixin {

  bool _ignoreEven = false;

  bool isOpened = false;
  double translateX = 0;
  double maxDragDistance;
  final Map<Type, GestureRecognizerFactory> gestures =
  <Type, GestureRecognizerFactory>{};

  VoidCallback closedCallBack;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    maxDragDistance = widget.singleButtonWidth * widget.buttons.length;
    gestures[HorizontalDragGestureRecognizer] =
        GestureRecognizerFactoryWithHandlers<HorizontalDragGestureRecognizer>(
              () => HorizontalDragGestureRecognizer(debugOwner: this),
              (HorizontalDragGestureRecognizer instance) {
            instance
              ..onDown = onHorizontalDragDown
              ..onUpdate = onHorizontalDragUpdate
              ..onEnd = onHorizontalDragEnd;
          },
        );
    animationController = AnimationController(
        lowerBound: -maxDragDistance,
        upperBound: 0,
        vsync: this,
        duration: Duration(milliseconds: 100))
      ..addListener(() {
        translateX = animationController.value;
        setState(() {});
      });

    EventBusInstance().bus.on<CloseOpenedCellEvent>().listen((_) async {
      int index = _.closeIndex;
      if (index == widget.index && isOpened) {
        _closeCell();
        isOpened = false;
      }
    });
  }

  bool _closeCell() {
    animationController.animateTo(0).then((_) {
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if(widget.canDragNumber>1) {
      translateX = 0;
//      print('--------------000000000000000000000000------------------------- cell');
    }
    return  Stack(
          children: <Widget>[
            Positioned.fill(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:widget.buttons,
                )
            ),
            RawGestureDetector(
              gestures: gestures,
              child: Transform.translate(
                offset:Offset(translateX, 0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: widget.child,
                    )
                  ],
                ),
              ),
            )
          ],
    );
  }

  void onHorizontalDragDown(DragDownDetails details) {
    if (widget.onSlideStarted != null) widget.onSlideStarted.call();
  }

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    translateX = (translateX + details.delta.dx).clamp(-maxDragDistance, 0.0);
    setState(() {});
  }

  void onHorizontalDragEnd(DragEndDetails details) {
    animationController.value = translateX;
    if (details.velocity.pixelsPerSecond.dx > 200) {
      close();
    } else if (details.velocity.pixelsPerSecond.dx < -200) {
      open();
    } else {
      if (translateX.abs() > maxDragDistance / 2) {
        open();
      } else {
        close();
      }
    }
  }

  void open() {
    if (translateX != -maxDragDistance) {
      animationController.animateTo(-maxDragDistance).then((_) {
      });
    }
    isOpened = true;
    if (widget.onSlideCompleted != null) {
      widget.onSlideCompleted.call();
    }
  }

  void close() {
    if (translateX != 0) {
      animationController.animateTo(0).then((_) {
      });
    }
    isOpened = false;
//    CellCloseNotification(opened:false).dispatch(context);
    if (widget.onSlideCanceled != null) {
      widget.onSlideCanceled.call();
    }
  }


  void changeIgnoreEven(bool isIgnore) {
    setState(() {
      _ignoreEven = isIgnore;
      if (_ignoreEven) {
        print("不能拖动！！");
      } else {
        print("能拖动！！");
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

}


///InheritedWidget 共享数据
class ShareDataWidget extends InheritedWidget {
  ShareDataWidget({
    @required this.openedItemIndex,
    Widget child
  }) :super(child: child);

  final int openedItemIndex;

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static ShareDataWidget of (BuildContext context) {
    return context.inheritFromWidgetOfExactType(ShareDataWidget);
  }

  @override
  bool updateShouldNotify(ShareDataWidget old) {
    //如果返回true，则子树中依赖(build函数中有调用)本widget
    //的子widget的`state.didChangeDependencies`会被调用
    return old.openedItemIndex != openedItemIndex;
  }

}


///Notification 冒泡事件
class CellCloseNotification extends Notification {
   bool opened = false;
   CellCloseNotification({this.opened});
}

class NotificationCellCloseListener <T extends CellCloseNotification> extends StatefulWidget {

  final Widget child;
  final NotificationListenerCallback<T> onNotification;

  const NotificationCellCloseListener ({
    Key key,
    @required this.child,
    this.onNotification,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NotificationCellCloseListenerState();
  }
}

class NotificationCellCloseListenerState extends State <NotificationCellCloseListener>
{
  @override
  Widget build(BuildContext context) => widget.child;
}