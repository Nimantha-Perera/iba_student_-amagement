import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageManager {
  static late SharedPreferences _prefs; // SharedPreferences instance
  static String? selectedLanguage;
  static final Map<String, Map<String, String>> translations = {
    'English': {
      'Who Are You?': 'Who Are You?',
      'I\'M A STUDENT': 'I\'M A STUDENT',
      'I\'M AN IBA CAMPUS STAFF': 'I\'M AN IBA CAMPUS STAFF',
    },
    'සිංහල': {
      'Who Are You?': 'ඔබ කවුද?',
      'I\'M A STUDENT': 'මම ශිෂ්‍යයෙකි',
      'I\'M AN IBA CAMPUS STAFF': 'මම කාර්‍ය මන්ඩලයේ සාමාජිකයෙකි',
      'Login Your Student Portal': 'ඔබේ ශිෂ්‍ය ද්වාරය ලොගින් කරන්න',
      'IBA Campus already registered students only' : 'IBA කැම්පස් දැනටමත් ලියාපදිංචි සිසුන් පමණි',
      'Index Number':'Index අංකය',
      'Password':'රහස්‍ය අංකය',
      'Keep me signed in':'මාව පුරනය වී තබා ගන්න',
      'LOGIN':'පුරනය වන්න',
      'Forgot your password':'මතක නෑ?',
      'Notifications':'දැනුම්දීම',
      'Menu':'මෙනුව',
      'Staff Portal':'සේවක පුරනය',
      'Student Portal':'සිසුන් පුරනය',
      'Logout':'ඉවත් ලබාගන්න',
      'Log in':'පුරන්න',
      'Results':'විභාග ප්‍රතිඵල',
      'Payment':"ගෙවීම්",
      'Tutes':'පොත්',
      'Videos':'වීඩියෝ පට',
      'Online Exams':'මාර්ගගත විභාග',
      'Live Lectures':"සජීවී දේශන",
      
    },
    'தமிழ்': {
      'Who Are You?': 'நீ யார்?',
      'I\'M A STUDENT': 'நான் மாணவர்',
      'I\'M AN IBA CAMPUS STAFF': 'நான் ஐபிஏ நிறுவனத்தின் அமைப்பு உதவியாளர்',
      
    },
  };

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance(); // Initialize SharedPreferences
    selectedLanguage = _prefs.getString('selectedLanguage') ?? 'English'; // Retrieve saved language or default to English
  }

  static String getText(String key) {
    final currentLanguage = selectedLanguage ?? 'English';
    return translations[currentLanguage]?[key] ?? key;
  }

  static Future<void> changeLanguage(BuildContext context, String newLanguage) async {
    selectedLanguage = newLanguage;
    _prefs.setString('selectedLanguage', newLanguage); // Save selected language in SharedPreferences
    // Notify the widgets that the language has changed
    // For example, you can use Provider, InheritedWidget, or a similar solution
    // and notify the consumers here.
  }
}
