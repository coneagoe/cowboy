import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  /*
  late final String _iframeUrl;

  @override
  void initState() {
    super.initState();
    final htmlString = '''
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body style="margin:0;padding:0;">
  <iframe frameborder="0" width="830" height="580" scrolling="yes"
    src="https://rili-d.jin10.com/open.php?fontSize=14px&scrolling=yes&theme=primary">
  </iframe>
</body>
</html>
''';
    final encoded = base64Encode(const Utf8Encoder().convert(htmlString));
    _iframeUrl = 'data:text/html;base64,$encoded';
  }
  */

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      // 使用 IFrameElement（仅支持 Web 平台）
      final html.IFrameElement iframe = html.IFrameElement()
        ..src =
            'https://rili-d.jin10.com/open.php?fontSize=14px&scrolling=yes&theme=primary'
        ..width = '830'
        ..height = '580'
        ..style.border = 'none';

      // 注册视图
      // ignore: undefined_prefixed_name
      ui.platformViewRegistry.registerViewFactory(
        'iframe-calendar',
        (int viewId) => iframe,
      );

      return Scaffold(
        appBar: AppBar(
          title: const Text('calendar'),
        ),
        body: const HtmlElementView(viewType: 'iframe-calendar'),
      );
    } else {
      // 非 Web 平台简单回退处理
      return Scaffold(
        appBar: AppBar(
          title: const Text('Calendar'),
        ),
        body: const Center(
          child: Text('IFrameElement is only supported on Web'),
        ),
      );
    }
  }
}
