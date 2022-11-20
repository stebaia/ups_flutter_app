import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

import '../model/user.dart';

class ControllerListPage extends StatefulWidget {
  const ControllerListPage({key, required this.user}) : super(key: key);

  final User user;

  @override
  State<ControllerListPage> createState() => _ControllerListPageState();
}

class _ControllerListPageState extends State<ControllerListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/nothing.json',
          fit: BoxFit.contain,
        ),
        Text('Non c\'è nessun controller qui..')
      ],
    ));
  }
}
