import 'package:flutter/material.dart';

snackBar(Color bg, Color fg, IconData icon, String msg) {
  return SnackBar(
    backgroundColor: bg,
    content: Row(
      children: [
        Icon(icon, color: fg),
        const SizedBox(width: 10),
        Text(msg, style: TextStyle(fontSize: 16, color: fg)),
      ],
    ),
  );
}

bool isDesktop(context) {
  if (MediaQuery.of(context).size.width > 400) {
    return true;
  } else {
    return false;
  }
}
