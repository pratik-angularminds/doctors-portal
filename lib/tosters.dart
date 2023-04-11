import 'package:flutter/material.dart';

class Toasters {
  void danger(context,msg)
  {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: const Color(0xFFE57373),
        content: Text(msg)));
  }
  void success(context,msg)
  {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: const Color(0xFF66BB6A),
        content: Text(msg)));
  }
}
