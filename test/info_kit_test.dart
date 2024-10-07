import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:info_kit/info_kit.dart';
import 'package:mockito/mockito.dart';

class MockDotEnv extends Mock implements DotEnv {}

void main() {
  group('InfoKit Tests', () {
    late MockDotEnv mockDotEnv;

    setUp(() {
      mockDotEnv = MockDotEnv();
      dotenv = mockDotEnv;

      // Use the test-only method to set mock values
      InfoKit.setTestValues(
        buildNumber: 42,
        version: '1.2.3',
        packageName: 'com.example.app',
        appName: 'Test App',
        platform: InfoPlatform.ios,
        flavor: const InfoFlavor('test'),
        os: InfoOS.ios,
        sizes: InfoSizes(),
        size: DefaultInfoSize.phone,
      );
    });

    tearDown(() {
      // Reset the test values after each test
      InfoKit.resetTestValues();
    });

    test('InfoKit.setConstrains updates size correctly', () {
      InfoKit.setConstrains(
          const BoxConstraints(maxWidth: 400, maxHeight: 1000));
      expect(InfoKit.size, DefaultInfoSize.phone);

      InfoKit.setConstrains(
          const BoxConstraints(maxWidth: 700, maxHeight: 1000));
      expect(InfoKit.size, DefaultInfoSize.tablet);
    });

    test('InfoKit.platform returns correct value', () {
      expect(InfoKit.platform, isA<InfoPlatform>());
    });

    test('InfoKit.os returns correct value', () {
      expect(InfoKit.os, InfoOS.ios);
    });

    test('InfoKit.mode returns correct value', () {
      expect(InfoKit.mode, InfoMode.debug);
    });

    test('InfoKit.storeUrl returns correct URLs', () {
      expect(InfoKit.storeUrl('123456789'),
          'https://apps.apple.com/app/123456789');
      expect(InfoKit.storeUrl(null), null);
    });
  });

  group('ExpressionParser Tests', () {
    late MockDotEnv mockDotEnv;

    setUp(() {
      mockDotEnv = MockDotEnv();
      dotenv = mockDotEnv;

      // Use the test-only method to set mock values
      InfoKit.setTestValues(
        buildNumber: 42,
        version: '1.2.3',
        packageName: 'com.example.app',
        appName: 'Test App',
        platform: InfoPlatform.ios,
        flavor: const InfoFlavor('test'),
        os: InfoOS.ios,
        sizes: InfoSizes(),
        size: DefaultInfoSize.phone,
      );
    });

    tearDown(() {
      // Reset the test values after each test
      InfoKit.resetTestValues();
    });

    test('Simple comparison', () {
      expect(InfoKit.isBuildSupported('x > 40'), isTrue);
      expect(InfoKit.isBuildSupported('x > 100'), isFalse);
    });

    test('Compound conditions with AND', () {
      expect(InfoKit.isBuildSupported('x > 40 && x < 100'), isTrue);
      expect(InfoKit.isBuildSupported('x > 5 && x < 10'), isFalse);
    });

    test('Compound conditions with OR', () {
      expect(InfoKit.isBuildSupported('x < 0 || x > 10'), isTrue);
    });

    test('Nested conditions', () {
      expect(
          InfoKit.isBuildSupported('(x > 10 && x < 100) || x == 15'), isTrue);
    });

    test('NOT operator', () {
      expect(InfoKit.isBuildSupported('!(x < 5)'), isTrue);
      expect(InfoKit.isBuildSupported('!(x < 50)'), isFalse);
    });

    test('Complex expression', () {
      String expr = '(x > 0 && x < 10) || (x >= 20 && x <= 30) || !(x != 50)';
      expect(InfoKit.isBuildSupported(expr), isFalse);
    });

    test('Different variable name', () {
      expect(InfoKit.isBuildSupported('y > 10', variable: 'y'), isTrue);
      expect(InfoKit.isBuildSupported('y < 10', variable: 'y'), isFalse);
    });

    test('Equal and not equal', () {
      expect(InfoKit.isBuildSupported('x == 42'), isTrue);
      expect(InfoKit.isBuildSupported('x != 10'), isTrue);
    });

    test('Greater than or equal and less than or equal', () {
      expect(InfoKit.isBuildSupported('x >= 10'), isTrue);
      expect(InfoKit.isBuildSupported('x <= 100'), isTrue);
    });

    test('Invalid expressions', () {
      expect(() => InfoKit.isBuildSupported('x > > 5'), throwsFormatException);
      expect(() => InfoKit.isBuildSupported('x & 5'), throwsFormatException);
    });
  });
}
