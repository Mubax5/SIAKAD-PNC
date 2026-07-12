import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:siakad_app/main.dart';
import 'package:siakad_app/ui/halaman_jadwal.dart';

void main() {
  // Stub all network requests for the test environment to return a mock image response
  setUpAll(() {
    HttpOverrides.global = MockHttpOverrides();
  });

  testWidgets('Login page smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: AplikasiSiakad()));

    // Verify that the login page elements exist.
    expect(find.textContaining('SIAKAD'), findsOneWidget);
    expect(find.text('Log in'), findsOneWidget);
    expect(find.text('NPM'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });

  testWidgets('Jadwal page rendering and toggle test', (
    WidgetTester tester,
  ) async {
    // Build HalamanJadwal.
    await tester.pumpWidget(const MaterialApp(home: HalamanJadwal()));

    // Verify HalamanJadwal has the right headers.
    expect(find.text('Jadwal Mingguan'), findsOneWidget);
    expect(find.text('Semester 3'), findsOneWidget);

    // Verify today's class is displayed by default.
    expect(find.text('Praktikum Basis Data'), findsOneWidget);
    expect(find.text('Ongoing'), findsOneWidget);

    // Tap on Week tab.
    await tester.tap(find.text('Week'));
    await tester.pumpAndSettle();

    // Verify week classes are shown.
    expect(find.text('Senin'), findsOneWidget);
    expect(find.text('Basis Data | 2 SKS'), findsOneWidget);
  });
}

/// A mock HTTP client that intercepts all image requests and returns a valid transparent 1x1 GIF.
class MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return MockHttpClient();
  }
}

class MockHttpClient implements HttpClient {
  @override
  Future<HttpClientRequest> getUrl(Uri url) async => MockHttpClientRequest();

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class MockHttpClientRequest implements HttpClientRequest {
  @override
  Future<HttpClientResponse> close() async => MockHttpClientResponse();

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class MockHttpClientResponse implements HttpClientResponse {
  @override
  int get statusCode => 200;

  @override
  int get contentLength => _transparentImageBytes.length;

  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return Stream<List<int>>.fromIterable([_transparentImageBytes]).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

final List<int> _transparentImageBytes = base64Decode(
  'R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7',
);
