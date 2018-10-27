import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:reddit_app/apiservice.dart';
import 'package:reddit_app/listings/link.dart';

class LinkPage extends StatefulWidget {
  final Link link;
  final ApiService apiService;
  const LinkPage({Key key, this.link, this.apiService}) : super(key: key);

  @override
  LinkPageState createState() {
    return new LinkPageState();
  }
}

class LinkPageState extends State<LinkPage> {
  final _flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  void dispose() {
    _flutterWebviewPlugin.close();
    super.dispose();
  }

  _launchLinkURL() {
    _flutterWebviewPlugin.launch(widget.link.url);
  }

  @override
  Widget build(BuildContext context) {
    final postImage = Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.orange),
        ),
        child: widget.link.thumbnail == null
            ? Icon(Icons.comment)
            : Image.network(
                widget.link.thumbnail,
                fit: BoxFit.cover,
              ));

    final summary = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: _launchLinkURL,
              child: Text(
                widget.link.url,
                overflow: TextOverflow.fade,
                softWrap: false,
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.link),
              onPressed: _launchLinkURL,
            ))
      ],
    );

    final body = Container(
      child: Text(widget.link.selftext),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.link.title,
          softWrap: true,
          overflow: TextOverflow.fade,
        ),
      ),
      body: Card(
        elevation: 4.0,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[postImage, summary, body],
        ),
      ),
    );
  }
}
