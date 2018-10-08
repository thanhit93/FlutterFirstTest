import 'package:flutter/material.dart';
import 'swiper_pkg/swiper.dart';
import 'listview_pkg/ExpansionTile.dart';
import 'listview_pkg/SimpleListView.dart';
import 'listview_pkg/LoadMoreListView.dart';
import 'package:flutter_app1/gridview_pkg/load_local/SimpleGridView.dart';
import 'package:flutter_app1/gridview_pkg/load_network/FetchCountryGridView.dart';
import 'package:flutter_app1/Home/Home.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Color color = Theme.of(context).primaryColor;
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            new Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(15.0),
                          height: 40.0,
                          color: Colors.pink,
                          child: RaisedButton(onPressed: (){
                             Navigator.push(context, MaterialPageRoute( builder: (context) => Home()));
                          }, child: Text("Home Screen", style: TextStyle(color: Colors.white),),)
                        )
                      ],
                    )),
                Container(
                  height: 200.0,
                  margin: EdgeInsets.only(right: 40.0),
                  child: Text(
                    "test",
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w400,
                      color: color,
                    ),
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                )
              ],
            ),
            new Row(
              children: <Widget>[
                Expanded(
                    child: new GestureDetector(
                        onTap: () {
                          print("Container clicked");
                          Navigator.push(
                            context,
                            // MaterialPageRoute(builder: (context) => SwipeScreen()),
                            //MaterialPageRoute(builder: (context) => ExpansionTileSample()),
                            // MaterialPageRoute(builder: (context) => SimpleListView()),
                            MaterialPageRoute(
                                builder: (context) => LoadMoreListView()),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(15.0),
                              color: Colors.black26,
                              child: Text(
                                "haha",
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.red,
                                  background: new Paint()
                                    ..color = color
                                    ..strokeCap = StrokeCap.round
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 1.0,
                                ),
                              ),
                            )
                          ],
                        ))),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 15.0),
                      child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute( builder: (context) => LoadMoreListView()),
                            );
                          },
                          child: Text(
                            "Go to List view page",
                            style: TextStyle(color: Colors.white),
                          ),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0))),
                    )
                  ],
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                        height: 50.0,
                        margin: EdgeInsets.all(30.0),
                        color: color,
                        child: FlatButton(
                          onPressed: () {
                             //gôt page grid view
                            Navigator.push(context, MaterialPageRoute( builder: (context) => FetchCountryGridView()));
                          },
                          child: Text("hihi"),
                        ))),
                Container(
                  margin: EdgeInsets.only(right: 15.0),
                  child: RaisedButton(
                      child: new Text(
                        "Go to Gridview page",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w900),
                      ),
                      color: Colors.red,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SimpleGridView()),
                        );
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0))),
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
