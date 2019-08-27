import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:AndyBoard/RouteArguments.dart';
import 'package:AndyBoard/Data.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Nameless Boards',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Container(
              height: 175,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(featuredBoards.length, (index) {
                  return FeaturedTile(
                    soundBoardTitle: featuredBoards[index]['boardTitle'],
                    id: featuredBoards[index]['id'],
                    thumbnail: featuredBoards[index]['thumbnail'],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeaturedTile extends StatelessWidget {
  final String soundBoardTitle;
  final String id;
  final String thumbnail;
  const FeaturedTile({Key key, this.soundBoardTitle, this.id, this.thumbnail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/soundboardDetails',
          arguments: SoundBoardDetailsArguments(
              id: id, soundBoardTitle: soundBoardTitle),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: 150,
          height: 175,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.asset(
                'assets/$thumbnail',
                fit: BoxFit.fitHeight,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    soundBoardTitle,
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
