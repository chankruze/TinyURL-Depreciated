import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:share/share.dart';

class ShortenedUrl extends StatefulWidget {
  @override
  State createState() => new ShortenedUrlState();
}

class ShortenedUrlState extends State<ShortenedUrl> {
  final myController = TextEditingController();

  Map data;
  String longurl, shorturl;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (shorturl == null) {
      shorturl = " Will Appear Here !";
    } else {
      shorturl = shorturl;
    }

    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                new Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Enter Long URL Here"),
                      controller: myController,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(15.0),
              child: new RaisedButton(
                onPressed: () {
                  longurl = myController.text;
                  if (longurl == "") {
                    noURL(context);
                  } else {
                    getData(longurl);
                    myController.clear();
                  }
                },
                color: Theme.of(context).accentColor,
                splashColor: Colors.black,
                elevation: 15.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.content_cut,
                        color: Colors.white,
                      ),
                      Text(
                        "SHORTEN",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                child: new Text('Your Short URL : $shorturl',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0,),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FloatingActionButton(
                    onPressed: () =>
                        Clipboard.setData(new ClipboardData(text: "$shorturl")),
                    child: Icon(Icons.content_copy),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FloatingActionButton(
                    onPressed: () => Share.share(shorturl),
                    tooltip: 'Share Shortened URL !',
                    child: Icon(Icons.share),
                  ),
                ),
              ],
            ),
            SizedBox(height: 31.0),
            Center(
              child: Container(
                alignment: Alignment.bottomCenter,
                color: Theme.of(context).accentColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  child: Text(
                    "Developed With Love By Chankruze",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getData(myController.text);
  }

  Future getData(String longurl) async {
    http.Response response =
        await http.get("https://is.gd/create.php?format=json&url=$longurl");
    data = json.decode(response.body);
    setState(() {
      shorturl = data['shorturl'];
    });
  }

  void noURL(BuildContext context){
    var alertDialog = AlertDialog(
      title: Text("Error : No URL Provided"),
      content: Text("Enter An URL To Shorten !"),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) => alertDialog,
    );
  }
}
