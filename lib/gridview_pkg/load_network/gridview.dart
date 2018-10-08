import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app1/gridview_pkg/load_network/country.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryGridView extends StatelessWidget {
  final List<Country> country;

  CountryGridView({Key key, this.country}) : super(key: key);

  Card getStructuredGridCell(Country country) {
    return Card(
        elevation: 1.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            SvgPicture.network(
              country.flag.replaceAll('https', 'http'),
              height: 130.0,
              width: 100.0,
              placeholderBuilder: (BuildContext context) => Container(
                  alignment: Alignment.center,
                  height: 130.0,
                  /*padding: const EdgeInsets.all(50.0),*/
                  child: const CircularProgressIndicator()),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    country.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                    maxLines: 1,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Text(
                      country.nativeName,
                      style: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(country.capital),
                ],
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: true,
      crossAxisCount: 2,
      childAspectRatio: 0.80,
      children: List.generate(country.length, (index) {
        return getStructuredGridCell(country[index]);
      }),
    );
  }
}
