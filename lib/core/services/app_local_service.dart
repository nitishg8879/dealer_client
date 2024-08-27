
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppLocalService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final _languageCodeKey = "_languageCodeKey";
  String _selectedLanguage = "en";

  Future<void> init() async {
    _selectedLanguage =
        await _secureStorage.read(key: _languageCodeKey) ?? _selectedLanguage;
  }

  //? Getter for selected language
  String get selectedLangauge => _selectedLanguage;
  //? Setter for new language
  set selectedLangauge(String newLanguage) {
    _selectedLanguage = newLanguage;
    saveNewlanguage();
  }

  Future<void> saveNewlanguage() async {
    await _secureStorage.write(key: _languageCodeKey, value: _selectedLanguage);
  }
}
