import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stock_news_flutter/core/utils/link_handler.dart';
import 'link_handler_test.mocks.dart';

@GenerateMocks([UrlLauncher])
void main() {
  late MockUrlLauncher mockUrlLauncher;
  late LinkHandlerImpl linkHandler;

  const tValidUrl = 'https://www.google.com';
  const tInvalidUrl = '';

  setUp(() {
    mockUrlLauncher = MockUrlLauncher();
    linkHandler = LinkHandlerImpl(urlLauncher: mockUrlLauncher);
  });

  test('should open a link for a valid URL', () async {
    // arrange
    final expectedUrl = Uri.parse(tValidUrl);
    when(mockUrlLauncher.canLaunch(any)).thenAnswer((_) async => true);
    when(mockUrlLauncher.launch(any)).thenAnswer((_) async => true);
    // // act
    final call = linkHandler.openLink;
    // assert
    expect(() => call(tValidUrl), returnsNormally);
    verify(mockUrlLauncher.canLaunch(expectedUrl)).called(1);
  });

  test('should throw an exception for a invalid URL', () async {
    // arrange
    when(mockUrlLauncher.canLaunch(any)).thenAnswer((_) async => false);
    //act
    final call = linkHandler.openLink;
    // assert
    expect(call(tInvalidUrl), throwsA(isA<Exception>()));
  });
}
