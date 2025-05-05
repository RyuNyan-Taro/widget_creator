// test/blog_service_test.dart
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:widget_creator/features/nyantaro_blog/services/blog_service.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late BlogService blogService;
  late MockHttpClient mockHttpClient;

  setUpAll(() async {
    registerFallbackValue(Uri.parse('https://example.com'));
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    blogService = BlogService(apiKey: "dummyKey", client: mockHttpClient);
  });

  group('BlogService', () {
    test('fetchBlogPost returns BlogPost when http call completes successfully',
        () async {
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
      expect(result?.description,
          equals('Test content with some text that is long enough...'));
      expect(result?.content,
          equals('Test content with some text that is long enough'));
      expect(result?.date, equals('2024-03-20'));
      expect(result?.readTime, equals('1 min read'));
      expect(result?.id, equals('test-id'));
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
