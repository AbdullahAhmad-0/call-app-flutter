import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:call_app/models/call_history.dart';
import 'dart:convert';

class AppController extends GetxController {
  static AppController get to => Get.find();

  var userRole = ''.obs;
  var callHistory = <CallHistory>[].obs;
  var isOnline = true.obs;

  SharedPreferences? _prefs;

  @override
  void onInit() {
    super.onInit();
    initSharedPrefs();
  }

  Future<void> initSharedPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    loadCallHistory();
    loadUserRole();
  }

  void setUserRole(String role) {
    userRole.value = role;
    _prefs?.setString('user_role', role);
  }

  void loadUserRole() {
    userRole.value = _prefs?.getString('user_role') ?? '';
  }

  void addCallHistory(CallHistory call) {
    callHistory.insert(0, call);
    saveCallHistory();
  }

  void saveCallHistory() {
    List<String> historyJson = callHistory.map((call) => jsonEncode(call.toJson())).toList();
    _prefs?.setStringList('call_history', historyJson);
  }

  void loadCallHistory() {
    List<String>? historyJson = _prefs?.getStringList('call_history');
    if (historyJson != null) {
      callHistory.value = historyJson
          .map((json) => CallHistory.fromJson(jsonDecode(json)))
          .toList();
    }
  }

  void clearCallHistory() {
    callHistory.clear();
    _prefs?.remove('call_history');
  }
}