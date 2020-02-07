import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class PlayGround extends StatefulWidget {
  PlayGround({Key key}) : super(key: key);

  @override
  _PlayGroundState createState() => _PlayGroundState();
}

class _PlayGroundState extends State<PlayGround> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
    );
  }

  Widget get body {
    final html =
        '''<iframe src="https://www.scorebat.com/embed/" frameborder="0" width="600" height="760" allowfullscreen  allow="autoplay; fullscreen" style="width:600px;height:760px;overflow:hidden;display:block;" class="_scorebatEmbeddedPlayer_"></iframe><script>(function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = 'https://www.scorebat.com/embed/embed.js?v=mdwr';
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'scorebat-jssdk'));</script>''';
    return HtmlWidget(
      html,
      webView: true,
      webViewJs: true,
    );
  }
}
