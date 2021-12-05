import 'package:cinematcher/movie_db_worker.dart';
import 'package:cinematcher/model/movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';

class Watchlist extends StatelessWidget{
  const Watchlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Movie> watchlist;
    return Scaffold(
      appBar: AppBar(title: const Text("Watchlist"), centerTitle: true,),
      body: FutureBuilder(future: WatchlistDBWorker().getAll(),
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot){
        if(snapshot.hasData){
          watchlist = snapshot.data!;
          return ListView.builder(
              itemCount: watchlist.length,
              itemBuilder: (BuildContext context, int index){
                return Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child:_buildListItem(context, watchlist[index]));
              });
        }else{
          return const CircularProgressIndicator();
        }
        },),
    );
  }

  Widget _buildListItem(BuildContext context, Movie movie){
    return  Slidable(
      child: ListTile(
        leading: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 44,
              minHeight: 44,
              maxWidth: 64,
              maxHeight: 64,
            ),
            child: Image.network('https://image.tmdb.org/t/p/original/${movie.poster}'),
        ),
        title: Text(movie.title),
        subtitle: Text(movie.plot),
        trailing: const Icon(Icons.more_vert),
      ),
      startActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              label: "Seen",
              backgroundColor: Colors.green,
              icon: Icons.check,
              onPressed: (BuildContext context) {
                WatchlistDBWorker().delete(movie.id);
                },
            )]
      ),
    );
  }
}