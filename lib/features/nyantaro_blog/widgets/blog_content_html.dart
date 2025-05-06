import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:widget_creator/shared/link_screen.dart';

class BlogContentHtml extends StatelessWidget {
  final String content;

  const BlogContentHtml({
    super.key,
    required this.content,
  });

  Map<String, Style> _getHtmlStyles() {
    return {
      "body": Style(
        fontSize: FontSize(16),
        lineHeight: LineHeight(1.8),
      ),
      "p": Style(
        margin: Margins(top: Margin(2)),
      ),
      "h1": Style(
        fontSize: FontSize(24),
        margin: Margins(top: Margin(16)),
      ),
      "h2": Style(
        fontSize: FontSize(20),
        margin: Margins(top: Margin(12)),
      ),
      "img": Style(
        width: Width(double.infinity),
        backgroundColor: Colors.grey[200],
      ),
      "pre": Style(
        backgroundColor: Colors.grey[100],
        padding: HtmlPaddings(top: HtmlPadding(8)),
        margin: Margins(top: Margin(8)),
      ),
      "code": Style(
        backgroundColor: Colors.grey[100],
        fontFamily: "monospace",
      ),
    };
  }

  void _handleLinkTap(BuildContext context, String? url, _, __) {
    if (url != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LinkScreen(url: url)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Html(
      data: content,
      style: _getHtmlStyles(),
      onLinkTap: (url, attrs, element) =>
          _handleLinkTap(context, url, attrs, element),
    );
  }
}
