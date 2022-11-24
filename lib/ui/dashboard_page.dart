import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:ups_flutter_app/model/controller.dart';
import 'package:ups_flutter_app/model/response/list_controller_response.dart';
import 'package:ups_flutter_app/model/response/user_login.dart';
import 'package:ups_flutter_app/services/controller_service.dart';
import 'package:ups_flutter_app/store/controller_store/controller_store.dart';
import 'package:ups_flutter_app/store/visibility_store/visibility_store.dart';
import 'package:ups_flutter_app/ui/components/list_controller_widget.dart';
import 'package:ups_flutter_app/ui/controller_detail.dart';
import 'package:ups_flutter_app/utils/theme_helper.dart';
import 'dart:async';
import '../model/user.dart';
import '../provider/bottom_navigation_bar_provider.dart';
import '../provider/dark_theme_provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key, required this.user});

  final User user;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with TickerProviderStateMixin {
  ControllerStore controllerStore = ControllerStore();
  final _timerDuration = Duration(seconds: 60);
  late User user;
  late Timer _timer;

  @override
  void initState() {
    user = widget.user;

    callForControllers();
    _timer = Timer.periodic(_timerDuration, (timer) {
      callForControllers();
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
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
    final _screenindexprovider =
        Provider.of<BottomNavigationBarProvider>(context);
    int currentScreenIndex = _screenindexprovider.currentIndex;
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
              'Dashboard',
              style: TextStyle(
                fontSize: 14,
                color: themeChange.darkTheme ? Colors.white : Colors.black,
              ),
            ),
            Text(
              'Gestisci i tuoi ups',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: themeChange.darkTheme ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ultime rilevazioni fatte'.toUpperCase(),
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Vedi tutte',
                  style: TextStyle(
                      color: ThemeHelper.primaryElement,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.center,
                child: Container(
                  width: double.infinity,
                  height: 46,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ThemeHelper.secondaryElement,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                      child: Text(
                    'Nessuna nuova rilevazione',
                    style: TextStyle(color: Colors.white),
                  )),
                )),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'I tuoi controller'.toUpperCase(),
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  child: Text(
                    'Vedi tutti',
                    style: TextStyle(
                        color: ThemeHelper.primaryElement,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    _screenindexprovider.currentIndex = 1;
                  },
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                child: Observer(builder: ((context) {
                  if (controllerStore.controllers.isEmpty &&
                      !controllerStore.flagRequested) {
                    return Container(
                      height: 250,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (controllerStore.controllers.isEmpty &&
                      controllerStore.flagRequested) {
                    return Center(
                        child: Text(
                      'Nessuna nuova rilevazione',
                      style: TextStyle(color: Colors.white),
                    ));
                  } else {
                    return ListControllerWidget(
                      controllers: controllerStore.controllers,
                      user: user,
                    );
                  }
                })),
              ),
            )
          ],
        ));
  }
}
