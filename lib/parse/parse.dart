import 'dart:convert';
import 'package:markdown/markdown.dart' as md;

class Parse {
  String data;
  Parse({required this.data});

  List<md.Node>? astNodes() {
    final List<String> lines = const LineSplitter().convert(data);
    md.Document dc = md.Document();
    List<md.Node>? temp = dc.parseLines(lines);

    return temp;
  }
}
