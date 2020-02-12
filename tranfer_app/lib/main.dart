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
      home: RandomWords(),
    );
  }
}   

class RandomWordsState extends State<RandomWords> 
{
  //DEVNOTE: Leading underscore denotes a private variable
  final List<WordPair> _suggestions = <WordPair>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
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
    return ListTile
    (
      title: Text
      (
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}

class RandomWords extends StatefulWidget
{
  @override
  RandomWordsState createState() => RandomWordsState();
}