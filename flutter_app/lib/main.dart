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
  var maxIndex = 1000;
  var currIndex = 1;
  // https://picsum.photos/id/1084/160/160
  var url = 'https://picsum.photos/160/160';
  var rng = new Random();
  var imagesPerRow = 5;
  var prevTime = -1;
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _ids = List<List <int>>();

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(2),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Container();
          var now = new DateTime.now().millisecondsSinceEpoch;
          if (prevTime > 0) {
            var result = 1000 / (now - prevTime);
            if (!result.isNaN && !result.isInfinite) {
              print(result.floor().toString());
            }
          }
          prevTime = now;
          //print(rng.nextInt(1000).toString());
          if (i ~/ 2 >= _ids.length) {
            for (var i = 0; i < 100; i++) {
              var temp2 = List<int>();
              for (var i = 0; i < imagesPerRow; i++) {
                temp2.add(currIndex);
                if (currIndex == 1000) {
                  currIndex = 1;
                } else {
                  currIndex++;
                }

              }
              _ids.addAll([temp2]);
            }
          }
          return _buildRow(_ids[i ~/ 2]);
        });
    }

  Widget _buildRow(row) {
    // debugPrint(row.toString());
    final mapped = row.map<Widget>((id) => Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 2, top: 1, right: 2, bottom: 1),
        child: Image.network(
          "https://mobvita.cs.helsinki.fi/id/" + id.toString() + "/80",
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
        ),
      ),
    )).toList();
    return Row(
      children: mapped,
    );
  }

  Widget _buildRow4(row) {
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