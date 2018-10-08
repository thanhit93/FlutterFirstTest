import 'package:flutter/material.dart';

class SimpleGridView extends StatelessWidget {
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
      body: new SimpleGridViewScreen(title: "GridView of Images"),
    );
  }
}

class SimpleGridViewScreen extends StatefulWidget {
  final String title;

  // Custom constructor, add property : title
  @override
  SimpleGridViewScreen({this.title}) : super();

  @override
  State createState() => new SimpleGridViewState();
}

class SimpleGridViewState extends State<SimpleGridViewScreen> {
  //State must have "build" => return Widget
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      /*appBar: new AppBar(
        title: new Text(widget.title),
      ),*/
      body: new GridView.extent(
        maxCrossAxisExtent: 150.0,
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
        padding: const EdgeInsets.all(5.0),
        children: _buildGridTiles(29), //Where is this function ?
      ),
    );
  }
}

List<Widget> _buildGridTiles(numberOfTiles) {
  List<Container> containers =
      new List<Container>.generate(numberOfTiles, (int index) {
    //index = 0, 1, 2,...
    /* final imageName = index < 9 ?
        'images/image0${index + 1}.JPG' : 'images/image${index + 1}.JPG';*/
    /*return new Container(
          child: new Image.asset(
              imageName,
              fit: BoxFit.fill
          ),
        );*/
    return Container(
      width: 40.0,
      height: 40.0,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'http://anhdep.pro/wp-content/uploads/2015/10/hinh-anh-em-be-dang-yeu-.jpg',
                  scale: 0.5),
              fit: BoxFit.cover),
          shape: BoxShape.rectangle),
    );
  });
  return containers;
}
