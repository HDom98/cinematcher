import 'package:cinematcher/route_generator.dart';
import 'package:cinematcher/screens/genre_picker.dart';
import 'package:cinematcher/screens/watchlist.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Cinematcher());
}

class Cinematcher extends StatelessWidget {
  const Cinematcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinematcher',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.red,
        canvasColor: Colors.red
      ),
      home: const DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomNavigationBar: TabBar(
            tabs: [Tab(
              text: "Recommend a movie",
              icon: Icon(Icons.movie),
            ),
              Tab(
                text: "Watchlist",
                icon: Icon(Icons.list),
              ),],
          ),
          body: TabBarView(
            children: [
              GenrePicker(),
              Watchlist()
            ],
          ),
        ),
      ),
    );
  }
}
