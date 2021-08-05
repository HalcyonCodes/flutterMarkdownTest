import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:markdown/markdown.dart' as md;

import '../style/styleSheet.dart';

class TextWidget extends StatefulWidget {
  List<WidgetSpan> texts = [];
  md.Element e;
  StyleSheet st;
  TextWidget({required this.e, required this.st}) {
    TextNodeVisitor tVisitor = TextNodeVisitor(st: st);
    tVisitor.visit(e.children);
    texts = tVisitor.textSpans;
  }

  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: widget.texts),
    );
  }
}

class TextNodeVisitor implements md.NodeVisitor {
  StyleSheet st;
  TextNodeVisitor({required this.st}) {
    styleTemps.add(st.fatherTextStyle!);
    CurrentStyle = styleTemps.last;
  }

  List<TextStyle> styleTemps = [];
  TextStyle? CurrentStyle;

  List<WidgetSpan> textSpans = [];

  Function()? tagAOntap;

  Function(bool)? tagAOnhover;

  bool isInTagA = false;

  int index = 0;
  void visit(List<md.Node>? nodes) {
    nodes!.forEach((e) {
      e.accept(this);
    });
  }

  @override
  void visitElementAfter(md.Element element) {}

  @override
  bool visitElementBefore(md.Element element) {
    //styleTemps.add(st.fatherTextStyle!);

    if (element.tag == 'a') {
      isInTagA = true;
      tagAOntap = () {
        //打开链接代码
        print(element.tag);
      };
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
    //isTagA = false;
    return false; //为false时不解析子节点的text节点
  }

  @override
  void visitText(md.Text text) {
    if (isInTagA == false) tagAOntap = null;
    WidgetSpan temp = WidgetSpan(
        child: InkWell(
      //splashFactory: ,
      radius: 0,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Text(
        text.text,
        style: CurrentStyle,
      ),
      onTap: tagAOntap,
      onHover: tagAOnhover,
    ));
    textSpans.add(temp);
  }

  TextStyle styleSelect(String tag) {
    switch (tag) {
      case 'p':
        {
          st.setStyleSheet();
          TextStyle t = st.normalStyle;
          st.fatherTextStyle = t;
          return t;
        }
      case 'h1':
        {
          st.setStyleSheet();
          TextStyle t = st.h1;
          st.fatherTextStyle = t;
          return t;
        }
      case 'h2':
        {
          st.setStyleSheet();
          TextStyle t = st.h2;
          st.fatherTextStyle = t;
          return t;
        }
      case 'h3':
        {
          st.setStyleSheet();
          TextStyle t = st.h3;
          st.fatherTextStyle = t;
          return t;
        }
      case 'h4':
        {
          st.setStyleSheet();
          TextStyle t = st.h4;
          st.fatherTextStyle = t;
          return t;
        }
      case 'h5':
        {
          st.setStyleSheet();
          TextStyle t = st.h5;
          st.fatherTextStyle = t;
          return t;
        }
      case 'h6':
        {
          st.setStyleSheet();
          TextStyle t = st.h6;
          st.fatherTextStyle = t;
          return t;
        }
      case 'a':
        {
          st.setStyleSheet();
          TextStyle t = st.a!;
          st.fatherTextStyle = t;
          return t;
        }
      case 'em':
        {
          st.setStyleSheet();
          TextStyle t = st.em!;
          st.fatherTextStyle = t;
          return t;
        }
      case 'strong':
        {
          st.setStyleSheet();
          TextStyle t = st.strong!;
          st.fatherTextStyle = t;
          return t;
        }
      case 'del':
        {
          st.setStyleSheet();
          TextStyle t = st.del!;
          st.fatherTextStyle = t;
          return t;
        }
    }
    return st.normalStyle;
  }
}
