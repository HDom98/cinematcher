import 'dart:convert';
import 'package:cinematcher/model/genre.dart';
import 'package:cinematcher/model/movie.dart';
import 'package:http/http.dart'as http;
import 'package:cinematcher/parser.dart';

class WebClient{
  final String _apiKey = ' ';
  final String _apiAuthority = 'api.themoviedb.org';

  /// Returns a list of [Genre]s and their [id]s to be used in later requests
  Future<List<Genre>> getGenres() async {
    String _path = '/3/genre/movie/list';
    var _url = Uri.http(_apiAuthority, _path,{'api_key': _apiKey, 'language': 'en-US'});
    var _response = await http.get(_url);
    var statusCode = _response.statusCode;
    if (statusCode < 200 || statusCode > 400) {
      print('Server connection failed $statusCode');
      return [];
    }
    var _body = json.decode(_response.body);
    List<Genre> genreList = Parser().genreListParser(_body);
    return genreList;
  }

  /// Returns a list of popular [Movie]s based on the selected [Genre]
  Future<List<Movie>> getPopular(Genre genre, int pageNum)async {
    String _path = '/3/movie/popular';
    var _url = Uri.http(_apiAuthority, _path,
        {'api_key': _apiKey, 'language': 'en-US',
          'with_genres': genre.id.toString(), 'page': pageNum.toString()});
    var _response = await http.get(_url);
    var statusCode = _response.statusCode;
    if (statusCode < 200 || statusCode > 400) {
      print('Server connection failed $statusCode');
      return [];
    }
    var _body = json.decode(_response.body);
    List<Movie> popularMovies = Parser().movieToListParser(_body, genre);
    return popularMovies;
  }

  /// returns a [Movie] based on the [movieId]
  Future<Movie> getMovieDetails(int movieId)async {
    String _path = '3/movie/$movieId';
    var _url = Uri.https(_apiAuthority, _path,
        {'api_key': _apiKey, 'language': 'en-US'});
    var _response = await http.get(_url);
    var statusCode = _response.statusCode;
    if (statusCode < 200 || statusCode > 400) {
      print('Server connection failed $statusCode');
      return Movie(title: '', poster: '', plot: '',
          genreID: 0, id: 0 );
    }
    var _body = json.decode(_response.body);
    return Movie(title: _body['title'],
        poster: _body['poster_path'],
        plot: _body['overview'],
        genreID: _body['genres'][0]['id'],
        id: _body['id']);
  }

  /*Future<List<Movie>> getRec(int movieId)async {
  TODO
  }*/
}
