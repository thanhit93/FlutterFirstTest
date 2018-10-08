import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/scheduler.dart';

const int pageSize = 20;

class LoadMoreListView extends StatelessWidget {
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
              })
        ],
      ),
      body: new LoadMoreListViewScreen(),
    );
  }
}

class LoadMoreListViewScreen extends StatefulWidget {
  @override
  State createState() => new ListDataScreenState();
}

class ListDataScreenState extends State<LoadMoreListViewScreen> {
  List data = List();
  final scrollController = ScrollController();
  bool isLoading = false;

  //final scaffoldKey = GlobalKey<ScaffoldState>();
  int currentPage = 0;

  Future<List> fetchData(int page, int pageSize) async {
    var url =
        'https://api.stackexchange.com/2.2/questions?sort=activity&site=stackoverflow&page=$page&pageSize=$pageSize';
    print('test url $url');
    final response = await http.get(
        'https://api.stackexchange.com/2.2/questions?sort=activity&site=stackoverflow&page=$page&pageSize=$pageSize');
    List data = json.decode(response.body)['items'];
    return data;
  }

  @override
  void initState() {
    super.initState();
    loadData();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        loadMore();
      }
    });
  }

  void loadData() async {
    setState(() {
      isLoading = true;
    });
    final newData = await fetchData(1, pageSize);
    setState(() {
      data.addAll(newData);
      currentPage = 1;
      isLoading = false;
    });
  }

  loadMore() async {
    if (!isLoading) {
      setState(() => isLoading = true);
      /*if (data.length >= 79) {
        await Future.delayed(Duration(seconds: 3));
        setState(() => isLoading = false);
        //await makeAnimation();
        scaffoldKey.currentState?.showSnackBar(
          SnackBar(
            content: Text('Get max data!'),
          ),
        );
        return;
      }*/
      final newDatas = await fetchData(currentPage + 1, pageSize);
      int length = newDatas.length;
      print('test chieu dai mang mới: $length');
      setState(() {
        data.addAll(newDatas);
        isLoading = false;
        currentPage += 1;
      });
    }
  }

  makeAnimation() async {
    final offsetFromBottom =
        scrollController.position.maxScrollExtent - scrollController.offset;
    if (offsetFromBottom < 50) {
      await scrollController.animateTo(
        scrollController.offset - (50 - offsetFromBottom),
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    return Scaffold(
      //key: scaffoldKey,
      body: RefreshIndicator(
        child: ListView.builder(
          controller: scrollController,
          itemBuilder: (BuildContext context, int index) {
            if (index < data.length) {
              return Container(
                child: Card(
                  child: FlatButton(
                    /*onPressed: () =>
                    openBrowser(data[index]['link']),*/
                    onPressed: () {
                      var url = data[index]['link'];
                      print('url $url');
                    },
                    padding: EdgeInsets.all(0.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 40.0,
                          height: 40.0,
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(data[index]['owner']['profile_image'] != null
                                      ? data[index]['owner']['profile_image'] : ""),
                                  fit: BoxFit.cover),
                              shape: BoxShape.circle),
                        ),
                        Flexible(
                            child: Container(
                          child: Text(
                            data[index]['title'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          margin: EdgeInsets.all(10.0),
                        )),
                      ],
                    ),
                  ),
                ),
                margin: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
              );
            }
            if (isLoading) {
              return Center(
                child: Opacity(
                  //opacity: isLoading ? 1.0 : 0.0,
                  opacity: 1.0,
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          itemCount: data.length + 1,
        ),
        onRefresh: () async {
          data
            ..clear()
            ..addAll(await fetchData(1, pageSize));
          setState(() {
            currentPage = 1;
            isLoading = false;
          });
        },
      ),
    );
  }
}
