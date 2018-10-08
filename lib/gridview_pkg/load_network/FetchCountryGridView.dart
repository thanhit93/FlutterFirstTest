import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/gridview_pkg/load_network/country.dart';
import 'package:flutter_app1/gridview_pkg/load_network/gridview.dart';
import 'package:flutter_app1/gridview_pkg/load_network/networklayer.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new FetchCountryGridView());

class FetchCountryGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'World';
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: new ThemeData(
        primaryColor: const Color(0xFF02BB9F),
        primaryColorDark: const Color(0xFF167F67),
        accentColor: const Color(0xFFFFAD32),
      ),
      home: new HomePage(title: appTitle),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;
  HomePage({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title,
          style: new TextStyle(
            color: const Color(0xFFFFFFFF),
          ),
        ),
      ),
      body: new FutureBuilder<List<Country>>(
        future: fetchCountry(new http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? new CountryGridView(country: snapshot.data)
              : new Center(child: new CircularProgressIndicator());
        },
      ),
    );
  }
}