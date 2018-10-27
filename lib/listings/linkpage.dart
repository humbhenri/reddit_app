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
  bool _commentsAreaExpanded = false;

  @override
  void dispose() {
    _flutterWebviewPlugin.close();
    super.dispose();
  }

  _launchLinkURL() {
    _flutterWebviewPlugin.launch(widget.link.url);
  }

  _expandCommentsArea() {
    print('blah');
    setState(() {
      _commentsAreaExpanded = true;
    });
  }

  _expandSummaryArea() {
    setState(() {
      _commentsAreaExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final postImage = Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.orange),
        ),
        child: (widget.link.thumbnail == null || _commentsAreaExpanded)
            ? Container()
            : Image.network(
                widget.link.thumbnail,
                fit: BoxFit.cover,
              ));

    final urlRow = Row(
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

    final comments = Expanded(
      child: GestureDetector(
        onTap: _expandCommentsArea,
        child: ListView.builder(
          itemCount: widget.link.comments.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                Divider(
                  height: 5.0,
                ),
                ListTile(
                  title: Text(widget.link.comments[index].body),
                )
              ],
            );
          },
        ),
      ),
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
      body: Column(
        children: <Widget>[
          Card(
            elevation: 4.0,
            child: GestureDetector(
              onTap: _expandSummaryArea,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[postImage, urlRow, body],
              ),
            ),
          ),
          comments
        ],
      ),
    );
  }
}
