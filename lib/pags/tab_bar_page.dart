import 'package:expanded_sample/pags/Home/home_page.dart';
import 'package:expanded_sample/pags/Mine/mine_page.dart';
import 'package:expanded_sample/pags/Video/video_page.dart';
import 'package:flutter/material.dart';


class TabBarPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return TabBarState();
  }

  functionItemSelected() {}
}


//// TabBarView
class TabBarState extends State <TabBarPage>  {

  int _selectedIndex = 0;
  List<Widget> _pages = List<Widget>();
  List _tabImages;
  List <String> _titles;
  PageController _pageController ;



  @override
  void initState() {
    super.initState();
    _tabImages = [[Image.asset("images/icon_tab_home.png",fit: BoxFit.fill, width: 18, height: 18),Image.asset("images/icon_tab_home_select.png",fit: BoxFit.fill, width: 18, height: 18)],
                  [Image.asset("images/icon_tab_voice.png",fit: BoxFit.fill, width: 18, height: 18),Image.asset("images/icon_tab_voice_select.png",fit: BoxFit.fill, width: 18, height: 18)],
                  [Image.asset("images/icon_tab_mine.png",fit: BoxFit.fill, width: 18, height: 18),Image.asset("images/icon_tab_mine_select.png",fit: BoxFit.fill, width: 18, height: 18)]];
    _titles = ['首页','视频','我'];
    _pages = [HomePage(),VideoPage(),MinePage()];
    _pageController = PageController();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
//    _enterHomeEvent?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(),
      bottomNavigationBar: _getNavBar(),
    );
  }

  _getBody() {
    return PageView.builder(
      controller: _pageController,
      itemCount: _pages.length,
      itemBuilder: (context, index) {
        return _pages[index];
      },
      physics: NeverScrollableScrollPhysics(),
    );
  }

  _getNavBar() {
    return Theme(
      data: ThemeData(
        //可以去掉默认的水波纹效果
        brightness: Theme.of(context).brightness,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Container(
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 0,
            unselectedFontSize: 12,
            selectedFontSize: 12,
            selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.bold
            ),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: _tabImages[0][0],
                title: _tabTitle(0),
                  activeIcon: _tabImages[0][1]
              ),
              BottomNavigationBarItem(
                  icon: _tabImages[1][0],
                  title: _tabTitle(1),
                  activeIcon: _tabImages[1][1]
              ),
              BottomNavigationBarItem(
                  icon: _tabImages[2][0],
                  title: _tabTitle(2),
                  activeIcon: _tabImages[2][1]
              ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: (index) {
//              _changeTab(_currentIndex, index);
              _pageController.jumpToPage(index);
              setState(() {
                if(index == _selectedIndex) return;
                _selectedIndex = index;
              });
            },
          ),
          decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(0x46c0c1cf),
                  blurRadius: 5.0,
                ),
              ]
          )
      ),
    );
  }

 Widget _tabTitle(int index) {
    String strTitle = "";
    Color titleColor = Color.fromARGB(255, 150, 150, 150);
    if (index < _titles.length) {
      strTitle = _titles[index];
    }
//    if (curIndex == _currentIndex) {
//      titleColor = BizColors.COLOR_PRIMARY;
//    }
    return Text(
      strTitle,
      style: TextStyle(
        color: titleColor,
//        fontWeight: FontWeight.bold,
      ),
    );
  }

  BottomNavigationBarItem _getBottomNavBarItem(IconData iconData, String title, Color color) {
    return BottomNavigationBarItem (
      icon:Icon(iconData, color:color),
      title:Text(title, style: TextStyle(color: color),),
    );
  }

  Color _barColor(int barIndex, BuildContext context) {
    return  barIndex == _selectedIndex ? Theme.of(context).primaryColor : Colors.grey;
  }
}

