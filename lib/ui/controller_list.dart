import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:ups_flutter_app/services/controller_service.dart';
import 'package:ups_flutter_app/store/controller_store/controller_store.dart';
import 'package:ups_flutter_app/ui/components/nothing_here_widget.dart';

import '../model/response/user_login.dart';
import '../model/user.dart';
import '../provider/dark_theme_provider.dart';
import '../utils/theme_helper.dart';

class ControllerListPage extends StatefulWidget {
  const ControllerListPage({key, required this.user}) : super(key: key);

  final User user;

  @override
  State<ControllerListPage> createState() => _ControllerListPageState();
}

class _ControllerListPageState extends State<ControllerListPage> {
  ControllerStore controllerStore = ControllerStore();
  final _timerDuration = Duration(seconds: 60);
  late User user;

  @override
  void initState() {
    user = widget.user;

    callForControllers();
    Timer.periodic(_timerDuration, (timer) {
      callForControllers();
    });

    super.initState();
  }

  void callForControllers() {
    ControllerService(UserLogin(email: user.email, password: user.password))
        .fetchControllerResponse()
        .then((value) {
      controllerStore.controllers = value.controllers!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'Controllers',
              style: TextStyle(
                  fontSize: 14,
                  color: themeChange.darkTheme ? Colors.white : Colors.black),
            ),
            Text(
              'Gestisci i controller',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: themeChange.darkTheme ? Colors.white : Colors.black),
            ),
            SizedBox(
              height: 30,
            ),
            Observer(builder: ((context) {
              if (controllerStore.controllers.isEmpty &&
                  !controllerStore.flagRequested) {
                return Container(
                  height: 250,
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (controllerStore.controllers.isEmpty &&
                  controllerStore.flagRequested) {
                return Center(
                    child: NothingHereWidget(
                  height: 400,
                  width: 400,
                ));
              } else {
                return Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color:
                            themeChange.darkTheme ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            Divider(color: Colors.transparent),
                        padding: EdgeInsets.all(4),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controllerStore.controllers.length > 5
                            ? 5
                            : controllerStore.controllers.length,
                        itemBuilder: ((context, index) => Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: themeChange.darkTheme
                                      ? Colors.black
                                      : Colors.white),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.memory_sharp,
                                        color: ThemeHelper.primaryElement,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controllerStore
                                                .controllers[index].name!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: themeChange.darkTheme
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                          Text(
                                            controllerStore
                                                .controllers[index].lastCheck!,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: themeChange.darkTheme
                                                    ? Colors.white
                                                    : Colors.black),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  controllerStore.controllers[index].status ==
                                          'Online'
                                      ? Lottie.asset(
                                          'assets/status_red.json',
                                          fit: BoxFit.contain,
                                          height: 30,
                                          width: 30,
                                        )
                                      : Lottie.asset(
                                          'assets/status_green.json',
                                          fit: BoxFit.contain,
                                          height: 30,
                                          width: 30,
                                        )
                                ],
                              ),
                            ))));
              }
            })),
          ],
        ));
  }
}
