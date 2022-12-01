import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../model/controller.dart';
import '../../model/user.dart';
import '../../provider/dark_theme_provider.dart';
import '../../utils/theme_helper.dart';
import '../controller_detail.dart';

class ListControllerWidget extends StatefulWidget {
  const ListControllerWidget(
      {super.key,
      required this.controllers,
      required this.user,
      required this.isLimited});

  final List<Controller> controllers;
  final User user;
  final bool isLimited;
  @override
  State<ListControllerWidget> createState() => _ListControllerWidgetState();
}

class _ListControllerWidgetState extends State<ListControllerWidget> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            color: themeChange.darkTheme ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(20)),
        child: ListView.separated(
            separatorBuilder: (context, index) =>
                Divider(color: Colors.transparent),
            padding: EdgeInsets.all(4),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: elementLenght(widget.controllers.length),
            itemBuilder: ((context, index) => GestureDetector(
                onTap: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ControllerDetailPage(
                                user: widget.user,
                                idController: widget.controllers[index].id!,
                              ))));
                }),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color:
                          themeChange.darkTheme ? Colors.black : Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.controllers[index].name!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: themeChange.darkTheme
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              Text(
                                widget.controllers[index].lastCheck!,
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
                      widget.controllers[index].connection!.toLowerCase() ==
                              'online'
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
                )))));
  }

  int elementLenght(int size) {
    if (widget.isLimited && size >= 5) {
      return 5;
    } else if (widget.isLimited && size < 5) {
      return widget.controllers.length;
    } else if (!widget.isLimited) {
      return widget.controllers.length;
    } else {
      return widget.controllers.length;
    }
  }
}
