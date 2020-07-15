import 'package:covid19countrycheck/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> codeList = [
  'NewDeaths',
  'NewRecovered',
  'NewCases',
  'TotalCases',
  'TotalRecovered',
  'TotalTests',
  'TotalDeaths',
];

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  Box box = Box();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bangladesh\'s Corona Update'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Box(codename: codeList[0]),
                Box(codename: codeList[1]),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Box(codename: codeList[2]),
                Box(codename: codeList[3]),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Box(codename: codeList[4]),
                Box(codename: codeList[5]),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Box(codename: codeList[6]),
                Expanded(
                  child: RaisedButton(
                    child: Text(
                      'Refresh',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        RestartWidget.of(context).restartApp();
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Text(
            '©https://web.facebook.com/mirzashowvik',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
          Text(
            '©https://github.com/iamirzashowvik',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class Box extends StatefulWidget {
  Box({this.codename, this.color});
  final Color color;
  final String codename;

  @override
  _BoxState createState() => _BoxState();
}

class _BoxState extends State<Box> {
  int codevalue;

  Future getData(String code) async {
    String url =
        'http://covid19tracker.gov.bd/api/country/latest?onlyCountries=true&iso3=BGD#';
    http.Response response = await http.get(url);
    var decoder = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        codevalue = decoder[0][code];
      });

      return codevalue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () {
        getData(widget.codename).then((value) => codevalue);
      },
      child: Expanded(
        child: Container(
          height: double.infinity,
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            '${widget.codename} is $codevalue',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}

class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;
  const StatefulWrapper({@required this.onInit, @required this.child});
  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    if (widget.onInit != null) {
      widget.onInit();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
