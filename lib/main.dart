import 'package:flutter/material.dart';
import './md_fditor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> bWidgets = [];
  TextEditingController td = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: td,
              keyboardType: TextInputType.multiline,
              scrollPhysics: NeverScrollableScrollPhysics(),
              maxLines: 40,
              minLines: 1,
              //cursorHeight: 100,
              cursorHeight: 5,
              //strutStyle: StrutStyle(height: 1.6),
            ),
            Container(
              width: 100,
              height: 100,
              color: Colors.red,
              child: InkWell(
                onTap: () {
                  Fditor d = Fditor(data: td.text);
                  d.MarkdownToWidget();
                  bWidgets = d.bWidgets;
                  setState(() {});
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: bWidgets,
              ),
            )
          ],
        ),
      ),
    );
  }
}
