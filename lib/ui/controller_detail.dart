import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:ups_flutter_app/store/detailController_store/detailController_store.dart';
import 'package:ups_flutter_app/utils/theme_helper.dart';

import '../model/response/user_login.dart';
import '../model/user.dart';
import '../provider/dark_theme_provider.dart';
import '../services/controller_service.dart';
import '../store/controller_store/controller_store.dart';

class ControllerDetailPage extends StatefulWidget {
  const ControllerDetailPage(
      {super.key, required this.user, required this.idController});

  final User user;
  final int idController;

  @override
  State<ControllerDetailPage> createState() => _ControllerDetailPageState();
}

class _ControllerDetailPageState extends State<ControllerDetailPage> {
  DetailControllerStore detailControllerStore = DetailControllerStore();
  final _timerDuration = Duration(seconds: 60);
  late User user;
  late int idController;
  @override
  void initState() {
    user = widget.user;
    idController = widget.idController;
    callForController();
    Timer.periodic(_timerDuration, (timer) {
      //callForController();
    });

    super.initState();
  }

  void callForController() {
    ControllerService(UserLogin(email: user.email, password: user.password))
        .fetchControllerDetailResponse(idController)
        .then((value) {
      detailControllerStore.controller = value.controller!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: (() => Navigator.pop(context)),
            icon: Icon(Icons.arrow_back),
            color: themeChange.darkTheme ? Colors.white : Colors.black,
          ),
          backgroundColor: themeChange.darkTheme
              ? ThemeHelper.primaryElementDark
              : ThemeHelper.secondaryElement,
          title: Text(
            'Dettaglio controller',
            style: TextStyle(
                fontSize: 16,
                color: themeChange.darkTheme ? Colors.white : Colors.black),
          ),
        ),
        body: Container(
          color: themeChange.darkTheme
              ? ThemeHelper.primaryElementDark
              : ThemeHelper.secondaryElement,
          child: Observer(builder: ((context) {
            if (detailControllerStore.controller == null &&
                !detailControllerStore.flagRequested) {
              return Container(
                height: 250,
                child: Center(child: CircularProgressIndicator()),
              );
            } else {
              return Column(children: [
                Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/chip.png',
                          height: 80,
                          width: 80,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Nome: ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: themeChange.darkTheme
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                Text(
                                  detailControllerStore.controller!.name!,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: themeChange.darkTheme
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Ultimo controllo: ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: themeChange.darkTheme
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                Text(
                                  detailControllerStore.controller!.lastCheck!
                                      .toLowerCase(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: themeChange.darkTheme
                                          ? Colors.white
                                          : Colors.black),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Ip pubblico: ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: themeChange.darkTheme
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                detailControllerStore.controller!.ipPublic == ''
                                    ? Text(
                                        'Non Presente'.toLowerCase(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: themeChange.darkTheme
                                                ? Colors.white
                                                : Colors.black),
                                      )
                                    : Text(
                                        detailControllerStore
                                            .controller!.ipPublic!,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: themeChange.darkTheme
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Ip privato: ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: themeChange.darkTheme
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                detailControllerStore.controller!.ipPublic == ''
                                    ? Text(
                                        'Non Presente'.toLowerCase(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: themeChange.darkTheme
                                                ? Colors.white
                                                : Colors.black),
                                      )
                                    : Text(
                                        detailControllerStore
                                            .controller!.ipPublic!,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: themeChange.darkTheme
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Status: ',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: themeChange.darkTheme
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                Text(
                                  detailControllerStore.controller!.status!
                                      .toLowerCase(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: themeChange.darkTheme
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                detailControllerStore.controller!.status ==
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
                          ],
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: themeChange.darkTheme
                          ? Color.fromARGB(255, 20, 20, 20)
                          : Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Text(
                            'Lista degli ups collegati',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: themeChange.darkTheme
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          padding: EdgeInsets.all(20)),
                      Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: CupertinoSearchTextField(
                            placeholder: 'Cerca',
                          )),
                      Expanded(
                          child: ListView.builder(
                        padding: EdgeInsets.all(20),
                        shrinkWrap: true,
                        itemBuilder: ((context, index) => Text('Ups - $index')),
                        itemCount: 100,
                      ))
                    ],
                  ),
                ))
              ]);
            }
          })),
        ));
  }
}
