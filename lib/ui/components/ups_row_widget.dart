import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../model/ups.dart';
import '../../model/user.dart';
import '../../provider/dark_theme_provider.dart';
import '../../utils/theme_helper.dart';
import '../controller_detail.dart';

class UpsRowWidget extends StatefulWidget {
  const UpsRowWidget(
      {super.key,
      required this.ups,
      required this.user,
      required this.searchValue});
  final User user;
  final List<Ups> ups;
  final String searchValue;
  @override
  State<UpsRowWidget> createState() => _UpsRowWidgetState();
}

class _UpsRowWidgetState extends State<UpsRowWidget> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Container(
        margin: EdgeInsets.all(8),
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
            itemCount: widget.ups
                .where((element) => element.name!
                    .toLowerCase()
                    .contains(widget.searchValue.toLowerCase()))
                .length,
            itemBuilder: ((context, index) => GestureDetector(
                onTap: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ControllerDetailPage(
                                user: widget.user,
                                idController: int.parse(widget.ups[index].id!),
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
                                widget.ups[index].name!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: themeChange.darkTheme
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ],
                          )
                        ],
                      ),
                      widget.ups[index].description == 'Online'
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
}
