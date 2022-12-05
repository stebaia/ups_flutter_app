import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ups_flutter_app/model/controller.dart';
import 'package:ups_flutter_app/model/response/list_controller_response.dart';
import 'package:ups_flutter_app/model/response/user_login.dart';
import 'package:ups_flutter_app/services/controller_service.dart';
import 'package:ups_flutter_app/store/visibility_store/visibility_store.dart';
import 'package:ups_flutter_app/ui/controller_list.dart';
import 'package:ups_flutter_app/ui/dashboard_page.dart';
import 'package:ups_flutter_app/ui/settings_page.dart';
import 'dart:async';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ups_flutter_app/utils/theme_helper.dart';
import '../model/user.dart';
import '../provider/bottom_navigation_bar_provider.dart';
import '../provider/dark_theme_provider.dart';
import '../store/bottomNavigationBar_store/bottomNavigation_store.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  late User user;
  BottomNavigationStore bottomNavigationStore = BottomNavigationStore();
  List<Widget> _widgetPages(User mUser) {
    List<Widget> listPages = [];
    listPages.add(DashboardPage(user: user));
    listPages.add(ControllerListPage(
      user: user,
    ));
    listPages.add(SettingsPage(user: user));
    return listPages;
  }

  List<BottomNavigationBarItem> _widgetTab(User mUser) {
    List<BottomNavigationBarItem> tabList = [];
    tabList.add(BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      label: 'Dashboard',
    ));
    tabList.add(BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.list_bullet),
      label: 'Controllers',
    ));
    tabList.add((BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.settings),
      label: 'Impostazioni',
    )));
    return tabList;
  }

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    final _screenindexprovider =
        Provider.of<BottomNavigationBarProvider>(context);
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeChange.darkTheme
          ? Color.fromARGB(255, 20, 20, 20)
          : ThemeHelper.backgroundLight,
      body: SingleChildScrollView(
        child: _widgetPages(user)[_screenindexprovider.currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: themeChange.darkTheme
            ? Color.fromARGB(255, 20, 20, 20)
            : ThemeHelper.backgroundLight,
        items: _widgetTab(user),
        unselectedItemColor: Colors.grey,
        currentIndex: _screenindexprovider.currentIndex,
        onTap: (int index) {
          _screenindexprovider.currentIndex = index;
        },
      ),
    );
  }
}
