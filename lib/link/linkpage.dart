import 'package:flutter/material.dart';
import 'package:reddit_app/apiservice.dart';
import 'package:reddit_app/link/link.dart';
import 'package:reddit_app/link/summarywidget.dart';

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
  bool _commentsAreaExpanded = false;

  _expandCommentsArea() {
    setState(() {
      _commentsAreaExpanded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.link.title,
          softWrap: true,
          overflow: TextOverflow.fade,
        ),
      ),
      body: Column(
        children: <Widget>[SummaryWidget(widget.link, _commentsAreaExpanded), comments],
      ),
    );
  }
}
