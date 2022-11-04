import 'package:flutter/material.dart';
import 'package:flutter_navigation3/second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF3627E0),
        ),
      ),
      home: FirstPage(title: 'First Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key, required this.title});
  final String title;

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
            child: TextField(
              controller: textFieldController,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
              decoration: InputDecoration(
                hintText: '[Some hint text...]',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: InputBorder.none,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _sendText(context);
            },
            style: ElevatedButton.styleFrom(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              minimumSize: Size(132, 40),
            ),
            child: Text('Send',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _sendText(BuildContext context) {
    String inputText = textFieldController.text;
    Navigator.push(
        context,
        PageRouteBuilder(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.fastLinearToSlowEaseIn;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: Duration(seconds: 1),
          pageBuilder: (context, animation, secondaryAnimation) =>
              SecondPage(text: inputText),
        ));
  }
}
