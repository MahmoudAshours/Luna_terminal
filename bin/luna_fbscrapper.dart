import 'Facebook/luna_fbvideopost.dart';

void main(List<String> arguments) async {
  var _fbVidPost = FacebookVideoPost();
  await _fbVidPost.getFacebookPostVideo();
}
