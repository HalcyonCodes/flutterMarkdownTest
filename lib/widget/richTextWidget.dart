import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:markdown/markdown.dart' as md;
import '../style/styleSheet.dart';

class RichTextNodeVisitor implements md.NodeVisitor {
  StyleSheet st;
  TextStyle? CurrentStyle;

  RichTextNodeVisitor({required this.st, required this.isInQuote}) {
    styleTemps.add(st.fatherTextStyle!);
    CurrentStyle = styleTemps.last;
  }

  List<TextStyle> styleTemps = [];

  List<TextSpan> textSpans = [];

  TapGestureRecognizer? tapGes;

  Function()? tagAOntap;

  Function(bool)? tagAOnhover;

  bool isInTagA = false;

  int index = 0;

  bool isInQuote;

  void visit(List<md.Node>? nodes) {
    nodes!.forEach((e) {
      e.accept(this);
    });
  }

  @override
  void visitElementAfter(md.Element element) {}

  @override
  bool visitElementBefore(md.Element element) {
    if (element.tag == 'ul') return false;
    if (element.tag == 'a') {
      isInTagA = true;
      tapGes = TapGestureRecognizer();
      tagAOntap = () {
        //打开链接代码
        print(element.tag);
      };
      tapGes!..onTap = tagAOntap;
    }

    if (element.children != null) {
      CurrentStyle = styleSelect(element.tag);
      styleTemps.add(st.fatherTextStyle!);
      visit(element.children);
      if (isInTagA == true && element.tag == 'a') isInTagA = false;
      styleTemps.removeLast();
    }
    CurrentStyle = styleTemps.last;
    st.fatherTextStyle = CurrentStyle;
    return false; //为false时不解析子节点的text节点
  }

  @override
  void visitText(md.Text text) {
    if (isInTagA == false) {
      tapGes = null;
    }
    TextSpan temp = TextSpan(
      text: text.text,
      style: CurrentStyle,
      recognizer: tapGes,
    );

    textSpans.add(temp);
  }

  TextStyle styleSelect(String tag) {
    switch (tag) {
      case 'p':
        {
          st.setStyleSheet();
          TextStyle t = st.normalStyle;
          if (isInQuote)
            t = t.copyWith(
              fontStyle: FontStyle.italic,
              color: Color.fromRGBO(102, 102, 102, 1),
            );
          st.fatherTextStyle = t;
          return t;
        }
      case 'li':
        {
          st.setStyleSheet();
          TextStyle t = st.normalStyle;
          if (isInQuote)
            t = t.copyWith(
              fontStyle: FontStyle.italic,
              color: Color.fromRGBO(102, 102, 102, 1),
            );
          st.fatherTextStyle = t;
          return t;
        }
      case 'h1':
        {
          st.setStyleSheet();
          TextStyle t = st.h1;
          if (isInQuote)
            t = t.copyWith(
              fontStyle: FontStyle.italic,
              color: Color.fromRGBO(102, 102, 102, 1),
            );
          st.fatherTextStyle = t;
          return t;
        }
      case 'h2':
        {
          st.setStyleSheet();
          TextStyle t = st.h2;
          if (isInQuote)
            t = t.copyWith(
              fontStyle: FontStyle.italic,
              color: Color.fromRGBO(102, 102, 102, 1),
            );
          st.fatherTextStyle = t;
          return t;
        }
      case 'h3':
        {
          st.setStyleSheet();
          TextStyle t = st.h3;
          if (isInQuote)
            t = t.copyWith(
              fontStyle: FontStyle.italic,
              color: Color.fromRGBO(102, 102, 102, 1),
            );
          st.fatherTextStyle = t;
          return t;
        }
      case 'h4':
        {
          st.setStyleSheet();
          TextStyle t = st.h4;
          if (isInQuote)
            t = t.copyWith(
              fontStyle: FontStyle.italic,
              color: Color.fromRGBO(102, 102, 102, 1),
            );
          st.fatherTextStyle = t;
          return t;
        }
      case 'h5':
        {
          st.setStyleSheet();
          TextStyle t = st.h5;
          if (isInQuote)
            t = t.copyWith(
              fontStyle: FontStyle.italic,
              color: Color.fromRGBO(102, 102, 102, 1),
            );
          st.fatherTextStyle = t;
          return t;
        }
      case 'h6':
        {
          st.setStyleSheet();
          TextStyle t = st.h6;
          if (isInQuote)
            t = t.copyWith(
              fontStyle: FontStyle.italic,
              color: Color.fromRGBO(102, 102, 102, 1),
            );
          st.fatherTextStyle = t;
          return t;
        }
      case 'a':
        {
          st.setStyleSheet();
          TextStyle t = st.a!;
          if (isInQuote) t = t.copyWith(fontStyle: FontStyle.italic);
          st.fatherTextStyle = t;
          return t;
        }
      case 'em':
        {
          //字体改成italy
          st.setStyleSheet();
          TextStyle t = st.em!;
          if (isInQuote) t = t.copyWith(fontStyle: FontStyle.italic);
          st.fatherTextStyle = t;
          return t;
        }
      case 'strong':
        {
          st.setStyleSheet();
          TextStyle t = st.strong!;
          if (isInQuote) t = t.copyWith(fontStyle: FontStyle.italic);
          st.fatherTextStyle = t;
          return t;
        }
      case 'del':
        {
          st.setStyleSheet();
          TextStyle t = st.del!;
          if (isInQuote) t = t.copyWith(fontStyle: FontStyle.italic);
          st.fatherTextStyle = t;
          return t;
        }
      default:
        {
          st.setStyleSheet();
          TextStyle t = st.normalStyle;
          if (isInQuote)
            t = t.copyWith(
              fontStyle: FontStyle.italic,
              color: Color.fromRGBO(102, 102, 102, 1),
            );
          st.fatherTextStyle = t;
          return t;
        }
    }
  }
}
