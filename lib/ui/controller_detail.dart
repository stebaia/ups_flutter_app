import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ups_flutter_app/store/detailController_store/detailController_store.dart';

import '../model/response/user_login.dart';
import '../model/user.dart';
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
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Dettaglio controller',
            style: TextStyle(fontSize: 16),
          ),
        ),
        body: Container(
          child: Observer(builder: ((context) {
            if (detailControllerStore.controller == null &&
                !detailControllerStore.flagRequested) {
              return Container(
                height: 250,
                child: Center(child: CircularProgressIndicator()),
              );
            } else {
              return Column(children: [
                Row(
                  children: [Image.asset('assets/chip.png')],
                )
              ]);
            }
          })),
          padding: EdgeInsets.all(8),
        ));
  }
}
