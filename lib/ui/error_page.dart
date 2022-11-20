import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ErrorPageScreen extends StatefulWidget {
  const ErrorPageScreen({Key? key, required this.error}) : super(key: key);
  final String error;
  @override
  State<ErrorPageScreen> createState() => _ErrorPageScreenState();
}

class _ErrorPageScreenState extends State<ErrorPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(widget.error),
      ),
    );
  }
}
