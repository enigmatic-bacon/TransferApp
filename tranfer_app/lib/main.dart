import 'dart:math';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      title: 'Startup Name Generator',
      theme: ThemeData
      (
        primaryColor: Colors.white,
      ),
      home: RandomWords(),
    );
  }
}   

class RandomWordsState extends State<RandomWords> 
{
  //DEVNOTE: Leading underscore denotes a private variable
  final List<WordPair> _suggestions = <WordPair>[];
  //DEVNOTE Set doesn't allow for duplicates
  final Set<WordPair> _saved = Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text('Startup Name Generator'),
        actions: <Widget>
        [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved()
  {
    Navigator.of(context).push
    (
      MaterialPageRoute<void>
      (
        builder: (BuildContext context)
        {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair)
            {
              return ListTile
              (
                title: Text
                (
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles
          (
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold
          (
            appBar: AppBar
            (
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget _buildSuggestions()
  {
    return ListView.builder
    (
      padding: const EdgeInsets.all(16),
      // The itemBuilder callback is called once per suggested 
      // word pairing, and places each suggestion into a ListTile
      // row. For even rows, the function adds a ListTile row for
      // the word pairing. For odd rows, the function adds a 
      // Divider widget to visually separate the entries. Note that
      // the divider may be difficult to see on smaller devices.
      itemBuilder: (BuildContext _context, int i)
      {
        if(i.isOdd)
        {
          return Divider();
        }
        //~/ notation means integer division like in C++
        final int index = i ~/ 2;
        //If we've reached end of list, throw in another 10 items
        if(index >= _suggestions.length)
        {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair)
  {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile
    (
      title: Text
      (
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon
      (
        //TODO Figure out how to have conditionals in here
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () 
      {
        setState(() 
        {
          if(alreadySaved)
          {
            _saved.remove(pair);
          }
          else
          {
            _saved.add(pair);
          }
        });
      },
    );
  }
}

class RandomWords extends StatefulWidget
{
  @override
  RandomWordsState createState() => RandomWordsState();
}