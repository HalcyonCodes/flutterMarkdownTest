import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:markdown/markdown.dart' as md;
import '../style/styleSheet.dart';
import 'richTextWidget.dart';
import './imgWidget.dart';

class TextWidget extends StatelessWidget {
  double paddingTop = 0.0;
  double paddingBottom = 0.0;
  double paddingLeft = 0.0;
  double paddingright = 0.0;

  double marginTop = 0.0;
  double marginBottom = 0.0;
  double marginLeft = 0.0;
  double marginright = 0.0;
  bool isFirst;
  bool? hasImg;

  List<Widget> widgets = [];

  md.Element e;
  StyleSheet st;

  String? lastTag;
  bool isEnd;
  bool? isInQuote;
  bool? isInList;

  TextWidget({
    this.lastTag,
    required this.e,
    required this.st,
    required this.isFirst,
    required this.isEnd,
    this.isInQuote,
    this.isInList,
  }) {
    hasImg = false;
    selectFatherStyle();
    TextNodeVisitor visitor = TextNodeVisitor(
        e: e,
        st: st,
        isInQuote: isInQuote!,
        isFirst: isFirst,
        isEnd: isEnd,
        hasImg: hasImg);
    widgets = visitor.rowWidgets;
    hasImg = visitor.hasImg;
  }

  void selectFatherStyle() {
    switch (e.tag) {
      case 'h1':
        {
          st.fatherTextStyle = isInQuote!
              ? st.h1.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Color.fromRGBO(102, 102, 102, 1),
                )
              : st.h1;
        }
        break;
      case 'h2':
        {
          st.fatherTextStyle = isInQuote!
              ? st.h2.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Color.fromRGBO(102, 102, 102, 1),
                )
              : st.h2;
        }
        break;
      case 'h3':
        {
          st.fatherTextStyle = isInQuote!
              ? st.h3.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Color.fromRGBO(102, 102, 102, 1),
                )
              : st.h3;
        }
        break;
      case 'h4':
        {
          st.fatherTextStyle = isInQuote!
              ? st.h4.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Color.fromRGBO(102, 102, 102, 1),
                )
              : st.h4;
        }
        break;
      case 'h5':
        {
          st.fatherTextStyle = isInQuote!
              ? st.h5.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Color.fromRGBO(102, 102, 102, 1),
                )
              : st.h5;
        }
        break;
      case 'h6':
        {
          st.fatherTextStyle = isInQuote!
              ? st.h6.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Color.fromRGBO(102, 102, 102, 1),
                )
              : st.h6;
        }
        break;
      default:
        {
          st.fatherTextStyle = isInQuote!
              ? st.normalStyle.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Color.fromRGBO(102, 102, 102, 1),
                )
              : st.normalStyle;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    decoration();
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(
        top: isInList! ? 0 : marginTop,
        left: isInList! ? 0 : marginLeft,
        right: isInList! ? 0 : marginright,
        bottom: isInList! ? 0 : marginBottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(
                  bottom: isInList! ? 0 : paddingBottom,
                  top: isInList! ? 0 : paddingTop,
                  left: isInList! ? 0 : paddingLeft,
                  right: isInList! ? 0 : paddingright),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: widgets,
              )),
          if (e.tag == 'h1' && !isInList! || e.tag == 'h2' && !isInList!)
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

    switch (e.tag) {
      case 'li':
        {}
        break;
      case 'h1':
        {
          if (isFirst) {
            marginTop = 0;
          } else {
            if (lastTag == 'h1' ||
                lastTag == 'h2' ||
                lastTag == 'h3' ||
                lastTag == 'h4' ||
                lastTag == 'h5' ||
                lastTag == 'h6' ||
                lastTag == 'blockquote' ||
                lastTag == 'ul') {
              marginTop = 31.5 - 16;
            } else {
              marginTop = 31.5;
            }
          }
          marginBottom = isEnd ? 0 : 16;
          paddingBottom = 9.45;
        }
        break;
      case 'h2':
        {
          if (isFirst) {
            marginTop = 0;
          } else {
            if (lastTag == 'h1' ||
                lastTag == 'h2' ||
                lastTag == 'h3' ||
                lastTag == 'h4' ||
                lastTag == 'h5' ||
                lastTag == 'h6' ||
                lastTag == 'blockquote' ||
                lastTag == 'ul') {
              marginTop = 24.5 - 16;
            } else {
              marginTop = 24.5;
            }
          }
          marginBottom = isEnd ? 0 : 16;
          paddingBottom = 7.35;
        }
        break;
      case 'h3':
        {
          if (isFirst) {
            marginTop = 0;
          } else {
            if (lastTag == 'h1' ||
                lastTag == 'h2' ||
                lastTag == 'h3' ||
                lastTag == 'h4' ||
                lastTag == 'h5' ||
                lastTag == 'h6' ||
                lastTag == 'blockquote' ||
                lastTag == 'ul') {
              marginTop = 21 - 16;
            } else {
              marginTop = 21;
            }
          }
          marginBottom = isEnd ? 0 : 16;
          paddingBottom = 0;
        }
        break;
      case 'h4':
        {
          if (isFirst) {
            marginTop = 0;
          } else {
            if (lastTag == 'h1' ||
                lastTag == 'h2' ||
                lastTag == 'h3' ||
                lastTag == 'h4' ||
                lastTag == 'h5' ||
                lastTag == 'h6' ||
                lastTag == 'blockquote' ||
                lastTag == 'ul') {
              marginTop = 17.500 - 16;
            } else {
              marginTop = 17.500;
            }
          }
          marginBottom = isEnd ? 0 : 16;
          paddingBottom = 0;
        }
        break;
      case 'h5':
        {
          if (isFirst) {
            marginTop = 0;
          } else {
            if (lastTag == 'h1' ||
                lastTag == 'h2' ||
                lastTag == 'h3' ||
                lastTag == 'h4' ||
                lastTag == 'h5' ||
                lastTag == 'h6' ||
                lastTag == 'blockquote' ||
                lastTag == 'ul') {
              marginTop = 0; //14 -16
            } else {
              marginTop = 14;
            }
          }
          marginBottom = isEnd ? 0 : 16;
          paddingBottom = 0;
        }
        break;
      case 'h6':
        {
          if (isFirst) {
            marginTop = 0;
          } else {
            if (lastTag == 'h1' ||
                lastTag == 'h2' ||
                lastTag == 'h3' ||
                lastTag == 'h4' ||
                lastTag == 'h5' ||
                lastTag == 'h6' ||
                lastTag == 'blockquote' ||
                lastTag == 'ul') {
              marginTop = 0; //14-16
            } else {
              marginTop = 14;
            }
          }
          marginBottom = isEnd ? 0 : 16;
          paddingBottom = 0;
        }
        break;
    }
  }
}

class TextNodeVisitor implements md.NodeVisitor {
  TextStyle? fatherStyleTemp;
  List<Widget> rowWidgets = [];
  md.Element? eleTemp;
  md.Element e;
  StyleSheet st;
  bool isInQuote;
  bool isFirst;
  bool isEnd;
  bool? hasImg;

  List<md.Node> nodes = [];

  TextNodeVisitor({
    required this.e,
    required this.st,
    required this.isInQuote,
    required this.isFirst,
    required this.isEnd,
    required this.hasImg,
  }) {
    fatherStyleTemp = st.fatherTextStyle;
    eleTemp = md.Element.withTag(e.tag);
    visit(e.children);
  }

  void visit(List<md.Node>? nodes) {
    this.nodes = nodes!;
    nodes.forEach((e) {
      e.accept(this);
    });
  }

  @override
  void visitElementAfter(md.Element element) {}

  @override
  bool visitElementBefore(md.Element element) {
    if (element.tag == 'br') {
      if (eleTemp!.children!.length != 0) {
        rowWidgets.add(buidRichText());
        eleTemp!.children!.clear();
        st.fatherTextStyle = fatherStyleTemp;
      }
      rowWidgets.add(Row(
        children: [SizedBox()],
      ));
    }

    if (element.tag == 'img') {
      hasImg = true;
      if (eleTemp!.children!.length != 0) {
        rowWidgets.add(buidRichText());
        eleTemp!.children!.clear();
        st.fatherTextStyle = fatherStyleTemp;
      }

      String src = element.attributes['src'].toString();
      rowWidgets.add(ImgWidget(url: src));
    }
    if (element.tag == 'a') {
      TextABeforeImgVisitor vistor = TextABeforeImgVisitor();
      String clickUrl = element.attributes['src'].toString();
      element.children![0].accept(vistor);
      if (vistor.node != null) {
        if (vistor.node!.tag == 'img') {
          if (eleTemp!.children!.length != 0) {
            rowWidgets.add(buidRichText());
            eleTemp!.children!.clear();
            st.fatherTextStyle = fatherStyleTemp;
          }
          String url = vistor.node!.attributes['src'].toString();
          hasImg = true;
          rowWidgets.add(ImgWidget(
            url: url,
            clickUrl: clickUrl,
          ));
        } else {
          eleTemp!.children!.add(element);
        }
      } else {
        eleTemp!.children!.add(element);
      }
    }
    if (element.tag != 'img' && element.tag != 'a' && element.tag != 'br') {
      eleTemp!.children!.add(element);
    }

    if (element == nodes.last && eleTemp!.children!.length != 0) {
      rowWidgets.add(buidRichText());
      eleTemp!.children!.clear();
      st.fatherTextStyle = fatherStyleTemp;
    }
    return false;
  }

  @override
  void visitText(md.Text text) {
    String string = text.textContent.replaceAll(RegExp(r'\n'), 'd'); //消除换行符
    md.Text rText = md.Text(string);
    eleTemp!.children!.add(rText);

    if (text == nodes.last && eleTemp!.children!.length != 0) {
      rowWidgets.add(buidRichText());
      eleTemp!.children!.clear();
      st.fatherTextStyle = fatherStyleTemp;
    }
  }

  Widget buidRichText() {
    RichTextNodeVisitor tVisitor =
        RichTextNodeVisitor(st: st, isInQuote: isInQuote);
    tVisitor.visit(eleTemp!.children);
    List<TextSpan> texts = [];
    texts = tVisitor.textSpans;
    st.fatherTextStyle = st.normalStyle;
    if (isInQuote)
      st.fatherTextStyle = st.fatherTextStyle!.copyWith(
          fontStyle: FontStyle.italic, color: Color.fromRGBO(102, 102, 102, 1));
    return RichText(text: TextSpan(children: texts));
  }
}

class TextABeforeImgVisitor implements md.NodeVisitor {
  List<Widget> rowWidgets = [];
  md.Element? node;

  @override
  void visitElementAfter(md.Element element) {}

  @override
  bool visitElementBefore(md.Element element) {
    node = element;
    return false;
  }

  @override
  void visitText(md.Text text) {}
}
