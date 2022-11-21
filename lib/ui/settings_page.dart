import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../model/user.dart';
import '../provider/dark_theme_provider.dart';
import '../utils/theme_helper.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key, required this.user})
      : super(
          key: key,
        );

  final User user;

  @override
  State<SettingsPage> createState() => _SettingUserScreenState();
}

class _SettingUserScreenState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return SingleChildScrollView(
        child: Column(children: [
      Container(
        height: 200,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              widget.user.email,
              style: TextStyle(
                  color: ThemeHelper.primaryElement,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Preferenze'.toUpperCase(),
            style: TextStyle(
              color: CupertinoColors.systemGrey,
              letterSpacing: 1.6,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
      Container(
        height: 50,
        color: themeChange.darkTheme
            ? CupertinoColors.label
            : CupertinoColors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.person,
                  color: themeChange.darkTheme
                      ? CupertinoColors.white
                      : CupertinoColors.label,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Modifica utente',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color:
                          themeChange.darkTheme ? Colors.white : Colors.black),
                ),
                Spacer(),
                Icon(
                  CupertinoIcons.chevron_forward,
                  color: themeChange.darkTheme
                      ? CupertinoColors.white
                      : CupertinoColors.label,
                ),
              ],
            ),
          ),
        ),
      ),
      Container(
        height: 50,
        color: themeChange.darkTheme
            ? CupertinoColors.label
            : CupertinoColors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.wifi_slash,
                  color: themeChange.darkTheme
                      ? CupertinoColors.white
                      : CupertinoColors.label,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Offline Mode',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color:
                          themeChange.darkTheme ? Colors.white : Colors.black),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
      Container(
        height: 50,
        color: themeChange.darkTheme
            ? CupertinoColors.label
            : CupertinoColors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.moon,
                  color: themeChange.darkTheme
                      ? CupertinoColors.white
                      : CupertinoColors.label,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Dark Mode',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color:
                          themeChange.darkTheme ? Colors.white : Colors.black),
                ),
                Spacer(),
                CupertinoSwitch(
                  value: themeChange.darkTheme,
                  onChanged: (value) {
                    themeChange.darkTheme = value;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      GestureDetector(
        child: Container(
          height: 50,
          color: themeChange.darkTheme
              ? CupertinoColors.label
              : CupertinoColors.white,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.rocket,
                    color: themeChange.darkTheme
                        ? CupertinoColors.white
                        : CupertinoColors.label,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Root Mode',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: themeChange.darkTheme
                            ? Colors.white
                            : Colors.black),
                  ),
                  Spacer(),
                  Icon(
                    CupertinoIcons.chevron_forward,
                    color: themeChange.darkTheme
                        ? CupertinoColors.white
                        : CupertinoColors.label,
                  ),
                ],
              ),
            ),
          ),
        ),
        onDoubleTap: () {
          /*Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => RootScreen()),
              );
              */
        },
      ),
      GestureDetector(
          child: Container(
            height: 60,
            color: themeChange.darkTheme
                ? CupertinoColors.label
                : CupertinoColors.white,
            child: Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.square_arrow_left,
                      color: themeChange.darkTheme
                          ? CupertinoColors.white
                          : CupertinoColors.label,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Logout',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: themeChange.darkTheme
                              ? Colors.white
                              : Colors.black),
                    ),
                    Spacer(),
                    Icon(
                      CupertinoIcons.chevron_forward,
                      color: themeChange.darkTheme
                          ? CupertinoColors.white
                          : CupertinoColors.label,
                    ),
                  ],
                ),
              ),
            ),
          ),
          onTap: () {}),
    ]));
  }

  Future<void> showInformationDialog(
      BuildContext context, Color backgroundColor, Color anotherColor) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                backgroundColor: backgroundColor,
                content: Container(
                  height: 300,
                  width: 300,
                ));
          });
        });
  }
}
