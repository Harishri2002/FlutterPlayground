import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/Favourite.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: AutofillHints.familyName,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favor = <WordPair>[];

  void toggleFav() {
    if (favor.contains(current)) {
      favor.remove(current);
    } else {
      favor.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget page;
    switch(selectedIndex){
      case 0: page = GeneratorPage();
              break;
      case 1: page = Favourite();
              break;
      default: throw new UnimplementedError("Not Yet Implemented");
    }
    return LayoutBuilder(
      builder: (context,constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  backgroundColor: Colors.white,
                  useIndicator: true,
                  extended: constraints.maxWidth >= 600,
                  minWidth: 100,
                  elevation: 40,
                  destinations: [
                    NavigationRailDestination(
                        icon: Icon(Icons.home), label: Text("Home")),
                    NavigationRailDestination(
                        icon: Icon(Icons.favorite), label: Text("Favorite"))
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                    print("Selected value is:$value");
                  },
                ),
              ),
              Expanded(
                  child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ))
            ],
          ),
        );
      }
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({super.key, required this.pair});

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    // TODO: implement build
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}

class GeneratorPage extends StatelessWidget {
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favor.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('A random awesome idea:', style: TextStyle(fontSize: 20)),
            BigCard(pair: pair),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    appState.toggleFav();
                  },
                  icon: Icon(icon),
                  label: Text("Like"),
                ),
                ElevatedButton(
                    onPressed: () {
                      appState.getNext();
                    },
                    child: Text("Randomize")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
