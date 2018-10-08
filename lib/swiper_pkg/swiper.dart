import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

void main() => runApp(new SwipeScreen());

class SwipeScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Swipe'),
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
  var images = ['images/bg0.jpeg', 'images/bg0.jpeg'];

  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("ExampleHorizontal"),
        ),
        body: new Swiper(
            itemBuilder: (BuildContext context, int index) {
              print(images[index]);
              return new Image.asset(
                images[index],
                fit: BoxFit.fill,
              );
            },
            index: _currentIndex,
            autoplay: true,
            itemCount: images.length,
            reverse: true,
            pagination: new SwiperPagination(),
            control: new SwiperControl(),
            onTap: (index) {
              print("Container clicked");
            },
            curve: Curves.elasticIn));
  }
}
