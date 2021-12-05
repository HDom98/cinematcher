import 'package:cinematcher/model/genre.dart';
import 'package:cinematcher/model/movie.dart';

class Parser{
  List<Genre> genreListParser(json){
    List<Genre> genreList = [];
    for(int i = 0; i < json['genres'].length; i++){
      var genreJson = json['genres'][i];
      genreList.add(Genre(name: genreJson['name'], id: genreJson['id']));
    }
    return genreList;
  }

  List<Movie> movieToListParser(json, Genre genre){
    List<Movie> movieList = [];
    for(int i = 0; i < json['results'].length; i++){
      if(json['results'][i]['adult'] == false){
        var movieJson = json['results'][i];
        movieList.add(Movie(title: movieJson['title'],
            poster: movieJson['poster_path'],
            plot: movieJson['overview'],
            genreID: genre.id,
            id: movieJson['id']));
      }
    }
    return movieList;
  }

}