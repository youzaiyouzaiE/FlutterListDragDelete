import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:path/path.dart' as p;


class LoginPage extends StatefulWidget {
//  LoginPage({Key key, this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _LoginState();
}


class _LoginState extends State <LoginPage> {
  double width;
  double height;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _accountController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  void initState() {
    super.initState();

  }

  Future<String> getFilePath() async {
    var directory = await getTemporaryDirectory();
    return p.join(directory.path, "your_directory_name");
  }

  static MethodChannel _channel = MethodChannel('plugins.flutter.io/path_provider');

  Future<Directory> getTemporaryDirectory() async {
    final String path =
    await _channel.invokeMethod<String>('getTemporaryDirectory');
    if (path == null) {
      return null;
    }
    return Directory(path);
  }


  Future <File> getSingleFile(String url){
    return null;
  }

  _pushToHomePage(BuildContext buildContext) {
//    HomePage page = new HomePage();
//    Navigator.push(context, new MaterialPageRoute(builder: (context)=> page));
  }

  @override
  Widget build(BuildContext context) {
//    Color color = Theme.of(context).primaryColor;
    final size = MediaQuery.of(context).size;
    this.width = size.width;
    this.height = size.height;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: false,
//        padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
        physics: BouncingScrollPhysics(),
        child: Container(
          height: height,
          padding:new EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
          color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
              Container (
                  padding: EdgeInsets.only(bottom: 10.0),
                  height: 80,
                  color: Colors.blue[400],
                  child:_inputItem(Icons.supervisor_account,'账号:', false, _accountController)
              ),
              Container (
                  padding: EdgeInsets.only(top: 20.0),
                  height: 90,
                  color: Colors.orange,
                  child:_inputItem(Icons.https, '密码:', true, _passwordController)
              ),
              Container (
                padding: EdgeInsets.fromLTRB(20, 80, 20, 30),
                width: width - 20 *2,
                color: Colors.brown[300],
                child: new RaisedButton (
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  shape: const RoundedRectangleBorder(
                      side: BorderSide(width: 1,color: Colors.blueGrey),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  color: Colors.white,
                  splashColor: Colors.green,
                  onPressed:() => _pushToHomePage(context),
                  child: Text("登 录",
                    style: new TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputItem(IconData icon, String label, bool secure, TextEditingController controller) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children:[
        new Icon(icon, color: Colors.white),
        new Container (
          padding: EdgeInsets.only(left: 10.0),
          width: 60,
          child: new Text(label,
            style: new TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
        new Expanded(
          child: new TextField(
            controller: controller,
//            onChanged: ,
            obscureText: secure,
            style: TextStyle(
                fontSize: 24,
                color: Colors.white
            ),
          ),
        ),
      ],
    );
  }
}