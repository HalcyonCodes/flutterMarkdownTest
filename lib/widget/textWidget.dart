import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:markdown/markdown.dart' as md;

import '../style/styleSheet.dart';

class TextWidget extends StatefulWidget {
  double paddingTop = 0.0;
  double paddingBottom = 0.0;
  double paddingLeft = 0.0;
  double paddingright = 0.0;

  double marginTop = 0.0;
  double marginBottom = 0.0;
  double marginLeft = 0.0;
  double marginright = 0.0;
  bool isFirst;
  List<TextSpan> texts = [];
  md.Element e;
  StyleSheet st;
  TextWidget({required this.e, required this.st, required this.isFirst}) {
    paddingTop = 0.0;
    paddingBottom = 0.0;
    paddingLeft = 0.0;
    paddingright = 0.0;

    marginTop = 0.0;
    marginBottom = 0.0;
    marginLeft = 0.0;
    marginright = 0.0;
    TextNodeVisitor tVisitor = TextNodeVisitor(st: st);
    tVisitor.visit(e.children);
    texts = tVisitor.textSpans;
    st.fatherTextStyle = st.normalStyle;
  }

  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  void initState() {
    super.initState();
  }

  //md.Element? eTemp;

  @override
  Widget build(BuildContext context) {
    decoration();
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(
        top: widget.marginTop,
        left: widget.marginLeft,
        right: widget.marginright,
        bottom: widget.marginBottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(
                bottom: widget.paddingBottom,
                top: widget.paddingTop,
                left: widget.paddingLeft,
                right: widget.paddingright),
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(children: widget.texts),
            ),
          ),
          if (widget.e.tag == 'h1' || widget.e.tag == 'h2')
            Divider(
              height: 0.0,
              indent: 0.0,
              color: Colors.black.withOpacity(0.20),
              thickness: 0.7,
            )
        ],
      ),
    );
  }

  void decoration() {
    //eTemp = de;
    switch (widget.e.tag) {
      case 'li':
        {
          /* DecorationVisitor dv = DecorationVisitor();
          if (de.children != null) {
            if (de.runtimeType == md.Element) {
              de.children![0].accept(dv);
              decoration(dv.dve!);
            }
          }*/
        }
        break;
      case 'h1':
        {
          if (widget.isFirst) {
            widget.marginTop = 0;
          } else {
            widget.marginTop = 31.5;
          }
          widget.marginBottom = 16;
          widget.paddingBottom = 9;
        }
        break;
      case 'h2':
        {
          if (widget.isFirst) {
            widget.marginTop = 0;
          } else {
            widget.marginTop = 24.5;
          }
          widget.marginBottom = 16;
          widget.paddingBottom = 9;
        }
        break;
      case 'h3':
        {
          if (widget.isFirst) {
            widget.marginTop = 0;
          } else {
            widget.marginTop = 21;
          }
          widget.marginBottom = 16;
          widget.paddingBottom = 0;
        }
        break;
      case 'h4':
        {
          if (widget.isFirst) {
            widget.marginTop = 0;
          } else {
            widget.marginTop = 17.500;
          }
          widget.marginBottom = 16;
          widget.paddingBottom = 0;
        }
        break;
      case 'h5':
        {
          if (widget.isFirst) {
            widget.marginTop = 0;
          } else {
            widget.marginTop = 14;
          }
          widget.marginBottom = 16;
          widget.paddingBottom = 0;
        }
        break;
      case 'h6':
        {
          if (widget.isFirst) {
            widget.marginTop = 0;
          } else {
            widget.marginTop = 14;
          }
          widget.marginBottom = 16;
          widget.paddingBottom = 0;
        }
        break;
    }
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

  List<TextSpan> textSpans = [];

  TapGestureRecognizer? tapGes = null;

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
          st.fatherTextStyle = t;
          return t;
        }
      case 'li':
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


