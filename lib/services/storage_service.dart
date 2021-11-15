import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> addHistory(String query) async {
    List<String> searchHistory = await getHistory();
    if(!searchHistory.contains(query)){
      if (searchHistory.length == 5){
        searchHistory.removeLast();
      }
      searchHistory.insert(0, query);
      final SharedPreferences prefs = await _prefs;
      prefs.setStringList('searchHistory', searchHistory);
    }
  }

  Future<List<String>> getHistory() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getStringList('searchHistory') ?? [];
  }

  void clear() async => await _prefs..clear();
}
