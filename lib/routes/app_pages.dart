import 'package:get/get.dart';
import 'package:call_app/views/role_selection_view.dart';
import 'package:call_app/views/home_view.dart';
import 'package:call_app/views/call_history_view.dart';
import 'package:call_app/views/calling_view.dart';
import 'package:call_app/views/ringing_view.dart';
import 'package:call_app/bindings/home_binding.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.ROLE_SELECTION;

  static final routes = [
    GetPage(
      name: Routes.ROLE_SELECTION,
      page: () => RoleSelectionView(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.CALL_HISTORY,
      page: () => CallHistoryView(),
    ),
    GetPage(
      name: Routes.CALLING,
      page: () => CallingView(),
    ),
    GetPage(
      name: Routes.RINGING,
      page: () => RingingView(),
    ),
  ];
}