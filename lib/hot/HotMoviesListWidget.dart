import 'dart:convert';
import 'package:flutter/material.dart';
import 'data/HotMovieData.dart';
import 'HotMovieItemWidget.dart';
import 'package:http/http.dart' as http;

class HotMoviesListWidget extends StatefulWidget{
  String curCity;
  @override
  State<StatefulWidget> createState() {
    return HotMoviesListState();
  }

  HotMoviesListWidget(String city){
    curCity = city;
  }
}

class HotMoviesListState extends State<HotMoviesListWidget> with AutomaticKeepAliveClientMixin{
  List<HotMovieData> hotMovies  = new List<HotMovieData>();

  void _getData() async{
    List<HotMovieData> serverDataList  = new List<HotMovieData>();
    var response = await http.get(        'https://api.douban.com/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b&city='+widget.curCity+'&start=0&count=10&client=&udid=');
    if(response.statusCode == 200){
      var responseJson = json.decode(response.body);
      for(var data in responseJson['subjects']){
        HotMovieData hotMovieData = HotMovieData.fromJson(data);
        serverDataList.add(hotMovieData);
      }

      setState(() {
       hotMovies = serverDataList;
      });
    }
  }
  
  @override
  void initState() {
      super.initState();
      _getData();
  }

  @override
  Widget build(BuildContext context) {

    if(hotMovies == null || hotMovies.isEmpty){
      return Center(child: CircularProgressIndicator());
    }else{
      return MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView.separated(
          itemCount: hotMovies.length,
          itemBuilder: (context, index) {
            return HotMovieItemWidget(hotMovies[index]);
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 1,
              color: Colors.black26,
            );
          },
        )
      );
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}