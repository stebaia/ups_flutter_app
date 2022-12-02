import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../provider/dark_theme_provider.dart';

class RowElementUpsWidget extends StatelessWidget {
  const RowElementUpsWidget(
      {super.key, required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: themeChange.darkTheme ? Colors.white : Colors.black),
        ),
        Expanded(
          child: Text(
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            textDirection: TextDirection.rtl,
            value,
            style: TextStyle(
                fontSize: 12,
                color: themeChange.darkTheme ? Colors.white : Colors.black),
          ),
        )
      ],
    );
  }
}
