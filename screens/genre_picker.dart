import 'package:cinematcher/model/movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cinematcher/model/genre.dart';
import 'package:cinematcher/web_client.dart';
import 'package:cinematcher/utils.dart';

class GenrePicker extends StatelessWidget{
  const GenrePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Genre> genreList;
    return Scaffold(
      appBar: AppBar(title: const Text("Cinematcher")),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,),
          itemCount: 19,
          physics: const ScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return FutureBuilder(future: WebClient().getGenres(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Genre>> snapshot){
                  if(snapshot.hasData){
                    genreList = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: buildGenreTile(context, index, genreList),);
                  }else{
                    return const CircularProgressIndicator();
                  }
                });
          }),
    );
  }

  Widget buildGenreTile(BuildContext context, int index, List<Genre>genreList){
    return Container(
      alignment: Alignment.center,
      child: GestureDetector(
          child: Text(genreList[index].name,
          textAlign: TextAlign.center,),
          onTap: ()async {
            print("Clicked ${genreList[index].name}");
            // TODO change movieList to await the rec_randomizer
            List<Movie> movieList= await WebClient().getPopular(genreList[index], 1);
            Navigator.pushNamed(context, '/rec', arguments: movieList);
          },
        ),
      decoration: BoxDecoration(
        color: randColor(),
      ),
        );
  }
}