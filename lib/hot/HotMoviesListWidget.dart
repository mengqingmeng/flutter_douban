import 'package:flutter/material.dart';

import 'HotMovieData.dart';
import 'HotMovieItemWidget.dart';

class HotMoviesListWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HotMoviesListState();
  }
}

class HotMoviesListState extends State<HotMoviesListWidget>{
  List<HotMovieData> hotMovies = new List<HotMovieData>();
  
  @override
  void initState() {
      super.initState();
      var data = HotMovieData('反贪风暴4', 6.3, '林德禄', '古天乐/郑嘉颖/林峯', 29013,
        'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2551353482.webp');
    setState(() {
      hotMovies.add(data);
      hotMovies.add(data);
      hotMovies.add(data);
      hotMovies.add(data);
      hotMovies.add(data);
      hotMovies.add(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
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
      );
  }

}