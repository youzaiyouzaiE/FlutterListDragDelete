import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class WeekChoiceDialog {
  ///checked constants int ==> [DateTime.monday] ~ [DateTime.sunday]
  static Future<List<int>> show(BuildContext context, {List<int> defChecked}) async {

    List<int> checked = defChecked ?? List();

    double  windowHeight = ui.window.physicalSize.height /MediaQuery.of(context).devicePixelRatio;

    double contentHeight =  (windowHeight *2/3) < 420 ? 420 :(windowHeight *2/3);

    return await showModalBottomSheet<List<int>>(
        context: context,
        backgroundColor:Colors.transparent,
        builder: (BuildContext context) {
          return
            Container(
              height: contentHeight,
//              color: Colors.red,
              child:Stack(
                children: <Widget>[
                  Container(///顶部圆角
                    height: contentHeight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  ),
                  Container(///Content view
                    margin: EdgeInsets.only(top: 15,right: 15,left: 15),
                    child: Column(
                      children: <Widget>[
                        Row( ///顶部Title 等
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 0,
                            ),
                            Container(
                              child: Text("选择可售星期",style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 20
                              ),),
                            ),
                            Container (
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
//                                color: Colors.red,
                                image: DecorationImage(
                                    image:AssetImage("images/close.png"),
                                    fit: BoxFit.fill,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: FlatButton(
                                onPressed: (){
                                  Navigator.pop(context, checked);
                                },
                                color: Colors.transparent,
                              ),
                            )
                          ],
                        ),
                        Expanded(///TableView
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 35),
                            child: WeekChoiceContentWidget(defChecked: checked,),
                          ),
                        ),
                        Container( /// button
                          child: GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Text('选择',
                                style: TextStyle(
                                    color:  Color(0xFFFFFFFF),
                                    fontSize: 16
                                ),
                              ),
                              width: double.infinity,
                              color: Color(0xFF4785FF),
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.center,
                            ),
                            onTap: (){
                              Navigator.pop(context, checked);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ) ;
        },
        isScrollControlled: true);
  }
}

class WeekChoiceContentWidget extends StatefulWidget{

  final List<int> defChecked;

  final void Function(List<int>) onChanged;

  WeekChoiceContentWidget({this.defChecked, this.onChanged, Key key}) : super (key : key);

  @override
  State<StatefulWidget> createState() {
    return WeekChoiceContentWidgetState();
  }
}

class WeekChoiceContentWidgetState extends State<WeekChoiceContentWidget>{

  ValueNotifier<List<int>> checked ;

  @override
  void initState() {
    checked = ValueNotifier(widget.defChecked);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> items = List();
    for(int i = 0 ; i < 7 ; i++){
      items.add(buildItem(i));
    }
    return Container(
      child: Column(
        children: items,
      ),
    );
  }

  Widget buildItem(int index){
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
          child:
          Container (
            height: 40,
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
//                height: 0,
                ),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text(_getWeekName(index)),
                      ),
                      Container(
                          child: checked.value.contains(index +1)
                              ? Icon(Icons.check_circle,size : 25 ,color: Color(0xFF4785FF),)
                              : Icon(Icons.radio_button_unchecked, size : 25 ,color:  Color(0xFF999999),)
                      )
                    ],
                  ),
                ),
                Container(
                  height: 0.5,
                  color:Colors.green,
//                color:Color(0xFFE5E5E5),
                ),
              ],
            ),
          ),
        onTap: (){
          int checkIndex = index + 1;
          if(checked.value.contains(checkIndex)){
             checked.value.remove(checkIndex);
          } else {
            checked.value.add(checkIndex);
          }
          invalidate();
        },
      ),
      flex: 1,
    );
  }

  String _getWeekName(int index){
    switch(index){
      case 0:
        return "星期一";
      case 1:
        return "星期二";
      case 2:
        return "星期三";
      case 3:
        return "星期四";
      case 4:
        return "星期五";
      case 5:
        return "星期六";
      case 6:
        return "星期日";
    }
    return "";
  }
  void invalidate() {
    setState(() {});
  }
}