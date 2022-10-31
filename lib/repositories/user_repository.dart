

import 'package:shared_preferences/shared_preferences.dart';

class UserRepository{
  final Future<SharedPreferences> _prefs;

  UserRepository()
      : _prefs = SharedPreferences.getInstance();

  Future<void> singUp(String login, String password, String name) async{
    var prefs = await _prefs;
    prefs.setStringList('authentication', [name, login, password]);
  }

  Future singIn(String login, String password) async{
    var prefs = await _prefs;
    var listVerification = prefs.getStringList('authentication');
    if(listVerification![1] == login &&listVerification[2] == password){
      return true;
    }else {
      return false;
    }
  }

  Future<void> singOut() async{
    var prefs = await _prefs;
    prefs.setStringList('authentication', []);
  }

  Future<bool> isSignedIn() async{
    var prefs = await _prefs;
    return prefs.getStringList('authentication') != null || prefs.getStringList('authentication') != [];
  }

  Future<List<String>?> getData() async{
    var prefs = await _prefs;
    return prefs.getStringList('authentication');
  }

}