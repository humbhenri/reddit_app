import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:reddit_app/link/link.dart';

class SummaryWidget extends StatefulWidget {
  final Link link;
  bool hideImage;

  SummaryWidget(this.link, this.hideImage);

  @override
  SummaryWidgetState createState() {
    return new SummaryWidgetState();
  }
}

class SummaryWidgetState extends State<SummaryWidget>
    with SingleTickerProviderStateMixin {
  final _flutterWebviewPlugin = new FlutterWebviewPlugin();
  final _originalImageHeight = 250.0;
  double _postImageHeight;

  @override
  void initState() {
    super.initState();
  }

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
    if (widget.hideImage) {
      _postImageHeight = 0.0;
    } else {
      if (widget.link.thumbnail != null) {
        _postImageHeight = _originalImageHeight;
      }
    }

    final imageWidget = (widget.link.thumbnail == null)
        ? Container()
        : Image.network(
            widget.link.thumbnail,
            fit: BoxFit.cover,
          );

    final postImage = AnimatedSize(
      vsync: this,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      child: Container(
          height: _postImageHeight,
          decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Colors.orange),
          ),
          child: imageWidget),
    );

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
    final body = Container(
      child: Text(widget.link.selftext),
    );
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.hideImage = false;
        });
      },
      child: Card(
        elevation: 4.0,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[postImage, urlRow, body],
        ),
      ),
    );
  }
}
