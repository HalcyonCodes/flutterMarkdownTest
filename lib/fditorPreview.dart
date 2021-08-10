import 'package:flutter/material.dart';
import 'mdBuilder/mdBuilder.dart';

class FditorPreview extends StatefulWidget {
  String data;

  FditorPreview({required this.data});
  @override
  _FditorPreviewState createState() => _FditorPreviewState();
}

class _FditorPreviewState extends State<FditorPreview> {
  List<Widget> bWidgets = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.biggest.width;
          MdBuilder d = MdBuilder(width: width, data: widget.data);
          bWidgets = d.bWidgets;
          return Column(
            children: bWidgets,
          );
        },
      ),
    );
  }
}
