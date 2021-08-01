import 'package:web_scraper/web_scraper.dart';

void main(List<String> arguments) async {
  late WebScraper webScraper;
  try {
    webScraper = WebScraper('https://m.facebook.com/');
    await webScraper.loadWebPage('watch/?v=568509480839251');
  } on WebScraperException catch (ex, _) {
    print(ex.errorMessage());
  }

  try {
    var _link = webScraper
        .getPageContent()
        .split('<a href="/video_redirect/?src=')[1]
        .split('"')[0];

    var _formattedLinkVideo = Uri.decodeComponent(_link);
    print(_formattedLinkVideo);
  } catch (e) {
    print('couldnt find video');
  }
}
