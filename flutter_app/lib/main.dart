import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        body: Center(
          child: RandomWords(),
        ),
      ),
    );
  }
}

class RandomWordsState extends State<RandomWords> {
  var url = 'https://picsum.photos/160/160';
  var rng = new Random();
  var imagesPerRow = 5;
  final _suggestions = <WordPair>[];
  final _rows = List<List <Widget>>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(5.0),
        itemBuilder: /*1*/ (context, i) {
          //if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            for (var i = 0; i < 10; i++) {
              var temp = List<Widget>();
              for (var i = 0; i < imagesPerRow; i++) {
                temp.add(new Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 2, top: 1, right: 2, bottom: 1),
                      child: Image.network(
                    url + "?rand=" + rng.nextInt(999999).toString(),
                    height: 70,
                    width: 160,
                    loadingBuilder: (BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null ?
                          loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },
                  )),
                ));
              }
              _rows.addAll([temp]);
            }
          }
          return _buildRow(_rows[index]);
        });
    }

  Widget _buildRow(row) {
    // debugPrint(row.toString());
    return Row(
      children: row,
    );
  }

  Widget _buildRow3(WordPair pair) {
    return Row(
      children: <Widget>[
        Expanded(
          child:Image.network(
            url + "?rand=" + rng.nextInt(999999).toString(),
            height: 160,
            width: 160,
          )
        ),
        Expanded(
          child: Image.network(
            url + "?rand=" + rng.nextInt(999999).toString(),
            height: 160,
            width: 160,
          )
        ),
        Expanded(
          child: Image.network(
            url + "?rand=" + rng.nextInt(999999).toString(),
            height: 160,
            width: 160,
            loadingBuilder: (BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null ?
                  loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                      : null,
                  ),
                );
              },
          )
        ),
        Expanded(
          child: Image.network(
            url + "?rand=" + rng.nextInt(999999).toString(),
            height: 160,
            width: 160,
          )
        ),
        Expanded(
          child: Image.network(
            url + "?rand=" + rng.nextInt(999999).toString(),
            height: 160,
            width: 160,
          )
        ),
      ],
    );
  }

  Widget _buildRow2(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,

      ),
    );
  }

  @override
  RandomWordsState createState() => RandomWordsState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Virtualized listerino'),
      ),
      body: _buildSuggestions(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}