import 'package:cinematcher/screens/recommendations.dart';
import 'package:cinematcher/screens/watchlist.dart';
import 'package:flutter/material.dart';
import 'package:cinematcher/main.dart';
import 'package:cinematcher/screens/genre_picker.dart';

import 'model/movie.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch(settings.name){
      case '/genre':
        return MaterialPageRoute(builder: (_) => GenrePicker());
      case '/rec':
        if(args is List<Movie>){
          return MaterialPageRoute(builder: (_) => Recommendations(movieList: args));
        }
        return MaterialPageRoute(builder: (_){
          return Scaffold(appBar: AppBar(
            title: const Text('Error!!!'),
          ),
            body: const Text('Error loading question'),
          );
        });
      case '/list':
        return MaterialPageRoute(builder: (_)=> const Watchlist());
      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(appBar: AppBar(
            title: const Text('Error!!!'),
          ),
            body: const Text('Error loading question'),
          );
        });
    }
  }

  Route _errorRoute() {
    return MaterialPageRoute(builder: (_){
      return Scaffold(appBar: AppBar(
        title: Text('Error!!!'),
      ),
        body: Text('Error loading question'),
      );
    });
  }
}