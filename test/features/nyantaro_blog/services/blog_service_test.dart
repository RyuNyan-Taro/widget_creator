// test/blog_service_test.dart
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:widget_creator/features/nyantaro_blog/services/blog_service.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late BlogService blogService;
  late MockHttpClient mockHttpClient;

  setUpAll(() async {
    await dotenv.load(fileName: '.env');
    registerFallbackValue(Uri.parse('https://example.com'));
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    blogService = BlogService(client: mockHttpClient);
  });

  group('BlogService', () {
    test('fetchBlogPost returns BlogPost when http call completes successfully',
        () async {
      // モックの応答データを準備
      final mockResponseData = {
        'id': 'test-id',
        'title': 'Test Title',
        'content': 'Test content with some text that is long enough',
        'publishedAt': '2024-03-20T00:00:00Z',
      };

      when(() => mockHttpClient.get(
            any<Uri>(),
            headers: any(named: 'headers'),
          )).thenAnswer((_) async => http.Response(
            json.encode(mockResponseData),
            200,
          ));

      final result = await blogService.fetchBlogPost('test-id');

      expect(result, isNotNull);
      expect(result?.id, equals('test-id'));
      expect(result?.title, equals('Test Title'));
    });

    test('fetchBlogPost returns null when http call fails', () async {
      when(() => mockHttpClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer((_) async => http.Response('Not Found', 404));

      final result = await blogService.fetchBlogPost('non-existent-id');

      expect(result, isNull);
    });

    // todo: fetchBlogPosts のテストも同様に追加...
  });
}
