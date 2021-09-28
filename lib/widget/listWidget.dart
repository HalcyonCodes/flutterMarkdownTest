import 'package:flutter/material.dart';
import 'package:test/mdBuilder/mdBuilder.dart';
import '../style/styleSheet.dart';
import 'package:markdown/markdown.dart' as md;
import './textWidget.dart';
import './blockQuoteWidget.dart';

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
    return Container(
      child: LayoutBuilder(builder: (context, constrains) {
        double width = constrains.biggest.width;
        widdgets = [];
        bulidByMap(width);

        return Column(
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
        );
      }),
    );
  }

  void bulidByMap(double width) {
    String tagTemp;
    Widget decorationWidget;
    double spaceCount = 0;
    DecorationVisitor dVisiter = DecorationVisitor();
    DecorationVisitor quoteOffsetVisiter = DecorationVisitor();
    DecorationVisitor dotHeightVisiter = DecorationVisitor();

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

      bool isQuote = false;
      if (value.children != null) {
        value.children![0].accept(quoteOffsetVisiter);
        if (quoteOffsetVisiter.dve != null)
          isQuote = quoteOffsetVisiter.dve!.tag == 'blockquote' ? true : false;
      }

      if (length * 28 >= widget.width) {
      } else {
        switch (length) {
          case 1:
            {
              bool isEnd = false;
              if (currentMapCount == mapCount - 1) isEnd = true;
              if (temp[length - 1] == 'X') {
                rowTemp.add(WidgetSpan(
                    baseline: TextBaseline.alphabetic,
                    alignment: PlaceholderAlignment.baseline,
                    child: offsetPlace()));
              } else {
                rowTemp.add(WidgetSpan(
                    baseline: TextBaseline.alphabetic,
                    alignment: PlaceholderAlignment.baseline,
                    child: blackDot()));
              }
              double textWidth = width - 28;
              if (!isQuote)
                rowTemp.add(
                  WidgetSpan(
                      baseline: TextBaseline.alphabetic,
                      child: Container(
                        width: textWidth,
                        child: TextWidget(
                          e: value,
                          st: widget.st,
                          isFirst: widget.isFirst,
                          isEnd: isEnd,
                          isInQuote: widget.isInQuote,
                        ),
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
              if (temp[length - 1] == 'X') {
                rowTemp.add(WidgetSpan(
                    baseline: TextBaseline.alphabetic,
                    alignment: PlaceholderAlignment.baseline,
                    child: offsetPlace()));
                rowTemp.add(WidgetSpan(
                    baseline: TextBaseline.alphabetic,
                    alignment: PlaceholderAlignment.baseline,
                    child: offsetPlace()));
              } else {
                rowTemp.add(WidgetSpan(
                    baseline: TextBaseline.alphabetic,
                    alignment: PlaceholderAlignment.baseline,
                    child: offsetPlace()));
                rowTemp.add(WidgetSpan(
                    baseline: TextBaseline.alphabetic,
                    alignment: PlaceholderAlignment.baseline,
                    child: whitekDot()));
              }
              double textWidth = width - 28 * length;
              if (!isQuote)
                rowTemp.add(WidgetSpan(
                  baseline: TextBaseline.alphabetic,
                  child: Container(
                    width: textWidth,
                    child: TextWidget(
                      e: value,
                      st: widget.st,
                      isFirst: widget.isFirst,
                      isEnd: isEnd,
                      isInQuote: widget.isInQuote,
                    ),
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
              if (temp[length - 1] == 'X') {
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
              } else {
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
              }
              double textWidth = width - 28 * length;
              if (!isQuote)
                rowTemp.add(WidgetSpan(
                    baseline: TextBaseline.alphabetic,
                    alignment: PlaceholderAlignment.baseline,
                    child: Container(
                      width: textWidth,
                      child: TextWidget(
                        e: value,
                        st: widget.st,
                        isFirst: widget.isFirst,
                        isEnd: isEnd,
                        isInQuote: widget.isInQuote,
                      ),
                    )));
              spaceCount = 3;
            }
            break;
          case 4:
            {
              bool isEnd = false;
              if (currentMapCount == mapCount - 1) isEnd = true;
              if (temp[length - 1] == 'X') {
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
                    child: offsetPlace()));
              } else {
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
              }
              double textWidth = width - 28 * length;
              if (!isQuote)
                rowTemp.add(WidgetSpan(
                    baseline: TextBaseline.alphabetic,
                    alignment: PlaceholderAlignment.baseline,
                    child: Container(
                      width: textWidth,
                      child: TextWidget(
                        e: value,
                        st: widget.st,
                        isFirst: widget.isFirst,
                        isEnd: isEnd,
                        isInQuote: widget.isInQuote,
                      ),
                    )));
              spaceCount = 4;
            }
            break;
          default:
            {
              bool isEnd = false;
              if (currentMapCount == mapCount - 1) isEnd = true;
              int i = 0;
              if (temp[length - 1] == 'X') {
                for (i = 0; i < length; i++) {
                  rowTemp.add(WidgetSpan(
                      baseline: TextBaseline.alphabetic,
                      alignment: PlaceholderAlignment.baseline,
                      child: offsetPlace()));
                }
              } else {
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
              }
              double textWidth = width - 28 * length;
              if (!isQuote)
                rowTemp.add(WidgetSpan(
                    baseline: TextBaseline.alphabetic,
                    alignment: PlaceholderAlignment.baseline,
                    child: Container(
                      width: textWidth,
                      child: TextWidget(
                        e: value,
                        st: widget.st,
                        isFirst: widget.isFirst,
                        isEnd: isEnd,
                        isInQuote: widget.isInQuote,
                      ),
                    )));
              spaceCount = i + 1;
            }
            break;
        }
      }

      if (value.children != null) {
        value.children![0].accept(dVisiter);
        if (dVisiter.dve != null) {
          tagTemp = dVisiter.dve!.tag;
        } else {
          tagTemp = 'p';
        }
      }

      TextStyle dotStyle = widget.st.normalStyle;
      if (tagTemp == 'blockquote') {
        md.Element devEle = dVisiter.dve!;
        int i = 0;
        while (i == 0) {
          devEle.children![0].accept(dotHeightVisiter);
          switch (dotHeightVisiter.dve!.tag) {
            case 'p':
              dotStyle =
                  widget.st.normalStyle.copyWith(fontStyle: FontStyle.italic);
              i = 1;
              break;
            case 'h1':
              dotStyle = widget.st.h1.copyWith(fontStyle: FontStyle.italic);
              i = 1;
              break;
            case 'h2':
              dotStyle = widget.st.h2.copyWith(fontStyle: FontStyle.italic);
              i = 1;
              break;
            case 'h3':
              dotStyle = widget.st.h3.copyWith(fontStyle: FontStyle.italic);
              i = 1;
              break;
            case 'h4':
              dotStyle = widget.st.h4.copyWith(fontStyle: FontStyle.italic);
              i = 1;
              break;
            case 'h5':
              dotStyle = widget.st.h5.copyWith(fontStyle: FontStyle.italic);
              i = 1;
              break;
            case 'h6':
              dotStyle = widget.st.h6.copyWith(fontStyle: FontStyle.italic);
              i = 1;
              break;
            default:
              devEle = dotHeightVisiter.dve!;
              break;
          }
        }
      }

      rowTemp.add(WidgetSpan(
        baseline: TextBaseline.alphabetic,
        alignment: PlaceholderAlignment.baseline,
        child: Text(
          '',
          style: dotStyle,
        ),
      ));

      Widget row = RichText(
        //maxLines: 1, //true
        softWrap: false, //
        overflow: TextOverflow.clip,
        text: TextSpan(children: rowTemp),
      );

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
            row,
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
            row,
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
            row,
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
            row,
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
            row,
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
            row,
            SizedBox(
              height: isEnd ? 0 : 16,
            )
          ],
        );
        lastTag = 'h6';
      } else if (tagTemp == 'p') {
        decorationWidget = row;
        lastTag = 'p';
      } else if (tagTemp == 'blockquote') {
        bool isEnd = false;
        if (currentMapCount == mapCount - 1) isEnd = true;
        decorationWidget = Column(
          children: [
            if (lastTag == 'p')
              SizedBox(
                height: 6,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                row,
                Expanded(
                  child: Container(
                    child: BlockQuoteWidget(
                        e: dVisiter.dve!,
                        st: widget.st,
                        isEnd: isEnd,
                        isInQuote: false,
                        isOnlyQuote: false,
                        lastIsP: false),
                  ),
                ),
              ],
            ),
          ],
        );
      } else {
        decorationWidget = row;
        lastTag = 'p';
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
  bool isSameLevel = false;

  void visitStar(md.Element e) {
    e.accept(this);
  }

  void visit(
    List<md.Node>? nodes,
  ) {
    isSameLevel = false;
    nodes!.forEach((e) {
      e.accept(this);
      //isSameLevel = true;
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
        //map.putIfAbsent(key, () => element);
        DecorationVisitor dk = DecorationVisitor();

        md.Element eleTrueTemp = md.Element.withTag('p');
        element.children!.forEach((e) {
          e.accept(dk);
          if (dk.dve == null) {
            eleTrueTemp.children!.add(e);

            if (element.children!.last == e && element.children!.length != 0) {
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

              md.Element eleeTemp = md.Element.withTag('p');
              eleTrueTemp.children!.forEach((e) {
                eleeTemp.children!.add(e);
              });
              map.putIfAbsent(key, () => eleeTemp);
              eleTrueTemp.children!.clear();
            }
          } else if (dk.dve!.tag == 'p' ||
              dk.dve!.tag == 'h1' ||
              dk.dve!.tag == 'h2' ||
              dk.dve!.tag == 'h3' ||
              dk.dve!.tag == 'h4' ||
              dk.dve!.tag == 'h5' ||
              dk.dve!.tag == 'h6' ||
              dk.dve!.tag == 'blockquote' ||
              dk.dve!.tag == 'ul') {
            if (element.children!.first == e) {
              //
              eleTrueTemp.children!.add(e);
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
              md.Element eleeTemp = md.Element.withTag('p');
              eleTrueTemp.children!.forEach((e) {
                eleeTemp.children!.add(e);
              });
              map.putIfAbsent(key, () => eleeTemp);
              eleTrueTemp.children!.clear();
            } else {
              if (eleTrueTemp.children!.length != 0) {
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
                md.Element eleTemp = md.Element.withTag('p');
                eleTrueTemp.children!.forEach((e) {
                  eleTemp.children!.add(e);
                });
                map.putIfAbsent(key, () => eleTemp);

                eleTrueTemp.children!.clear();
              }

              if (dk.dve!.tag == 'ul') {
                keyTemp = key.split('_');
                currentKey = keyTemp[maxKeyLength];
                maxKeyLength = maxKeyLength + 1;
                visit(dk.dve!.children);
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
              if (dk.dve!.tag == 'p' ||
                  dk.dve!.tag == 'h1' ||
                  dk.dve!.tag == 'h2' ||
                  dk.dve!.tag == 'h3' ||
                  dk.dve!.tag == 'h4' ||
                  dk.dve!.tag == 'h5' ||
                  dk.dve!.tag == 'h6' ||
                  dk.dve!.tag == 'blockquote') {
                eleTrueTemp.children!.add(e);
                currentKey = (int.tryParse(currentKey)! + 1).toString();
                key = '';
                //
                String currentKeyTemp = '';
                currentKeyTemp = currentKey;
                currentKey = 'X';

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
                md.Element eleeTemp = md.Element.withTag('p');
                eleTrueTemp.children!.forEach((e) {
                  eleeTemp.children!.add(e);
                });
                map.putIfAbsent(key, () => eleeTemp);
                eleTrueTemp.children!.clear();
                //
                currentKey = currentKeyTemp;
              }
            }
          } else {
            eleTrueTemp.children!.add(e);
            if (element.children!.last == e && element.children!.length != 0) {
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
              md.Element eleTemp = md.Element.withTag('p');
              eleTrueTemp.children!.forEach((e) {
                eleTemp.children!.add(e);
              });
              map.putIfAbsent(key, () => eleTemp);

              eleTrueTemp.children!.clear();
            }
          }
        });
      }
      if (element.children != null && element.tag == 'ul') {
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
