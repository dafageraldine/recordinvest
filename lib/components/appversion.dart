import 'package:flutter/material.dart';

import '../models/data.dart';

class AppVersion extends StatelessWidget {
  const AppVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Record Invest v$Build.$Major.$Minor",
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.grey[800],
        fontSize: 16,
      ),
    );
  }
}
