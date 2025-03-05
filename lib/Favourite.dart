import 'package:flutter/material.dart';
import 'package:namer_app/main.dart';
import 'package:provider/provider.dart';

class Favourite extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
    return Consumer<MyAppState>(builder: (context,appState,child){
      var appState = context.watch<MyAppState>();

      if(appState.favor.isEmpty){
        return Center(
          child: Text("No Favourites Found!!!"),
        );
      }

      return ListView(
        children: [
          Padding(padding: EdgeInsets.all(8.0),
           child: Text("You have ${appState.favor.length} Favourites"),
          ),
          for(var pair in appState.favor)
           ListTile(
             leading: Icon(Icons.favorite),
             title:Text(pair.asLowerCase),
           )
        ],
      );
    });
  }
  
  
}