import 'package:flutter/cupertino.dart';
//import 'package:test/md_fditor.dart';
import '../style/styleSheet.dart';
import '../parse/parse.dart';
import '../widget/textWidget.dart';
import 'package:markdown/markdown.dart' as md;

class MdBuilder implements md.NodeVisitor {
  String data;
  List<md.Node>? astNodes;
  List<Widget> bWidgets = [];
  StyleSheet? styleSheet;

  MdBuilder({required this.data}) {
    styleSheet = StyleSheet();
    Parse parse = Parse(data: data);
    astNodes = parse.astNodes();

    astNodes!.forEach((e) {
      e.accept(this);
    });
  }

  @override
  void visitElementAfter(md.Element element) {
    //print(element.tag);
  }

  @override
  bool visitElementBefore(md.Element element) {
    blockSelect(element);
    return true;
  }

  @override
  void visitText(md.Text text) {
    //print(text.text);
  }

  void blockSelect(md.Element e) {
    switch (e.tag) {
      case 'p':
        {
          bool isFirst = false;
          if (bWidgets.length == 0) isFirst = true;
          styleSheet!.fatherTextStyle = styleSheet!.normalStyle;
          Widget textWidget = TextWidget(
            e: e,
            st: styleSheet!,
            isFirst: isFirst,
          );
          bWidgets.add(textWidget);
        }
        break;
      case 'h1':
        {
          bool isFirst = false;
          if (bWidgets.length == 0) isFirst = true;
          styleSheet!.fatherTextStyle = styleSheet!.h1;
          Widget textWidget = TextWidget(
            e: e,
            st: styleSheet!,
            isFirst: isFirst,
          );
          bWidgets.add(textWidget);
        }
        break;
      case 'h2':
        {
          bool isFirst = false;
          if (bWidgets.length == 0) isFirst = true;
          styleSheet!.fatherTextStyle = styleSheet!.h2;
          Widget textWidget = TextWidget(
            e: e,
            st: styleSheet!,
            isFirst: isFirst,
          );
          bWidgets.add(textWidget);
        }
        break;
      case 'h3':
        {
           bool isFirst = false;
          if (bWidgets.length == 0) isFirst = true;
          styleSheet!.fatherTextStyle = styleSheet!.h3;
          Widget textWidget = TextWidget(
            e: e,
            st: styleSheet!,
            isFirst: isFirst,
          );
          bWidgets.add(textWidget);
        }
        break;
      case 'h4':
        {
          bool isFirst = false;
          if (bWidgets.length == 0) isFirst = true;
          styleSheet!.fatherTextStyle = styleSheet!.h4;
          Widget textWidget = TextWidget(
            e: e,
            st: styleSheet!,
            isFirst: isFirst,
          );
          bWidgets.add(textWidget);
        }
        break;
      case 'h5':
        {
          bool isFirst = false;
          if (bWidgets.length == 0) isFirst = true;
          styleSheet!.fatherTextStyle = styleSheet!.h5;
          Widget textWidget = TextWidget(
            e: e,
            st: styleSheet!,
            isFirst: isFirst,
          );
          bWidgets.add(textWidget);
        }
        break;
      case 'h6':
        {
          bool isFirst = false;
          if (bWidgets.length == 0) isFirst = true;
          styleSheet!.fatherTextStyle = styleSheet!.h6;
          Widget textWidget = TextWidget(
            e: e,
            st: styleSheet!,
            isFirst: isFirst,
          );
          bWidgets.add(textWidget);
        }
        break;
    }
  }
}
