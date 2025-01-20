import 'dart:convert';
import 'dart:io';
 import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences _preferences;

  static const pullToRefreshDataKey = 'pullToRefreshData';
  static const _uid = 'uid';
  static const _deviceID = 'deviceID';
  static const _isOutsideApp = 'isOutsideApp';
  static const _appVersion = 'appVersion';
  static const _buildNumber = 'buildNumber';
  static const _syncToastTimestamp = 'syncToastTimestamp';
  static const _isOnBoarded = 'isOnBoarded';
  static const _hideAppGuideWalkthrough = 'hideAppGuideWalkthrough';
  static const _isRegistered = 'isRegistered';
  static const _isSortedByUpdatedAt = 'isSortedByUpdatedAt';
  static const _encryptKey = 'encryptKey';
  static const _recentlyAddedTags = 'recentlyAddedTags';
  static const _appPath = 'appPath';

  static const _timelineUnSynced = 'timelineUnSynced';
  static const _threadUnSynced = 'threadUnSynced';
  static const _snippetUnSynced = 'snippetUnSynced';

  /// delete
  static const _threadDeleteSynced = 'threadDeleteSynced';
  static const _snippetDeleteSynced = 'snippetDeleteSynced';

  static const String _sharedData = "sharedData";
  static const String _sharedFileData = "sharedFileData";
  static const String _sharedFileTypeData = "sharedFileTypeData";

  static const String _lastFetchedSnippetTime = 'lastFetchedSnippetTime';
  static const String _scrollOffset = 'scroll_offset';

  static Future init() async => _preferences = await SharedPreferences.getInstance();



  static Future<void> saveMapData(String key, Map<String, dynamic> mapData) async {
    String jsonString = json.encode(mapData); // Convert map to JSON string
    await _preferences.setString(key, jsonString); // Save JSON string in SharedPreferences
  }

  static Future<Map<String, dynamic>?> getMapData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(key); // Get JSON string from SharedPreferences
    if (jsonString != null) {
      return json.decode(jsonString); // Convert JSON string back to map
    }
    return null; // Return null if no data was found
  }

  static Future setDeviceID(String token) async {
    await _preferences.setString(_deviceID, token);
  }

    static Future setIsOutsideApp(bool status) async {
    await _preferences.setBool(_isOutsideApp, status);
  }
  static Future saveOffsetToPreferences(double movingOffset) async {
    await _preferences.setDouble(_scrollOffset, movingOffset);
  }

  static Future setAppVersion(String appVersion) async {
    await _preferences.setString(_appVersion, appVersion);
  }

  static Future setAppBuildNumber(String buildNumber) async {
    await _preferences.setString(_buildNumber, buildNumber);
  }

  static Future setSyncToastTimestamp(int timeStamp) async {
    await _preferences.setInt(_syncToastTimestamp, timeStamp);
  }

  static Future setAppPath(String appPath) async {
    await _preferences.setString(_appPath, appPath);
  }



  static Future setIsOnBoarded(bool isOnBoarded) async {
    await _preferences.setBool(_isOnBoarded, isOnBoarded);
  }

  static Future setHideAppGuideWalkthrough(bool hideAppGuideWalkthrough) async {
    await _preferences.setBool(_hideAppGuideWalkthrough, hideAppGuideWalkthrough);
  }

  static Future setIsRegistered(bool isRegistered) async {
    await _preferences.setBool(_isRegistered, isRegistered);
  }
  static Future setIsSortedByUpdatedAt(bool isSortedByUpdatedAt) async {
    await _preferences.setBool(_isSortedByUpdatedAt, isSortedByUpdatedAt);
  }



  static Future setEncryptionKey(String value) async {
    await _preferences.setString(_encryptKey, value);
  }


    static Future setRecentlyAddedTags(List<String> newTags) async {
    List<String> recentTags = _preferences.getStringList(_recentlyAddedTags) ?? [];
    final lowerCaseNewTags = newTags.map((tag) => tag.toLowerCase()).toList();

    final updatedTags = recentTags.where((recntTag) {
      return !lowerCaseNewTags.contains(recntTag.toLowerCase());
    }).toList();
    // Remove empty strings
    updatedTags.removeWhere((element) => element.isEmpty);
    newTags.removeWhere((element) => element.isEmpty);

    // Insert newTags at the beginning of the list
    updatedTags.insertAll(0, newTags);

    await _preferences.setStringList(_recentlyAddedTags, updatedTags);
  }

  static Future setLastFetchedSnippetTime(String value) async {
    await _preferences.setString(_lastFetchedSnippetTime, value);
  }

  static Future addThreadToRemoveSync(String value) async {
    var oldList = threadDeleteSynced;
    oldList.add(value);
    await _preferences.setStringList(_threadDeleteSynced, oldList);
  }

  static Future addSnippetToRemoveSync(String value) async {
    var oldList = snippetDeleteSynced;
    oldList.add(value);
    await _preferences.setStringList(_snippetDeleteSynced, oldList);
  }




  static Future removeDeletedThreadsFromSync(List<String> value) async {
    var oldList = threadDeleteSynced.toSet();
    oldList.removeAll(value);
    await _preferences.setStringList(_threadDeleteSynced, oldList.toList());
  }

  static Future removeDeletedSnippetsFromSync(List<String> value) async {
    var oldList = snippetDeleteSynced.toSet();
    oldList.removeAll(value);
    await _preferences.setStringList(_snippetDeleteSynced, oldList.toList());
  }



  static Future addTimelineToSync(String value) async {
    var oldList = timelineToSync;
    oldList.add(value);
    await _preferences.setStringList(_timelineUnSynced, oldList);
  }

  static Future addThreadToSync(String value) async {
    var oldList = threadToSync;
    oldList.add(value);
    await _preferences.setStringList(_threadUnSynced, oldList);
  }

  static Future addSnippetToSync(String value) async {
    var oldList = snippetToSync;
    oldList.add(value);
    await _preferences.setStringList(_snippetUnSynced, oldList);
  }

  static Future removeTimelinesFromSync(List<String> value) async {
    var oldList = timelineToSync.toSet();
    oldList.removeAll(value);
    await _preferences.setStringList(_timelineUnSynced, oldList.toList());
  }

  static Future removeThreadsFromSync(List<String> value) async {
    var oldList = threadToSync.toSet();
    oldList.removeAll(value);
    await _preferences.setStringList(_threadUnSynced, oldList.toList());
  }

  static Future removeSnippetsFromSync(List<String> value) async {
    var oldList = snippetToSync.toSet();
    oldList.removeAll(value);
    await _preferences.setStringList(_snippetUnSynced, oldList.toList());
  }

  /// shared text data
  static Future setSharedData(List<String> value) async {
    await _preferences.setStringList(_sharedData, value);
  }

  /// shared file data
  static Future setSharedFileData(List<String> value) async {
    await _preferences.setStringList(_sharedFileData, value);
  }

  /// shared file type data
  static Future setSharedFileTypeData(List<String> value) async {
    await _preferences.setStringList(_sharedFileTypeData, value);
  }

  static String get uid => _preferences.getString(_uid) ?? "";
  static String get deviceID => _preferences.getString(_deviceID) ?? "";
  static bool get isOutSideApp => _preferences.getBool(_isOutsideApp) ?? false;
  static String? get buildNumber => _preferences.getString(_buildNumber);
  static String? get appVersion => _preferences.getString(_appVersion);
  static int get syncToastTimestamp => _preferences.getInt(_syncToastTimestamp) ?? 0;

  static String get appPath => _preferences.getString(_appPath) ?? "";

  static String get encryptKey => _preferences.getString(_encryptKey) ?? "";

  static List<String> get getRecentlyAddedTags => _preferences.getStringList(_recentlyAddedTags) ?? [];

  static String get lastFetchedSnippetTime => _preferences.getString(_lastFetchedSnippetTime) ?? "";

  static bool get isOnBoarded => _preferences.getBool(_isOnBoarded) ?? false;

  static bool get hideAppGuideWalkthrough => _preferences.getBool(_hideAppGuideWalkthrough) ?? false;

  static bool get isRegistered => _preferences.getBool(_isRegistered) ?? false;

  static bool get isSortedByUpdatedAt => _preferences.getBool(_isSortedByUpdatedAt) ?? false;


  static List<String> get timelineToSync => _preferences.getStringList(_timelineUnSynced) ?? [];

  static List<String> get threadToSync => _preferences.getStringList(_threadUnSynced) ?? [];

  static List<String> get snippetToSync => _preferences.getStringList(_snippetUnSynced) ?? [];

  static List<String> get threadDeleteSynced =>
      _preferences.getStringList(_threadDeleteSynced) ?? [];

  static List<String> get snippetDeleteSynced =>
      _preferences.getStringList(_snippetDeleteSynced) ?? [];

  static List<String> get sharedData => _preferences.getStringList(_sharedData) ?? [];

  static List<String> get sharedFileData => _preferences.getStringList(_sharedFileData) ?? [];
  static double get scrolledOffset => _preferences.getDouble(_scrollOffset) ?? 0.0;

  static List<String> get sharedFileTypeData =>
      _preferences.getStringList(_sharedFileTypeData) ?? [];

  static Future removeUser() async {
    await _preferences.remove(_uid);

    await _preferences.remove(_deviceID);
    await _preferences.remove(_isOutsideApp);
    await _preferences.remove(_appVersion);
    await _preferences.remove(_buildNumber);
    await _preferences.remove(_encryptKey);
     await _preferences.remove(_recentlyAddedTags);
    await _preferences.remove(_isOnBoarded);
    await _preferences.remove(_isRegistered);
    await _preferences.remove(_isSortedByUpdatedAt);
     await _preferences.remove(_timelineUnSynced);
    await _preferences.remove(_threadUnSynced);
    await _preferences.remove(_snippetUnSynced);
    await _preferences.remove(_threadDeleteSynced);
    await _preferences.remove(_snippetDeleteSynced);
     await _preferences.remove(_sharedData);
    await _preferences.remove(_sharedFileData);
    await _preferences.remove(_sharedFileTypeData);
    await _preferences.remove(_syncToastTimestamp);
    await _preferences.remove(_lastFetchedSnippetTime);
   }
  static Future resetOffset()async{
    await _preferences.remove(_scrollOffset);
  }
}
