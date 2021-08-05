import 'package:flutter/material.dart';
//export 'package:md_fditor/style/styleSheet.dart';
import 'mdBuilder/mdBuilder.dart';
import 'package:markdown/markdown.dart' as md;

class Fditor {
  String data;
  List<Widget> bWidgets = [];

  Fditor({required this.data});

  void MarkdownToWidget() {
    MdBuilder d = MdBuilder(data: data);
    bWidgets = d.bWidgets;
  }
}
