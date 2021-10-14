import 'package:flutter/material.dart';
import 'fditorPreview.dart';

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
              width: 150,
              height: 50,
              color: Colors.red,
              child: InkWell(
                onTap: () {
                  setState(() {});
                },
              ),
            ),
            Container(
                child: Container(
                    //height: 600,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    width: 700,
                    child: FditorPreview(
                      data: td.text,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                    )))
          ],
        ),
      ),
    );
  }
}
