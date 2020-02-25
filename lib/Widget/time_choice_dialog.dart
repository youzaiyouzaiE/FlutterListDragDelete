
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';


class TimeChoiceDialog {

  static Future<List<int>> show(BuildContext context) async {

    return await showModalBottomSheet<List<int>>(
        context: context,
//        backgroundColor:Colors.transparent,
        builder: (BuildContext context) {
          return
            Container(
              height: 285,
//              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 50,
                    child: Row( ///顶部Title 等
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
//                                width: 70,
                          child: FlatButton(
                              child: Text('取消',
                                style: TextStyle(
                                    color:Color(0xFF4785FF),
//                                        fontFamily: ,
                                    fontSize: 16
                                ),
                              ),
                              onPressed: () => Navigator.pop(context)),
                        ),
                        Container(
                          child: Text("选择时间段",
                            style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 16
                            ),
                          ),
                        ),
                        Container(
//                                width: 70,
                          child: FlatButton(
                              child: Text('确定',
                                style: TextStyle(
                                    color:Color(0xFF4785FF),
                                    fontSize: 16
                                ),
                              ),
                              onPressed: (){
                                Navigator.pop(context);
                              }
                          ),
                        ),
                      ],
                    ),
                  ),
                  TimeChoiceContentWidget(),
                ],
              ),

            );
        },
        isScrollControlled: true);
  }
}


class TimeChoiceContentWidget extends StatefulWidget{

  final List<String> defaultTime;

  final void Function(List<int>) onChanged;

  TimeChoiceContentWidget({this.defaultTime, this.onChanged, Key key}) : super (key : key);

  @override
  State<StatefulWidget> createState() {
    return TimeChoiceContentWidgetState();
  }
}

class TimeChoiceContentWidgetState extends State <TimeChoiceContentWidget>{

  ValueNotifier<List<String>> checked ;

  @override
  void initState() {
//    checked = ValueNotifier(widget.defaultTime);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
//      color: Colors.red,
//      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 60,
            color: Colors.white,
            child: Row( ///顶部Title 等
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(),
                Container(
                  child: FlatButton(
                      child: Text('开始时间',
                        style: TextStyle(
                            color:Color(0xFF4785FF),
//                                        fontFamily: ,
                            fontSize: 16
                        ),
                      ),
                      onPressed:(){

                      },
                  ),
                ),
                Container(
                  width: 21,
                  height: 1,
                  color:Color(0xFFCCCCCC),
                ),
                Container(
                  child: FlatButton(
                      child: Text('结束时间',
                        style: TextStyle(
                            color:Color(0xFF4785FF),
                            fontSize: 16
                        ),
                      ),
                      onPressed: (){

                      }
                  ),
                ),
                Container(),
              ],
            ),
          ),
          Container(
            height: 0.5,
            color: Color(0xFFE5E5E5),
          ),
//          Expanded(
//            child:
            Container(
              height: 170,
//                 padding: EdgeInsets.only(top: 20,left: 15),
              child: TimePickerWidget(dateFormat:'HH:mm',
//                initDateTime:DateTime.parse("2012-02-27 00:00"),
                  locale:DateTimePickerLocale.zh_cn,
                  pickerTheme:DateTimePickerTheme(showTitle: false),
                  onChange:(DateTime dateTime, List<int> selectedIndex) {
                  print('dateTime: $dateTime , selectedIndex:$selectedIndex');
                },
              ),
            ),
//          )
        ],
      ),
    );
  }

  void invalidate() {
    setState(() {});
  }
}
