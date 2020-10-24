import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pyramid/data/data.dart';

class Pyramid extends StatefulWidget {
  Pyramid({Key key}) : super(key: key);

  @override
  _PyramidState createState() => _PyramidState();
}

class _PyramidState extends State<Pyramid> {
  int currentIndex = 0;
  String currentText = '';
  List randomWords = [];
  Random random = Random();

  checkAnswer() {
    if (currentText == randomWords[currentIndex]['word']) {
      currentIndex++;
      currentText = '';
      if (currentIndex >= randomWords.length) {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Tebrikler!',
                      style: Theme.of(context).textTheme.subtitle1),
                  content: Text('Kazandınız',
                      style: Theme.of(context).textTheme.headline4),
                  actions: <Widget>[
                    RaisedButton(
                      child: Text('Yeniden Oyna'),
                      onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Pyramid())),
                    )
                  ],
                ));
      }
    } else {
      print('NO');
    }
  }

  showClues() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('İpuçları',
                  style: Theme.of(context).textTheme.subtitle1),
              content: Container(
                width: 300,
                height: 200,
                child: ListView.builder(
                  itemCount: randomWords.length,
                  itemBuilder: (context, index) =>
                      Text('$index- ${randomWords[index]['clue']}'),
                ),
              ),
              actions: <Widget>[
                RaisedButton(
                  child: Text('Geri Dön'),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ));
  }

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < words.length; i++) {
      randomWords.add(words[i][random.nextInt(words[i].length)]);
    }
    print(randomWords);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            tooltip: 'İpuçlarını göster',
            onPressed: showClues,
            icon: Icon(Icons.info),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (var i = 0; i < randomWords.length; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (var y = 0; y < randomWords[i]['word'].length; y++)
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      height: 50,
                      width: 50,
                      child: TextField(
                        maxLength: 1,
                        onChanged: (val) {
                          setState(() => currentText += val);
                          checkAnswer();
                          FocusScope.of(context).nextFocus();
                        },
                        decoration: InputDecoration(filled: true),
                      ),
                    )
                ],
              )
          ],
        ),
      ),
    );
  }
}
