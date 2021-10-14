import 'package:flutter/material.dart';
import 'package:markdown/markdown.dart' as md;
import '../style/styleSheet.dart';
import './listWidget.dart';
import './textWidget.dart';

class BlockQuoteWidget extends StatelessWidget {
  Color? quoteColor;
  bool isEnd;
  md.Element e;
  StyleSheet st;
  //bool isFirst;
  bool isInQuote;
  bool isOnlyQuote;
  bool lastIsP;
  bool isInList;
  bool? hasImg;

  BlockQuoteWidget(
      {this.quoteColor,
      required this.e,
      required this.st,
      //required this.isFirst,
      required this.isEnd,
      required this.isInQuote,
      required this.isOnlyQuote,
      required this.lastIsP,
      required this.isInList}) {
    if (quoteColor == null) {
      quoteColor = Color.fromRGBO(221, 221, 221, 1.0);
    }
  }

  List<Widget> childrenWidget = [];
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
            left: 0, right: 0, top: lastIsP ? 16 : 0, bottom: isEnd ? 0 : 16),
        padding: EdgeInsets.only(
            left: 20,
            right: 15,
            top: 0,
            bottom: isOnlyQuote ? (isInQuote ? 2 : 0) : 2),
        decoration: BoxDecoration(
            border: Border(
          left: BorderSide(
            color: quoteColor!,
            width: 4.0,
          ),
        )),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.biggest.width;
            QuoteNodeVisitor quote = QuoteNodeVisitor(
              st: st,
              width: width,
              isInList: isInList,
            );
            quote.visit(e.children);
            List<Widget> widgets = quote.widgetsTemp;
            hasImg = quote.hasImg!;
            //hasImg = true;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: widgets,
            );
          },
        ));
  }
}

class QuoteNodeVisitor implements md.NodeVisitor {
  StyleSheet st;
  String? lastTag;
  List<Widget> widgetsTemp = [];
  double width;
  List<md.Node> nodes = [];
  bool isOnlyQuote = false;
  bool lastIsP = false;
  bool isInList;

  bool? hasImg;

  QuoteNodeVisitor({
    required this.st,
    required this.width,
    required this.isInList,
  });

  void visit(List<md.Node>? nodes) {
    this.nodes = nodes!;
    this.nodes.forEach((e) {
      e.accept(this);
    });
  }

  @override
  void visitElementAfter(md.Element element) {}

  @override
  bool visitElementBefore(md.Element element) {
    blockSelect(element);
    return false; //为false时不解析子节点的text节点
  }

  @override
  void visitText(md.Text text) {}

  void blockSelect(md.Element e) {
    //print('dd');

    switch (e.tag) {
      case 'p':
        {
          bool isFirst = false;
          bool isEnd = false;
          if (e == this.nodes.last) isEnd = true;
          if (widgetsTemp.length == 0) isFirst = true;
          st.fatherTextStyle = st.normalStyle.copyWith(
            fontStyle: FontStyle.italic,
            color: Color.fromRGBO(102, 102, 102, 1),
          );

          TextWidget textWidget = TextWidget(
            lastTag: lastTag,
            e: e,
            st: st,
            isFirst: isFirst,
            isEnd: isEnd,
            isInQuote: true,
            isInList: isInList,
          );
          hasImg = textWidget.hasImg;
          widgetsTemp.add(textWidget);
          lastTag = e.tag;
          lastIsP = true;
        }
        break;
      case 'h1':
        {
          bool isFirst = false;
          bool isEnd = false;
          if (e == this.nodes.last) isEnd = true;
          if (widgetsTemp.length == 0) isFirst = true;
          st.fatherTextStyle = st.h1.copyWith(
            fontStyle: FontStyle.italic,
            color: Color.fromRGBO(102, 102, 102, 1),
          );
          TextWidget textWidget = TextWidget(
            lastTag: lastTag,
            e: e,
            st: st,
            isFirst: isFirst,
            isEnd: isEnd,
            isInQuote: true,
            isInList: isInList,
          );
          hasImg = textWidget.hasImg!;
          widgetsTemp.add(textWidget);
          lastTag = e.tag;
          lastIsP = false;
        }
        break;
      case 'h2':
        {
          bool isFirst = false;
          bool isEnd = false;
          if (e == this.nodes.last) isEnd = true;
          if (widgetsTemp.length == 0) isFirst = true;
          st.fatherTextStyle = st.h2.copyWith(
            fontStyle: FontStyle.italic,
            color: Color.fromRGBO(102, 102, 102, 1),
          );
          TextWidget textWidget = TextWidget(
            lastTag: lastTag,
            e: e,
            st: st,
            isFirst: isFirst,
            isEnd: isEnd,
            isInQuote: true,
            isInList: isInList,
          );
          hasImg = textWidget.hasImg!;
          widgetsTemp.add(textWidget);
          lastTag = e.tag;
          lastIsP = false;
        }
        break;
      case 'h3':
        {
          bool isFirst = false;
          bool isEnd = false;
          if (e == this.nodes.last) isEnd = true;
          if (widgetsTemp.length == 0) isFirst = true;
          st.fatherTextStyle = st.h3.copyWith(
            fontStyle: FontStyle.italic,
            color: Color.fromRGBO(102, 102, 102, 1),
          );
          TextWidget textWidget = TextWidget(
            lastTag: lastTag,
            e: e,
            st: st,
            isFirst: isFirst,
            isEnd: isEnd,
            isInQuote: true,
            isInList: isInList,
          );
          hasImg = textWidget.hasImg!;
          widgetsTemp.add(textWidget);
          lastTag = e.tag;
          lastIsP = false;
        }
        break;
      case 'h4':
        {
          bool isFirst = false;
          bool isEnd = false;
          if (e == this.nodes.last) isEnd = true;
          if (widgetsTemp.length == 0) isFirst = true;
          st.fatherTextStyle = st.h4.copyWith(
            fontStyle: FontStyle.italic,
            color: Color.fromRGBO(102, 102, 102, 1),
          );
          TextWidget textWidget = TextWidget(
            lastTag: lastTag,
            e: e,
            st: st,
            isFirst: isFirst,
            isEnd: isEnd,
            isInQuote: true,
            isInList: isInList,
          );
          hasImg = textWidget.hasImg!;
          widgetsTemp.add(textWidget);
          lastTag = e.tag;
          lastIsP = false;
        }
        break;
      case 'h5':
        {
          bool isFirst = false;
          bool isEnd = false;
          if (e == this.nodes.last) isEnd = true;
          if (widgetsTemp.length == 0) isFirst = true;
          st.fatherTextStyle = st.h5.copyWith(
            fontStyle: FontStyle.italic,
            color: Color.fromRGBO(102, 102, 102, 1),
          );
          TextWidget textWidget = TextWidget(
            lastTag: lastTag,
            e: e,
            st: st,
            isFirst: isFirst,
            isEnd: isEnd,
            isInQuote: true,
            isInList: isInList,
          );
          hasImg = textWidget.hasImg!;
          widgetsTemp.add(textWidget);
          lastTag = e.tag;
          lastIsP = false;
        }
        break;
      case 'h6':
        {
          bool isFirst = false;
          bool isEnd = false;
          if (e == this.nodes.last) isEnd = true;
          if (widgetsTemp.length == 0) isFirst = true;

          st.fatherTextStyle = st.h6.copyWith(
            fontStyle: FontStyle.italic,
            color: Color.fromRGBO(102, 102, 102, 1),
          );
          TextWidget textWidget = TextWidget(
            lastTag: lastTag,
            e: e,
            st: st,
            isFirst: isFirst,
            isEnd: isEnd,
            isInQuote: true,
            isInList: isInList,
          );
          hasImg = textWidget.hasImg!;
          widgetsTemp.add(textWidget);
          lastTag = e.tag;
          lastIsP = false;
        }
        break;
      case 'ul':
        {
          bool isFirst = false;
          bool isEnd = false;
          if (widgetsTemp.length == 0) isFirst = true;
          if (e == this.nodes.last) isEnd = true;
          st.fatherTextStyle = st.normalStyle.copyWith(
            fontStyle: FontStyle.italic,
            color: Color.fromRGBO(102, 102, 102, 1),
          );
          Widget listWidget = ListWidget(
            e: e,
            st: st,
            isFirst: isFirst,
            width: width,
            isInQuote: true,
            isEnd: isEnd,
          );
          widgetsTemp.add(listWidget);
          lastIsP = false;
          lastTag = e.tag;
          //
        }
        break;
      case 'blockquote':
        {
          //bool isFirst = false;
          bool isEnd = false;
          //if (widgetsTemp.length == 0) isFirst = true;
          if (e == this.nodes.last) isEnd = true;
          if (e.tag == 'blockquote' && this.nodes.length == 1)
            isOnlyQuote = true;
          st.fatherTextStyle = st.normalStyle.copyWith(
            fontStyle: FontStyle.italic,
            color: Color.fromRGBO(102, 102, 102, 1),
          );
          Widget blockQuoteWidget = BlockQuoteWidget(
            e: e,
            st: st,
            //isFirst: isFirst,
            isEnd: isEnd,
            isInQuote: true,
            //quoteColor: Color.from,
            isOnlyQuote: isOnlyQuote,
            lastIsP: lastIsP,
            isInList: isInList,
          );
          widgetsTemp.add(blockQuoteWidget);
          lastIsP = false;
          lastTag = e.tag;
        }
    }
  }
}
