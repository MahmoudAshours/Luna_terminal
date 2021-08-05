import 'dart:convert';
import 'package:web_scraper/web_scraper.dart';

import '../Helpers/colorful_comment.dart';
import '../Helpers/get_input.dart';

class FacebookVideoPost {
  String? _facebookVideoLink;
  late WebScraper _webScraper;

  void _findVideoUrl({required int j}) {
    while (_facebookVideoLink == null) {
      try {
        var _facebookVideoDecoded = json.decode(_webScraper.getAllScripts()[j]);
        _facebookVideoLink = _facebookVideoDecoded['contentUrl'];
        colorfulPrint(
            message: 'Facebook Video URL : $_facebookVideoLink',
            color: 'green');
        j++;
      } on FormatException catch (e) {
        colorfulPrint(
            message: 'Trying enumaration number ${j + 1}', color: 'cyan');
        j++;
      }
    }
  }

  Future<void> getFacebookPostVideo() async {
    colorfulPrint(message: 'Enter your facebook link', color: 'magenta');
    final _facebookLink = input();
    try {
      _webScraper = WebScraper();
      // await webScraper.loadWebPage('UefaSarcasmSociety/posts/4590156297703013');
      colorfulPrint(message: 'Loading your facebook video', color: 'yellow');

      await _webScraper.loadFullURL('$_facebookLink');
      _findVideoUrl(j: 0);
    } on WebScraperException catch (ex, _) {
      colorfulPrint(message: ex.errorMessage(), color: 'red');
      colorfulPrint(message: "Couldn't find video!", color: 'red');
    }
  }
}
