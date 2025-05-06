import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LinkScreen extends StatefulWidget {
  const LinkScreen({super.key, required this.url});

  final String url;

  @override
  State<LinkScreen> createState() => _LinkScreenState();
}

class _LinkScreenState extends State<LinkScreen> {
  late WebViewController controller = WebViewController()
    ..loadRequest(Uri.parse(widget.url));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Article Page'),
        ),
        body: WebViewWidget(controller: controller));
  }
}
