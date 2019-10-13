import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

import 'entity.dart';

class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>(); // Add this line.
  final TextStyle _biggerFont = const TextStyle(fontSize: 32);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add from here...
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          // Add 3 lines from here...
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),

      body: _buildSuggestions(context),
    ); // ... to here.
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            // Add 6 lines from here...
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          ); // ... to here.
        },
      ),
    );
  }

  Widget _buildSuggestions(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('words').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return ListView(
          padding: EdgeInsets.all(16),
          children: snapshot.data.documents
              .map((data) => _buildRow(context, data))
              .toList(),
        );
      },
    );
  }

  Widget _buildRow(BuildContext context, DocumentSnapshot data) {
    final pair = Entity.fromSnapshot(data);
    return ListTile(
        title: Text(
          pair.wordpair,
        ),
        trailing: Icon(
          pair.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: pair.isFavorite ? Colors.red : null,
        ),
        onTap: () =>
            pair.reference.updateData({'isFavorite': !pair.isFavorite}));
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}
