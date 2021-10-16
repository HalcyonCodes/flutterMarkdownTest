import 'package:flutter/cupertino.dart';
import '../style/styleSheet.dart';
import '../parse/parse.dart';
import 'package:markdown/markdown.dart' as md;
import '../widget/textWidget.dart';
import '../widget/listWidget.dart';
import '../widget/blockQuoteWidget.dart';
import '../widget/pWidget.dart';
import '../widget/imgWidget.dart';

class MdBuilder implements md.NodeVisitor {
  String data;
  double width;
  List<md.Node>? astNodes;
  List<Widget> bWidgets = [];
  StyleSheet? styleSheet;
  String lastTag = 'start';
  bool lastIsP = false;

  MdBuilder({required this.width, required this.data}) {
    styleSheet = StyleSheet();
    Parse parse = Parse(data: data);
    astNodes = parse.astNodes();

    astNodes!.forEach((e) {
      e.accept(this);
    });
  }

  @override
  void visitElementAfter(md.Element element) {
    //print(element.tag); //test
  }

  @override
  bool visitElementBefore(md.Element element) {
    blockSelect(element);
    return false;
  }

  @override
  void visitText(md.Text text) {
    //print(text.text);
  }

  void blockSelect(md.Element e) {
    bool isOnlyQuote = false;

    switch (e.tag) {
      case 'p':
        {
          bool isFirst = false;
          if (bWidgets.length == 0) isFirst = true;
          styleSheet!.fatherTextStyle = styleSheet!.normalStyle;
          Widget textWidget = TextWidget(
            lastTag: lastTag,
            e: e,
            st: styleSheet!,
            isFirst: isFirst,
            isEnd: false,
            isInQuote: false,
            isInList: false,
          );
          bWidgets.add(textWidget);
          lastTag = e.tag;

        }
        break;
      case 'h1':
        {
          bool isFirst = false;
          if (bWidgets.length == 0) isFirst = true;
          styleSheet!.fatherTextStyle = styleSheet!.h1;
          Widget textWidget = TextWidget(
            lastTag: lastTag,
            e: e,
            st: styleSheet!,
            isFirst: isFirst,
            isEnd: false,
            isInQuote: false,
            isInList: false,
          );
          bWidgets.add(textWidget);
          lastTag = e.tag;

        }
        break;
      case 'h2':
        {
          bool isFirst = false;
          if (bWidgets.length == 0) isFirst = true;
          styleSheet!.fatherTextStyle = styleSheet!.h2;
          Widget textWidget = TextWidget(
            lastTag: lastTag,
            e: e,
            st: styleSheet!,
            isFirst: isFirst,
            isEnd: false,
            isInQuote: false,
            isInList: false,
          );
          bWidgets.add(textWidget);
          lastTag = e.tag;
        }
        break;
      case 'h3':
        {
          bool isFirst = false;
          if (bWidgets.length == 0) isFirst = true;
          styleSheet!.fatherTextStyle = styleSheet!.h3;
          Widget textWidget = TextWidget(
            lastTag: lastTag,
            e: e,
            st: styleSheet!,
            isFirst: isFirst,
            isEnd: false,
            isInQuote: false,
            isInList: false,
          );
          bWidgets.add(textWidget);
          lastTag = e.tag;
        }
        break;
      case 'h4':
        {
          bool isFirst = false;
          if (bWidgets.length == 0) isFirst = true;
          styleSheet!.fatherTextStyle = styleSheet!.h4;
          Widget textWidget = TextWidget(
            lastTag: lastTag,
            e: e,
            st: styleSheet!,
            isFirst: isFirst,
            isEnd: false,
            isInQuote: false,
            isInList: false,
          );
          bWidgets.add(textWidget);
          lastTag = e.tag;
        }
        break;
      case 'h5':
        {
          bool isFirst = false;
          if (bWidgets.length == 0) isFirst = true;
          styleSheet!.fatherTextStyle = styleSheet!.h5;
          Widget textWidget = TextWidget(
            lastTag: lastTag,
            e: e,
            st: styleSheet!,
            isFirst: isFirst,
            isEnd: false,
            isInQuote: false,
            isInList: false,
          );
          bWidgets.add(textWidget);
          lastTag = e.tag;
        }
        break;
      case 'h6':
        {
          bool isFirst = false;
          if (bWidgets.length == 0) isFirst = true;
          styleSheet!.fatherTextStyle = styleSheet!.h6;
          Widget textWidget = TextWidget(
            lastTag: lastTag,
            e: e,
            st: styleSheet!,
            isFirst: isFirst,
            isEnd: false,
            isInQuote: false,
            isInList: false,
          );
          bWidgets.add(textWidget);
          lastTag = e.tag;
        }
        break;
      case 'ul':
        {
          bool isFirst = false;
          bool isEnd = false;
          if (bWidgets.length == 0) isFirst = true;
          styleSheet!.fatherTextStyle = styleSheet!.normalStyle;
          Widget listWidget = ListWidget(
            e: e,
            st: styleSheet!,
            isFirst: isFirst,
            width: width,
            isInQuote: false,
            isEnd: isEnd,
            lastTag: lastTag,
          );
          bWidgets.add(listWidget);
          lastTag = e.tag;
        }
        break;
      case 'blockquote':
        {
          //bool isEnd = false;
          //if (e == astNodes!.last) isEnd = true;
          if (e.children!.length == 1) {
            QuoteNodeVisitor qVister = QuoteNodeVisitor(
                st: styleSheet!, width: width, isInList: false);
            qVister.visit(e.children);
            isOnlyQuote = qVister.isOnlyQuote;
          }

          if (e.children!.length == 1)
            styleSheet!.fatherTextStyle = styleSheet!.normalStyle;
          Widget blockQuoteWidget = BlockQuoteWidget(
            e: e,
            st: styleSheet!,
            //isFirst: isFirst,
            isEnd: true,
            isInQuote: false,
            isOnlyQuote: isOnlyQuote,
            lastTag: lastTag,
            //quoteColor: Color.from,
            isInList: false,
            width: width,
          );
          bWidgets.add(blockQuoteWidget);
        }
    }
  }
}
