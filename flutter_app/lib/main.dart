import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'dart:async';

var rows = 0;

void main() {
  const oneSec = const Duration(seconds:1);
  new Timer.periodic(oneSec, (Timer t) {
    //print('hi!' + rows.toString());
    rows = 0;
  });
  runApp(MyApp());
}

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

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class RandomWordsState extends State<RandomWords> {
  var maxIndex = 1000;
  var currIndex = 0;
  // https://picsum.photos/id/1084/160/160
  var url = 'https://picsum.photos/160/160';
  var rng = new Random();
  var imagesPerRow = 4;
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _ids = List<List <int>>();

  Widget _buildSuggestions() {
    return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 2, bottom: 2, left: 2, right: 2),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Container(height: 0, width: 0);
          rows++;
          //print(rng.nextInt(1000).toString());
          if (i ~/ 2 >= _ids.length) {
            for (var i = 0; i < 25; i++) {
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
          "https://mobvita.cs.helsinki.fi/1/id/" + id.toString() + "/90",
          height: 86,
          width: 90,
          loadingBuilder: (BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              decoration: BoxDecoration(border: Border.all(), color: Colors.white70),
              width: 86,
              height: 86,
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
        title: Text('Virtualized listerino', style: TextStyle(color: HexColor('#000000')),),
        backgroundColor: HexColor('#fafafa')
      ),
      body: _buildSuggestions(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}