
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:intl/intl.dart';

class TimeChoiceDialog {

  static Future<Map<int,String>> show(BuildContext context) async {

    Map<int,String> selectedTime = Map();

    return await showModalBottomSheet<Map<int,String>>(
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
                          child: FlatButton(
                              child: Text('取消',
                                style: TextStyle(
                                    color:Color(0xFF4785FF),
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
                                Navigator.pop(context,selectedTime);
                              }
                          ),
                        ),
                      ],
                    ),
                  ),
                  TimeChoiceContentWidget(chooseTime: selectedTime),
                ],
              ),

            );
        },
        isScrollControlled: true);
  }
}


class TimeChoiceContentWidget extends StatefulWidget{

  final Map<int,String> chooseTime;

  TimeChoiceContentWidget({this.chooseTime, Key key}) : super (key : key);

  @override
  State<StatefulWidget> createState() {
    return TimeChoiceContentWidgetState();
  }
}

class TimeChoiceContentWidgetState extends State <TimeChoiceContentWidget> {

  int _currentSelectedItem; /// 1,start   2, end

  String _startTime = '开始时间';

  String _endTime = '结束时间';

  Map <int,String> chooseTime;

  @override
  void initState() {
    chooseTime = widget.chooseTime;
    _currentSelectedItem = 1;
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
                      child: Text(_startTime,
                        style: TextStyle(
                            color:_startTime =='开始时间'? Color(0xFF333333):Color(0xFF4785FF),
                            fontSize: 16
                        ),
                      ),
                      onPressed:_onPressedStart,
                  ),
                ),
                Container(
                  width: 21,
                  height: 1,
                  color:Color(0xFFCCCCCC),
                ),
                Container(
                  child: FlatButton(
                      child: Text(_endTime,
                        style: TextStyle(
                            color:_endTime == '结束时间'? Color(0xFF333333) : Color(0xFF4785FF),
                            fontSize: 16
                        ),
                      ),
                    onPressed:_onPressedEnd,
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
            Container(
              height: 170,
//                 padding: EdgeInsets.only(top: 20,left: 15),
              child: TimePickerWidget(dateFormat:'HH:mm',
//                initDateTime:DateTime.parse("2012-02-27 00:00"),
                  locale:DateTimePickerLocale.zh_cn,
                  pickerTheme:DateTimePickerTheme(showTitle: false),
                  onChange:_onSelectedChange,
              ),
            ),
        ],
      ),
    );
  }

  void _onPressedStart() {
    _currentSelectedItem = 1;
  }

  void _onPressedEnd() {
    _currentSelectedItem = 2;
  }

  void _onSelectedChange(DateTime dateTime, List<int> selectedIndex) {
    String formattedDate = DateFormat('HH:mm').format(dateTime);
    print('formattedDate:$formattedDate, dateTime: $dateTime , selectedIndex:$selectedIndex');
    if (_currentSelectedItem == 1) {
      _startTime = formattedDate;
    } else {
      _endTime = formattedDate;
    }
    chooseTime[_currentSelectedItem] = formattedDate;
    _invalidate();
  }

  void _invalidate() {
    setState(() {});
  }

}
