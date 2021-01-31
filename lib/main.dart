import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pesel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Pesel App Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String birthDay = "";
  String sex = "";
  String isValid = "Not Valid";
  final myController = TextEditingController();

  @override void dispose() {
    myController.dispose();
    super.dispose();
  }

  void validatePesel() {
    String pesel = myController.text;

    birthDay = "";
    sex = "";
    isValid = "Not Valid";

    if(pesel.length != 11){
      return;
    }


    int year = int.parse(pesel.substring(0,2));
    int month = int.parse(pesel.substring(2,4));
    int day = int.parse(pesel.substring(4,6));
    if(month < 20){
      year += 1900;
    }
    else{
      year += 2000;
      month -= 20;
    }
    int controlSum = 0;
    var wages = [1,3,7,9,1,3,7,9,1,3,1];
    for(var i = 0; i < pesel.length - 1; i++){
      controlSum += wages[i] * int.parse(pesel.substring(i, i + 1));
    }
    controlSum = controlSum % 10;
    if(controlSum != 0){
      controlSum = 10 - (controlSum % 10);
    }
    if(controlSum == int.parse(pesel.substring(10, 11))){
      setState(() {
        isValid = "Valid";
      });
    }
    if(int.parse(pesel.substring(9, 10))%2 == 0){
      setState(() {
        sex = "woman";
      });
    }
    else{
      setState(() {
        sex = "man";
      });
    }
    setState(() {
      birthDay = "$year - $month - $day";
    });

  }

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
              decoration: InputDecoration(
                hintText: 'pesel'
              ),
              controller: myController,
            ),
            Row(
              children: [
                Text(
                  'Birth date:',
                ),
                Text(
                  '$birthDay'
                )
              ]
            ),
            Row(
                children: [
                  Text(
                      '$isValid'
                  )
                ]
            ),
            Row(
                children: [
                  Text(
                    'Sex:',
                  ),
                  Text(
                      '$sex'
                  )
                ]
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: validatePesel,
        tooltip: 'Increment',
        child: Icon(Icons.calculate),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
