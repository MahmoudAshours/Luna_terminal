import 'dart:convert';
import 'dart:io';

import 'package:web_scraper/web_scraper.dart';

String? input() => stdin.readLineSync(encoding: Encoding.getByName('utf-8')!);
String? _facebookVideoLink;
late WebScraper webScraper;

void _findVideoUrl({required int j}) {
  while (_facebookVideoLink == null) {
    try {
      var _facebookVideoDecoded = json.decode(webScraper.getAllScripts()[j]);
      _facebookVideoLink = _facebookVideoDecoded['contentUrl'];
      _colorfulPrint(
          message: 'Facebook Video URL : $_facebookVideoLink', color: 'green');
      j++;
    } on FormatException catch (e) {
      j++;
    }
  }
}

void _colorfulPrint({String color = 'red', message}) {
  var _colorScheme = <String, String>{
    'black': '\x1B[30m',
    'red': '\x1B[31m',
    'green': '\x1B[32m',
    'yellow': '\x1B[33m',
    'blue': '\x1B[34m',
    'magenta': '\x1B[35m',
    'cyan': '\x1B[36m',
    'white': '\x1B[37m',
    'reset': '\x1B[0m',
  };
  print("${_colorScheme['$color']}$message${_colorScheme['reset']}");
}

void main(List<String> arguments) async {
  _colorfulPrint(message: 'Enter your facebook link', color: 'magenta');
  final _facebookLink = input();
  try {
    webScraper = WebScraper();
    // await webScraper.loadWebPage('UefaSarcasmSociety/posts/4590156297703013');
    _colorfulPrint(message: 'Loading your facebook video', color: 'yellow');

    await webScraper.loadFullURL('$_facebookLink');
    _findVideoUrl(j: 0);
  } on WebScraperException catch (ex, _) {
    _colorfulPrint(message: ex.errorMessage(), color: 'red');
    _colorfulPrint(message: "Couldn't find video!", color: 'red');
  }
// Alternative way to get the source of Facebook video
  // try {
  // var _link = webScraper
  //     .getPageContent()
  //     .split('<a href="/video_redirect/?src=')[1]
  //     .split('"')[0];

  // var _formattedLinkVideo = Uri.decodeComponent(_link);
  //   print(_formattedLinkVideo);
  // } catch (e) {
  //   print('couldnt find video');
  // }
}
