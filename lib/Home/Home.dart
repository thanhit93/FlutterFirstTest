import 'package:flutter/material.dart';
import 'package:flutter_app1/Home/child_page/FirstPage.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BoT',
          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                      padding: EdgeInsets.only(left: 15.0, top: 15.0, bottom: 15.0),
                      color: Colors.blueAccent,
                      child: Text(
                        "data",
                        style: TextStyle(
                          fontSize: 17.0,
                        ),
                        textDirection: TextDirection.ltr,
                      )),
                )
              ],
            )
          ],
        ),
      ),
      body: new HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}


class _HomeState extends State<HomeScreen> {
  int _currentIndex = 0;
  static List<DropdownMenuItem<String>> listDrop = [];
  final List<Widget> _children = [
    FirstPage(getDrop()),
    PlaceholderWidget(Colors.deepOrange),
    PlaceholderWidget(Colors.green)
  ];

  static List<DropdownMenuItem<String>> getDrop(){
    return listDrop;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDataDropdown();
  }

  @override
  Widget build(BuildContext context) {
    loadDataDropdown();
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            title: Text('Messages'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile'))
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void loadDataDropdown(){
    listDrop = [];
    listDrop.add(new DropdownMenuItem(child: DropdownMenuItem(child: Text("item 1"), value: "thanh",)));
    listDrop.add(new DropdownMenuItem(child: DropdownMenuItem(child: Text("item 2"), value: "truong",)));
    listDrop.add(new DropdownMenuItem(child: DropdownMenuItem(child: Text("item 3"), value: "thsbf",)));
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
