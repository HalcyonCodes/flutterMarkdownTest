import 'package:flutter/material.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:test/style/styleSheet.dart';
import './imgWidget.dart';
import './richTextWidget.dart';

class PWidget extends StatelessWidget {
  md.Element e;
  StyleSheet st;
  bool isFirst;
  bool isInQuote;
  bool isEnd;

  List<Widget> widgets = [];

  PWidget(
      {required this.e,
      required this.st,
      required this.isFirst,
      required this.isInQuote,
      required this.isEnd}) {
    PNodeVisitor visitor = PNodeVisitor(
        st: st, isInQuote: isInQuote, isFirst: isFirst, isEnd: isEnd);
    visitor.visit(e.children);
    widgets = visitor.rowWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.start,
      children: widgets,
    );
  }
}

class PNodeVisitor implements md.NodeVisitor {
  List<Widget> rowWidgets = [];
  md.Element eleTemp = md.Element.withTag('p');

  StyleSheet st;
  bool isInQuote;
  bool isFirst;
  bool isEnd;
  List<md.Node> nodes = [];

  PNodeVisitor({
    required this.st,
    required this.isInQuote,
    required this.isFirst,
    required this.isEnd,
  });

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
    if (element.tag == 'img') {
      if (eleTemp.children!.length != 0) {
        rowWidgets.add(buidRichText());
        eleTemp.children!.clear();
      }

      String src = element.attributes['src'].toString();
      rowWidgets.add(ImgWidget(url: src));
    }
    if (element.tag == 'a') {
      aBeforeImgVisitor vistor = aBeforeImgVisitor();
      String clickUrl = element.attributes['src'].toString();
      element.children![0].accept(vistor);
      if (vistor.node != null) {
        if (vistor.node!.tag == 'img') {
          if (eleTemp.children!.length != 0) {
            rowWidgets.add(buidRichText());
            eleTemp.children!.clear();
          }
          String url = vistor.node!.attributes['src'].toString();
          rowWidgets.add(ImgWidget(
            url: url,
            clickUrl: clickUrl,
          ));
        } else {
          eleTemp.children!.add(element);
        }
      } else {
        eleTemp.children!.add(element);
      }
    }
    if (element.tag != 'img' && element.tag != 'a') {
      eleTemp.children!.add(element);
    }

    if (element == nodes.last && eleTemp.children!.length != 0) {
      rowWidgets.add(buidRichText());
      eleTemp.children!.clear();
    }
    return false;
  }

  @override
  void visitText(md.Text text) {
    eleTemp.children!.add(text);

    if (text == nodes.last && eleTemp.children!.length != 0) {
      rowWidgets.add(buidRichText());
      eleTemp.children!.clear();
    }
  }

  Widget buidRichText() {
    RichTextNodeVisitor tVisitor = RichTextNodeVisitor(st: st, isInQuote: isInQuote);
    tVisitor.visit(eleTemp.children);
    List<TextSpan> texts = [];
    texts = tVisitor.textSpans;
    st.fatherTextStyle = st.normalStyle;
    if (isInQuote)
      st.fatherTextStyle = st.fatherTextStyle!.copyWith(
          fontStyle: FontStyle.italic, color: Color.fromRGBO(102, 102, 102, 1));
    return RichText(text: TextSpan(children: texts));
  }
}

class aBeforeImgVisitor implements md.NodeVisitor {
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
