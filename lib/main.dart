import 'package:flutter/material.dart';
import 'package:tinyurl/shorten.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

void main() => runApp(TinyUrlApp());

class TinyUrlApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Tiny URL",
        home: new ShortenUrlScreen(),
        theme: ThemeData(
          // Define the default Brightness and Colors
          brightness: Brightness.light,
          primaryColor: Colors.green,
          accentColor: Colors.green,

          fontFamily: 'Montserrat',

          // textTheme: TextTheme(
          //   headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          //   title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          //   body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          // ),
        ));
  }
}

class ShortenUrlScreen extends StatefulWidget {
  ShortenUrlScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State createState() => new ShortenUrlScreenState();
}

const APP_VERSION = 'v3.0.0';
const APP_NAME = 'TinyURL';
final headerAppLogo = Image.asset('images/headerAppLogo.png',fit: BoxFit.cover);
const APP_DESCRIPTION =
    'An app to shorten long urls and share shortened urls easily.'
    '\n\nDeveloped by chankruze';
const GOOGLEPLAY_URL =
    'https://play.google.com/store/apps/details?id=com.geekofia.tinyurl';
const GITHUB_URL = 'https://github.com/chankruze/TinyURL';
const AUTHOR_SITE = 'http://chankruze.github.io';

class ShortenUrlScreenState extends State<ShortenUrlScreen> {
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Tiny URL : URL Shortener")),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.orange),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: headerAppLogo,
                  ),
                  Text(
                    APP_NAME,
                    style: Theme.of(context).textTheme.title,
                  ),
                  Text(
                    '$APP_VERSION',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.shop),
              title: Text('Rate on Google Play'),
              onTap: () => url_launcher.launch(GOOGLEPLAY_URL),
            ),
            ListTile(
              leading: Icon(Icons.code),
              title: Text('Source code on GitHub'),
              onTap: () => url_launcher.launch(GITHUB_URL),
            ),
            ListTile(
              leading: Icon(Icons.open_in_new),
              title: Text('Visite my website'),
              onTap: () => url_launcher.launch(AUTHOR_SITE),
            ),
            Divider(),
            ListTile(
              title: Text("About"),
              trailing: IconButton(
                icon: Icon(Icons.info),
                onPressed: () {
                  showAboutDialog(
                      context: context,
                      applicationName: APP_NAME,
                      applicationVersion: APP_VERSION,
                      children: <Widget>[Text(APP_DESCRIPTION)]);
                },
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Image.asset(
            'images/isgdlogo.jpg',
            fit: BoxFit.cover,
          ),
          ShortenedUrl(),
        ],
      ),
    );
  }
}
