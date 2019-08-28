import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:AndyBoard/RouteArguments.dart';
import 'package:AndyBoard/Data.dart';

class HomeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);

    // path.quadraticBezierTo(size.width/2, size.height / (1.75/2), size.width, size.height / 1.75);
    // path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height / 1.75);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 250,
              child: Stack(
                children: <Widget>[
                  ClipPath(
                    child: Container(
                      color: Colors.red,
                    ),
                    clipper: HomeClipper(),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Sound Boards',
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: FlatButton(
                      color: Colors.black54,
                      child: Text('View More'),
                      onPressed: () => print('JERE'),
                    ),
                  )
                ],
              ),
            ),
            FutureBuilder<int>(
              future: Future.delayed(Duration(seconds: 5), () => 5),
              initialData: 0,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  int val = snapshot.data;
                  return Column(
                    children: List.generate(val, (int index) {
                      return FeaturedSection();
                    }),
                  );
                } else {
                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FeaturedSection extends StatelessWidget {
  const FeaturedSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Text(
                'Nameless Boards',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Container(
          height: 175,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(20, (index) {
              index = index % featuredBoards.length;
              return FeaturedTile(
                soundBoardTitle: featuredBoards[index]['boardTitle'],
                id: featuredBoards[index]['id'],
                thumbnail: featuredBoards[index]['thumbnail'],
              );
            }),
          ),
        ),
      ],
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
