import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_app1/bottom_tab_bar/bottom_tab_bar.dart';

class SimpleListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'get list data',
          style: new TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                print("da nhan");
                goToBottomTabScreen(context);
              })
        ],
      ),
      body: new ListDataScreen(),
    );
  }
}

void goToBottomTabScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => BottomTabBar()),
  );
}

class ListDataScreen extends StatefulWidget {
  @override
  State createState() => new ListDataScreenState();
}

class ListDataScreenState extends State<ListDataScreen> {
  List data;

  Future<Null> fetchData() async {
    final response = await http.get(
        'https://api.stackexchange.com/2.2/questions?sort=activity&site=stackoverflow');
    this.setState(() {
      data = json.decode(response.body)['items'];
    });
  }

  void openBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    if (data != null) {
      return new RefreshIndicator(
        child: new ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return new Container(
              child: new Card(
                child: new FlatButton(
                  /*onPressed: () =>
                    openBrowser(data[index]['link']),*/
                  onPressed: () {
                    var url = data[index]['link'];
                    print('url $url');
                    openBrowser(url);
                  },
                  padding: new EdgeInsets.all(0.0),
                  child: new Row(
                    children: <Widget>[
                      new Container(
                        width: 40.0,
                        height: 40.0,
                        margin: new EdgeInsets.all(10.0),
                        decoration: new BoxDecoration(
                            image: new DecorationImage(
                                image: new NetworkImage(
                                    data[index]['owner']['profile_image']),
                                fit: BoxFit.cover),
                            shape: BoxShape.circle),
                      ),
                      new Flexible(
                          child: new Container(
                        child: new Text(
                          data[index]['title'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        margin: new EdgeInsets.all(10.0),
                      )),
                    ],
                  ),
                ),
              ),
              margin: new EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
            );
          },
          padding: new EdgeInsets.only(top: 10.0, bottom: 10.0),
          itemCount: data.length,
        ),
        onRefresh: fetchData,
      );
    } else {
      return new Center(child: new CircularProgressIndicator());
    }
  }
}
