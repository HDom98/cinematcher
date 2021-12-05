import 'package:cinematcher/model/movie.dart';
import 'package:cinematcher/model/genre.dart';
import 'package:cinematcher/web_client.dart';
import 'package:cinematcher/movie_db_worker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Recommendations extends StatefulWidget{
  final List<Movie> movieList;
  const Recommendations({Key? key, required this.movieList}) : super(key: key);

  @override
  State<StatefulWidget> createState()=>
      MovieRec(movieList: movieList, index: 0);
}

class MovieRec extends State<Recommendations>{
  List<Movie> movieList;
  int index;
  MovieRec({required this.movieList, required this.index});
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: Text(movieList[index].title),
        centerTitle: true,),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget> [
            Container(
              height: 400,
              child: GestureDetector(
              onTap: (){
                //  TODO details screen (phase 4)
              },
                onVerticalDragEnd: (details){
                if(details.primaryVelocity! > 150){
                  WatchlistDBWorker().create(movieList[index]);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),content: Text('Movie added to watchlist.'),)
                  );
                }
                  print(details);
                },
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity! > 250.0) {
                    print('right swipe');
                    if(index++ <= movieList.length) {
                      setState(() {
                        index++;
                      });
                    }else{
                      setState(() {
                        // TODO go to next page
                        index  = 0;
                      });
                    }
                  }
                  else if (details.primaryVelocity! < -250.0) {
                    print('left swipe');
                    if(index <= movieList.length) {
                      setState(() {
                        index++;
                      });
                    }else {
                      setState(() {
                        // TODO go to next page
                        index = 0;
                      });
                    }
                  }
                },),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage('https://image.tmdb.org/t/p/original/${movieList[index].poster}')),
              ),),
            Text(movieList[index].plot, style: const TextStyle(fontSize: 18, color: Colors.white),),
          ],),
    );

  }
}