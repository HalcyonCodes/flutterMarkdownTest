import 'dart:html';

import 'package:flutter/material.dart';
import '../style/styleSheet.dart';
import 'package:markdown/markdown.dart' as md;
import './textWidget.dart';

class ListWidget extends StatefulWidget {
  @override
  _ListWidgetState createState() => _ListWidgetState();
  bool isFirst;
  List<Widget> lists = [];
  md.Element e;
  StyleSheet st;
  double width;
  Map<String, md.Element>? map;
  ListWidget(
      {required this.width,
      required this.e,
      required this.st,
      required this.isFirst}) {
    ListNodeVisitor lVisitor = ListNodeVisitor();
    lVisitor.visitStar(e);
    map = lVisitor.map; //忽略'_0_'
  }
}

class _ListWidgetState extends State<ListWidget> {
  List<Widget> widdgets = [];
  @override
  Widget build(BuildContext context) {
    widdgets = [];
    bulidByMap();
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: widdgets,
      ),
    );
  }

  void bulidByMap() {
    String tagTemp;
    Widget decorationWidget;
    double spaceCount = 0;
    DecorationVisitor dVisiter = DecorationVisitor();

    widget.map!.forEach((key, value) {
      tagTemp = 'p';
      decorationWidget = SizedBox();
      if (widdgets.length != 0) widget.isFirst = false;
      List<String> temp = key.split('_');
      int length = temp.length - 2;
      List<InlineSpan> rowTemp = [];

      if (length * 28 >= widget.width) {
      } else {
        switch (length) {
          case 1:
            {
              rowTemp.add(WidgetSpan(
                  baseline: TextBaseline.alphabetic,
                  alignment: PlaceholderAlignment.baseline,
                  child: blackDot()));
              rowTemp.add(
                WidgetSpan(
                    baseline: TextBaseline.alphabetic,
                    child: TextWidget(
                      e: value,
                      st: widget.st,
                      isFirst: widget.isFirst,
                    ),
                    alignment: PlaceholderAlignment.baseline),
              );
              spaceCount = 1;
            }
            break;
          case 2:
            {
              rowTemp.add(WidgetSpan(
                  baseline: TextBaseline.alphabetic,
                  alignment: PlaceholderAlignment.baseline,
                  child: offsetPlace()));
              rowTemp.add(WidgetSpan(
                  baseline: TextBaseline.alphabetic,
                  alignment: PlaceholderAlignment.baseline,
                  child: whitekDot()));
              rowTemp.add(WidgetSpan(
                baseline: TextBaseline.alphabetic,
                child: TextWidget(
                  e: value,
                  st: widget.st,
                  isFirst: widget.isFirst,
                ),
                alignment: PlaceholderAlignment.baseline,
              ));
              spaceCount = 2;
            }
            break;
          case 3:
            {
              rowTemp.add(WidgetSpan(
                  baseline: TextBaseline.alphabetic,
                  alignment: PlaceholderAlignment.baseline,
                  child: offsetPlace()));
              rowTemp.add(WidgetSpan(
                  baseline: TextBaseline.alphabetic,
                  alignment: PlaceholderAlignment.baseline,
                  child: offsetPlace()));
              rowTemp.add(WidgetSpan(
                  baseline: TextBaseline.alphabetic,
                  alignment: PlaceholderAlignment.baseline,
                  child: rectBlackDot()));
              rowTemp.add(WidgetSpan(
                  baseline: TextBaseline.alphabetic,
                  alignment: PlaceholderAlignment.baseline,
                  child: TextWidget(
                    e: value,
                    st: widget.st,
                    isFirst: widget.isFirst,
                  )));
              spaceCount = 3;
            }
            break;
          case 4:
            {
              rowTemp.add(WidgetSpan(
                  baseline: TextBaseline.alphabetic,
                  alignment: PlaceholderAlignment.baseline,
                  child: offsetPlace()));
              rowTemp.add(WidgetSpan(
                  baseline: TextBaseline.alphabetic,
                  alignment: PlaceholderAlignment.baseline,
                  child: offsetPlace()));
              rowTemp.add(WidgetSpan(
                  baseline: TextBaseline.alphabetic,
                  alignment: PlaceholderAlignment.baseline,
                  child: offsetPlace()));
              rowTemp.add(WidgetSpan(
                  baseline: TextBaseline.alphabetic,
                  alignment: PlaceholderAlignment.baseline,
                  child: rectBlackDot()));
              rowTemp.add(WidgetSpan(
                  baseline: TextBaseline.alphabetic,
                  alignment: PlaceholderAlignment.baseline,
                  child: TextWidget(
                    e: value,
                    st: widget.st,
                    isFirst: widget.isFirst,
                  )));
              spaceCount = 4;
            }
            break;
          default:
            {
              int i = 0;
              for (i = 0; i < length - 1; i++) {
                rowTemp.add(WidgetSpan(
                    baseline: TextBaseline.alphabetic,
                    alignment: PlaceholderAlignment.baseline,
                    child: offsetPlace()));
              }
              rowTemp.add(WidgetSpan(
                  baseline: TextBaseline.alphabetic,
                  alignment: PlaceholderAlignment.baseline,
                  child: rectBlackDot()));
              rowTemp.add(WidgetSpan(
                  baseline: TextBaseline.alphabetic,
                  alignment: PlaceholderAlignment.baseline,
                  child: TextWidget(
                    e: value,
                    st: widget.st,
                    isFirst: widget.isFirst,
                  )));
              spaceCount = i + 1;
            }
            break;
        }
      }

      Widget row = RichText(
        softWrap: false,
        overflow: TextOverflow.visible,
        text: TextSpan(children: rowTemp),
      );
      if (value.children != null) {
        value.children![0].accept(dVisiter);
        if (dVisiter.dve != null) {
          tagTemp = dVisiter.dve!.tag;
        } else {
          tagTemp = 'p';
        }
      }

      if (tagTemp == 'h1') {
        decorationWidget = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!widget.isFirst)
              SizedBox(
                height: 31.5,
              ),
            Row(
              children: [row],
            ),
            SizedBox(
              height: 9,
            ),
            Container(
              padding: EdgeInsets.only(left: 28.00 * spaceCount),
              child: Divider(
                height: 0.0,
                indent: 0.0,
                color: Colors.black.withOpacity(0.20),
                thickness: 0.7,
              ),
            ),
            SizedBox(
              height: 16,
            )
          ],
        );
      } else if (tagTemp == 'h2') {
        decorationWidget = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!widget.isFirst)
              SizedBox(
                height: 31.5,
              ),
            Row(
              children: [row],
            ),
            SizedBox(
              height: 9,
            ),
            Container(
              padding: EdgeInsets.only(left: 28.00 * spaceCount),
              child: Divider(
                height: 0.0,
                indent: 0.0,
                color: Colors.black.withOpacity(0.20),
                thickness: 0.7,
              ),
            ),
            SizedBox(
              height: 16,
            )
          ],
        );
      } else {
        decorationWidget = row;
      }

      widdgets.add(decorationWidget);
    });
  }

  Widget offsetPlace() {
    return Container(
      width: 28,
    );
  }

  Widget blackDot() {
    return Container(
      width: 28,
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(
                Radius.circular(2.5),
              ),
            ),
          ),
          SizedBox(
            height: 3,
          )
        ],
      ),
    );
  }

  Widget whitekDot() {
    return Column(
      children: [
        Container(
            width: 28,
            alignment: Alignment.center,
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(2.5),
                ),
                border: Border.all(color: Colors.black, width: 0.5),
              ),
            )),
        SizedBox(
          height: 3,
        )
      ],
    );
  }

  Widget rectWhiteDot() {
    return Column(
      children: [
        Container(
            width: 28,
            alignment: Alignment.center,
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 0.5),
              ),
            )),
        SizedBox(
          height: 3,
        )
      ],
    );
  }

  Widget rectBlackDot() {
    return Column(
      children: [
        Container(
            width: 28,
            alignment: Alignment.center,
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            )),
        SizedBox(
          height: 3,
        )
      ],
    );
  }
}

class ListNodeVisitor implements md.NodeVisitor {
  Map<String, md.Element> map = {};
  ListNodeVisitor() {
    map = {};
    index = 0;
    key = '0_0';
    maxKeyLength = 0;
    currentKey = '';
    keyTemp = [];
    isFirst = true;
  }

  int index = 0;

  String key = '0_0';
  int maxKeyLength = 0;
  String currentKey = '';
  List<String> keyTemp = [];
  bool isFirst = true;

  void visitStar(md.Element e) {
    e.accept(this);
  }

  void visit(List<md.Node>? nodes) {
    nodes!.forEach((e) {
      e.accept(this);
    });
  }

  @override
  void visitElementAfter(md.Element element) {}

  @override
  bool visitElementBefore(md.Element element) {
    if (element.tag == 'li' || element.tag == 'ul') {
      if (element.tag == 'ul') {
        keyTemp = key.split('_');
        currentKey = keyTemp[maxKeyLength];
        maxKeyLength = maxKeyLength + 1;
      }
      if (element.tag == 'li') {
        currentKey = (int.tryParse(currentKey)! + 1).toString();
        key = '';

        for (int n = 0; n < keyTemp.length - 1; n++) {
          if (n == keyTemp.length - 2 && n != 0) {
            key = key + currentKey + '_' + '0' + '_';
          } else if (n == 0 && n != keyTemp.length - 2) {
            key = keyTemp[0] + '_';
          } else if (n == 0 && n == keyTemp.length - 2) {
            key = currentKey + '_' + '0' + '_';
          } else {
            key = key + keyTemp[n] + '_';
          }
        }

        map.putIfAbsent(key, () => element);
      }
      if (element.children != null) {
        visit(element.children);
      }
      if (element.tag == 'ul') {
        if (isFirst == true) {
          maxKeyLength = maxKeyLength - 1;
          isFirst = false;
        }
        maxKeyLength = maxKeyLength - 1;
        if (maxKeyLength == -1) maxKeyLength = 0;
        keyTemp = key.split('_');

        currentKey = keyTemp[maxKeyLength];
        for (int i = 0; i <= maxKeyLength; i++) {
          if (i == 0 && maxKeyLength == 0) {
            key = currentKey + '_' + '0';
          } else if (i == 0 && maxKeyLength != 0) {
            key = keyTemp[0] + '_';
          } else if (i == maxKeyLength && i != 0) {
            key = key + keyTemp[i] + '_' + '0';
          } else {
            key = key + keyTemp[i] + '_';
          }
        }
        keyTemp = key.split('_');
      }
    }

    return false;
  }

  @override
  void visitText(md.Text text) {}
}

class DecorationVisitor implements md.NodeVisitor {
  md.Element? dve;

  @override
  void visitElementAfter(md.Element element) {}

  @override
  bool visitElementBefore(md.Element element) {
    dve = element;

    return false;
  }

  @override
  void visitText(md.Text text) {
    dve = null;
  }
}
