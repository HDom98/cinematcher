import 'package:sqflite/sqflite.dart';
import 'package:cinematcher/model/movie.dart';

class WatchlistDBWorker{
  static const String DB_NAME = 'watchlist.db';
  static const String TBL_NAME = 'watchlist';
  static const String KEY_ID = 'id';
  static const String KEY_TITLE = 'title';
  static const String KEY_PLOT = 'plot';
  static const String KEY_GENRE_ID = 'genreID';
  static const String KEY_POSTER = 'poster';

  late Database _db;

  Future<Database> get database async => _db = await _init();

  Future<Database> _init()async {
    return await openDatabase(TBL_NAME,
    version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version)async {
      await db.execute(
          "CREATE TABLE IF NOT EXISTS $TBL_NAME ("
              "$KEY_ID INTEGER PRIMARY KEY,"
              "$KEY_TITLE TEXT,"
              "$KEY_PLOT TEXT,"
              "$KEY_GENRE_ID INTEGER,"
              "$KEY_POSTER TEXT"
              ")"
      );}
    );
  }

  Future<int> create(Movie movie)async {
    Database db = await database;
    int id = await db.rawInsert(
      "INSERT INTO $TBL_NAME ($KEY_TITLE, $KEY_PLOT, $KEY_GENRE_ID, $KEY_POSTER) "
          "VALUES(?, ?, ?, ?)",
      [movie.title, movie.plot, movie.genreID, movie.poster]
    );
    return id;
  }

  Future<void> delete(int id)async {
    Database db = await database;
    await db.delete(TBL_NAME ,where: "$KEY_ID= ?", whereArgs: [id]);
  }

  Future<Movie> get(int id)async {
    Database db = await database;
    var values = await db.query(TBL_NAME, where:"$KEY_ID =?", whereArgs: [id]);
    return _movieFromMap(values.first);
  }

  Future<List<Movie>> getAll()async {
    Database db = await database;
    var values = await db.query(TBL_NAME);
    return values.isNotEmpty ? values.map((m) => _movieFromMap(m)).toList() : [];
  }

  Movie _movieFromMap(Map<String, dynamic> map) {
    return Movie(title: map[KEY_TITLE], poster: map[KEY_POSTER],
        plot: map[KEY_PLOT], genreID: map[KEY_GENRE_ID], id: map[KEY_ID]);
  }

  Map<String, dynamic> _movieToMap(Movie movie){
    return <String, dynamic>{}
        ..[KEY_TITLE] = movie.title
        ..[KEY_PLOT] = movie.plot
        ..[KEY_POSTER] = movie.poster
        ..[KEY_GENRE_ID] = movie.genreID
        ..[KEY_ID] = movie.id;
  }

  Future<void> update(Movie movie)async {
    Database db = await database;
    await db.update(TBL_NAME, _movieToMap(movie),
    where: "$KEY_ID = ?", whereArgs: [movie.id]);
  }
}