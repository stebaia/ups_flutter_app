import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:ups_flutter_app/services/upsDetail_service.dart';
import 'package:ups_flutter_app/store/detailUps_store/detailUps_store.dart';
import 'package:ups_flutter_app/ui/components/row_element_ups_widget.dart';

import '../model/response/user_login.dart';
import '../model/user.dart';
import '../provider/dark_theme_provider.dart';
import '../utils/theme_helper.dart';
import 'package:percent_indicator/percent_indicator.dart';

class UpsDetailPage extends StatefulWidget {
  const UpsDetailPage(
      {super.key,
      required this.user,
      required this.idUps,
      required this.idController});

  final User user;
  final int idUps;
  final int idController;
  @override
  State<UpsDetailPage> createState() => _UpsDetailPageState();
}

class _UpsDetailPageState extends State<UpsDetailPage> {
  DetailUpsStore detailControllerStore = DetailUpsStore();
  final _timerDuration = Duration(seconds: 600);
  late User user;
  late int idUps;
  late Timer _timer;
  late int idController;
  String searchedValue = "";
  late double _progressValue;
  @override
  void initState() {
    user = widget.user;
    idUps = widget.idUps;
    idController = widget.idController;
    callForController();
    _timer = Timer.periodic(_timerDuration, (timer) {
      callForController();
    });
    _progressValue = 1.0;
    super.initState();
  }

  void callForController() {
    UpsDetailService(UserLogin(email: user.email, password: user.password))
        .fetchUpsDetailResponse(idController, idUps)
        .then((value) {
      detailControllerStore.upsDetail = value.data!;
    });
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    double getPercentFromString(String string) {
      try {
        String aStr = string.replaceAll(new RegExp(r'[^0-9]'), '');
        return int.parse(aStr) / 100;
      } catch (e) {
        return 0.0;
      }
    }

    Color getColorFromPercentage(double percentage) {
      if (percentage > 0.6) {
        return Colors.green;
      } else if (percentage > 0.3 && percentage < 0.6) {
        return Colors.orange;
      } else {
        return Colors.red;
      }
    }

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: (() => Navigator.pop(context)),
            icon: Icon(Icons.arrow_back),
            color: themeChange.darkTheme ? Colors.white : Colors.black,
          ),
          backgroundColor: themeChange.darkTheme
              ? ThemeHelper.backgroundTopDark
              : ThemeHelper.backgroundLight,
          title: Text(
            'Dettaglio Ups',
            style: TextStyle(
                fontSize: 16,
                color: themeChange.darkTheme ? Colors.white : Colors.black),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
                color: themeChange.darkTheme
                    ? ThemeHelper.backgroundTopDark
                    : ThemeHelper.backgroundLight,
                child: Observer(builder: ((context) {
                  if (detailControllerStore.upsDetail == null &&
                      !detailControllerStore.flagRequested) {
                    return Container(
                      height: 250,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    return Column(
                      children: [
                        Container(
                            padding: EdgeInsets.all(16),
                            child: Row(children: [
                              Image.asset(
                                'assets/upsicon.png',
                                height: 76,
                                width: 76,
                              ),
                              const SizedBox(
                                width: 20,
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
                                          detailControllerStore
                                              .upsDetail!.nome!,
                                          style: TextStyle(
                                              fontSize: 12,
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
                                          'ip: ',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: themeChange.darkTheme
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                        Text(
                                          detailControllerStore.upsDetail!.ip!,
                                          style: TextStyle(
                                              fontSize: 12,
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
                                          'Status: ',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: themeChange.darkTheme
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                        Text(
                                          detailControllerStore
                                              .upsDetail!.connection!
                                              .toLowerCase(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: themeChange.darkTheme
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                        detailControllerStore
                                                    .upsDetail!.connection!
                                                    .toLowerCase() ==
                                                'connesso'
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
                                  ]),
                            ])),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: LinearPercentIndicator(
                              barRadius: Radius.circular(20),
                              lineHeight: 30.0,
                              center: Text(
                                detailControllerStore
                                    .upsDetail!.upsEstimatedChargeRemaining!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              percent: getPercentFromString(
                                  detailControllerStore
                                      .upsDetail!.upsEstimatedChargeRemaining!),
                              backgroundColor: Colors.grey,
                              progressColor: getColorFromPercentage(
                                  getPercentFromString(detailControllerStore
                                      .upsDetail!
                                      .upsEstimatedChargeRemaining!))),
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              RowElementUpsWidget(
                                  label: 'Uso ups:',
                                  value: detailControllerStore
                                      .upsDetail!.upsSecondsOnBattery!),
                              Divider(color: ThemeHelper.primaryElement),
                              RowElementUpsWidget(
                                  label: 'Minuti rimanenti:',
                                  value: detailControllerStore.upsDetail!
                                      .upsEstimatedMinutesRemaining!),
                              Divider(color: ThemeHelper.primaryElement),
                              RowElementUpsWidget(
                                  label: 'Voltaggio:',
                                  value: detailControllerStore
                                      .upsDetail!.upsBatteryVoltage!),
                              Divider(color: ThemeHelper.primaryElement),
                              RowElementUpsWidget(
                                  label: 'Fornitore:',
                                  value: detailControllerStore
                                      .upsDetail!.upsIdentManufacturer!),
                              Divider(color: ThemeHelper.primaryElement),
                            ],
                          ),
                        )
                      ],
                    );
                  }
                })))));
  }
}
