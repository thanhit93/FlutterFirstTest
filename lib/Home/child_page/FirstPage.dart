import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstPageScreen(),
    );
  }
}

class FirstPageScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return FirstPageState();
  }
}

class FirstPageState extends State<FirstPageScreen>{
   List<DropdownMenuItem<String>> listDrop = List();
  String _selecttion;
  @override
  void initState() {
    loadDataDropdown();
    // TODO: implement initState
    super.initState();

  }

  void loadDataDropdown(){
    if(listDrop.length == 0) {
      listDrop.add(new DropdownMenuItem(
          child: DropdownMenuItem(child: Text("item 1"), value: 'thanh',)));
      listDrop.add(new DropdownMenuItem(
          child: DropdownMenuItem(child: Text("item 2"), value: 'truong',)));
      listDrop.add(new DropdownMenuItem(
          child: DropdownMenuItem(child: Text("item 3"), value: 'thsbf',)));
      print(listDrop.elementAt(0).child);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(listDrop.elementAt(0).value);
    // TODO: implement build
    return new Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /*TabBarView(
                controller: controller,
                children: <Widget>[
                ]
            )*/
            Text('First Page to test'),
            GestureDetector(
                onTap: () {
                  _showDialog(context);
                },
                child: Container(
                  color: Colors.red,
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  height: 40.0,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Show dialog",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )
                      ]),
                )),
            GestureDetector(
                onTap: () {
                  _showCustomAlertDialog(context);
                },
                child: Container(
                  color: Colors.blue,
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  height: 40.0,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Show dialog with custom",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )
                      ]),
                )),
            Row(
              children: <Widget>[
                Expanded(child: Container(
                    height: 40.0,
                    color: Colors.blue,
                    child: DropdownButton(items: listDrop, onChanged: (value){
                      print('test list ${listDrop.elementAt(0)}');
                      print('test drop down $value');
                      _selecttion = value;
                    })),),

              ],
            ),

          ],
        ));
  }

}



void _showDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: null, // no title
          content: Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(onPressed: null, child: Text("Cancel")),
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

void _showCustomAlertDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: null, // no title
          content: Container(
            width: 260.0,
            height: 230.0,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              /*color: const Color(0xFFFFFF),*/
              borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Container(
                          decoration: new BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: new Text(
                            'Rate',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontFamily: 'helvetica_neue_light',
                            ),
                            textAlign: TextAlign.center,
                          ))
                    ],
                  ),
                ),
                Expanded(
                  child: new Container(
                      child: new TextField(
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      filled: false,
                      contentPadding: new EdgeInsets.only(
                          left: 10.0, top: 10.0, bottom: 10.0, right: 10.0),
                      hintText: ' add review',
                      hintStyle: new TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12.0,
                        fontFamily: 'helvetica_neue_light',
                      ),
                    ),
                  )),
                  flex: 2,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    margin: EdgeInsets.only(left: 15.0, right: 15.0),
                    height: 40.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "data",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
}
