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
  bool isInQuote;
  bool isEnd;
  ListWidget({
    required this.width,
    required this.e,
    required this.st,
    required this.isFirst,
    required this.isInQuote,
    required this.isEnd,
  }) {
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
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: widdgets,
          ),
          if (!widget.isEnd)
            SizedBox(
              height: 16,
            )
        ],
      ),
    );
  }

  void bulidByMap() {
    String tagTemp;
    Widget decorationWidget;
    double spaceCount = 0;
    DecorationVisitor dVisiter = DecorationVisitor();
    int mapCount = widget.map!.length;
    int currentMapCount = 0;
    String lastTag = 'p';

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
              bool isEnd = false;
              if (currentMapCount == mapCount - 1) isEnd = true;
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
                      isEnd: isEnd,
                      isInQuote: widget.isInQuote,
                    ),
                    alignment: PlaceholderAlignment.baseline),
              );
              spaceCount = 1;
            }
            break;
          case 2:
            {
              bool isEnd = false;
              if (currentMapCount == mapCount - 1) isEnd = true;
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
                  isEnd: isEnd,
                  isInQuote: widget.isInQuote,
                ),
                alignment: PlaceholderAlignment.baseline,
              ));
              spaceCount = 2;
            }
            break;
          case 3:
            {
              bool isEnd = false;
              if (currentMapCount == mapCount - 1) isEnd = true;
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
                    isEnd: isEnd,
                    isInQuote: widget.isInQuote,
                  )));
              spaceCount = 3;
            }
            break;
          case 4:
            {
              bool isEnd = false;
              if (currentMapCount == mapCount - 1) isEnd = true;
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
                    isEnd: isEnd,
                    isInQuote: widget.isInQuote,
                  )));
              spaceCount = 4;
            }
            break;
          default:
            {
              bool isEnd = false;
              if (currentMapCount == mapCount - 1) isEnd = true;
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
                    isEnd: isEnd,
                    isInQuote: widget.isInQuote,
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
        bool isEnd = false;
        double marginTop;
        if (lastTag == 'h1' ||
            lastTag == 'h2' ||
            lastTag == 'h3' ||
            lastTag == 'h4' ||
            lastTag == 'h5' ||
            lastTag == 'h6' ||
            lastTag == 'blockquote') {
          marginTop = 31.5 - 16;
        } else {
          marginTop = 31.5;
        }

        if (currentMapCount == mapCount - 1) isEnd = true;
        decorationWidget = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!widget.isFirst)
              SizedBox(
                height: marginTop,
              ),
            Row(
              children: [row],
            ),
            SizedBox(
              height: 9.45,
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
              height: isEnd ? 0 : 16,
            )
          ],
        );
        lastTag = 'h1';
      } else if (tagTemp == 'h2') {
        bool isEnd = false;
        double marginTop;
        if (lastTag == 'h1' ||
            lastTag == 'h2' ||
            lastTag == 'h3' ||
            lastTag == 'h4' ||
            lastTag == 'h5' ||
            lastTag == 'h6' ||
            lastTag == 'blockquote') {
          marginTop = 24.5 - 16;
        } else {
          marginTop = 24.5;
        }
        if (currentMapCount == mapCount - 1) isEnd = true;
        decorationWidget = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!widget.isFirst)
              SizedBox(
                height: marginTop,
              ),
            Row(
              children: [row],
            ),
            SizedBox(
              height: 7.35,
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
              height: isEnd ? 0 : 16,
            )
          ],
        );
        lastTag = 'h2';
      } else if (tagTemp == 'h3') {
        bool isEnd = false;
        double marginTop;
        if (lastTag == 'h1' ||
            lastTag == 'h2' ||
            lastTag == 'h3' ||
            lastTag == 'h4' ||
            lastTag == 'h5' ||
            lastTag == 'h6' ||
            lastTag == 'blockquote') {
          marginTop = 21 - 16;
        } else {
          marginTop = 21;
        }
        if (currentMapCount == mapCount - 1) isEnd = true;
        decorationWidget = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!widget.isFirst)
              SizedBox(
                height: marginTop,
              ),
            Row(
              children: [row],
            ),
            SizedBox(
              height: isEnd ? 0 : 16,
            )
          ],
        );
        lastTag = 'h3';
      } else if (tagTemp == 'h4') {
        bool isEnd = false;
        double marginTop;
        if (lastTag == 'h1' ||
            lastTag == 'h2' ||
            lastTag == 'h3' ||
            lastTag == 'h4' ||
            lastTag == 'h5' ||
            lastTag == 'h6' ||
            lastTag == 'blockquote') {
          marginTop = 17.500 - 16;
        } else {
          marginTop = 17.500;
        }
        if (currentMapCount == mapCount - 1) isEnd = true;
        decorationWidget = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!widget.isFirst)
              SizedBox(
                height: marginTop,
              ),
            Row(
              children: [row],
            ),
            SizedBox(
              height: isEnd ? 0 : 16,
            )
          ],
        );
        lastTag = 'h4';
      } else if (tagTemp == 'h5') {
        bool isEnd = false;
        double marginTop;
        if (lastTag == 'h1' ||
            lastTag == 'h2' ||
            lastTag == 'h3' ||
            lastTag == 'h4' ||
            lastTag == 'h5' ||
            lastTag == 'h6' ||
            lastTag == 'blockquote') {
          marginTop = 0;
        } else {
          marginTop = 14;
        }
        if (currentMapCount == mapCount - 1) isEnd = true;
        decorationWidget = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!widget.isFirst)
              SizedBox(
                height: marginTop,
              ),
            Row(
              children: [row],
            ),
            SizedBox(
              height: isEnd ? 0 : 16,
            )
          ],
        );
        lastTag = 'h5';
      } else if (tagTemp == 'h6') {
        bool isEnd = false;
        double marginTop;
        if (lastTag == 'h1' ||
            lastTag == 'h2' ||
            lastTag == 'h3' ||
            lastTag == 'h4' ||
            lastTag == 'h5' ||
            lastTag == 'h6' ||
            lastTag == 'blockquote') {
          marginTop = 0;
        } else {
          marginTop = 14;
        }
        if (currentMapCount == mapCount - 1) isEnd = true;
        decorationWidget = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!widget.isFirst)
              SizedBox(
                height: marginTop,
              ),
            Row(
              children: [row],
            ),
            SizedBox(
              height: isEnd ? 0 : 16,
            )
          ],
        );
        lastTag = 'h6';
      } else {
        decorationWidget = row;
      }

      widdgets.add(decorationWidget);
      currentMapCount++;
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
