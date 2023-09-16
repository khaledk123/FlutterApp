import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String>{ @override
  List<Widget>? buildActions(BuildContext context) {
    //to be added for the search bar
   return[
  IconButton(
    onPressed: (){}, icon:
    Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: (){}, icon: 
      Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    //the search results
    return Text('body search');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    //the end result
   return Text('body search');
  }
}
 
 