import 'dart:convert';
import 'dart:io';

import 'package:web_scraper/web_scraper.dart';

String? input() => stdin.readLineSync(encoding: Encoding.getByName('utf-8')!);

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
  late WebScraper webScraper;
  _colorfulPrint(message: 'Enter your facebook link', color: 'magenta');
  final _facebookLink = input();
  try {
    webScraper = WebScraper();
    // await webScraper.loadWebPage('UefaSarcasmSociety/posts/4590156297703013');
    await webScraper.loadFullURL('$_facebookLink');
    var _facebookVideoDecoded = json.decode(webScraper.getAllScripts()[3]);

    final _facebookVideoLink = _facebookVideoDecoded['contentUrl'];
    print('Facebook Video URL : $_facebookVideoLink ');
  } on WebScraperException catch (ex, _) {
    print(ex.errorMessage());
  }

// Alternative way to get the source of Facebook video
  // try {
  //   var _link = webScraper
  //       .getPageContent()
  //       .split('<a href="/video_redirect/?src=')[1]
  //       .split('"')[0];

  //   var _formattedLinkVideo = Uri.decodeComponent(_link);
  //   print(_formattedLinkVideo);
  // } catch (e) {
  //   print('couldnt find video');
  // }
}
