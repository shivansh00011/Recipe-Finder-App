
import 'package:url_launcher/url_launcher.dart';

class StartCooking {
  static Future<void> startcooking(String url) async{
    final recipe = Uri.parse(url);
    if(!await launchUrl(recipe)){
      throw Exception('could not launch');
    }
  }
}