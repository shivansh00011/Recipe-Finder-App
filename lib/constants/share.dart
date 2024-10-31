
import 'package:share_plus/share_plus.dart';

class ShareRecipe{
  static share(String recipelink) async{
    await Share.share(recipelink);
  }
}

