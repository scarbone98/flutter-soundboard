import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:AndyBoard/models/AndySound.dart';
import '../widgets/audio_tile.dart';
import 'package:AndyBoard/Data.dart';

Map<String, List<AndySound>> data = {
  "andy": andyList,
  "leo": leoList,
  "origin": andyList
};

Map<String, String> thumbNails = {
  "andy": "Andy.png",
  "leo": "Christmas.png",
  "origin": "Andy.png"
};


class SoundBoardDetails extends StatefulWidget {
  final String id;
  final String pageTitle;

  SoundBoardDetails({Key key, @required this.pageTitle, @required this.id}) : super(key: key);

  _SoundBoardDetails createState() => _SoundBoardDetails();
}

class _SoundBoardDetails extends State<SoundBoardDetails> {
  AudioCache audioCache = AudioCache();
  AudioPlayer currentPlayer;
  Duration currentPos;
  Duration totalDuration;

  @override
  void initState() {
    data[widget.id].sort((andy1, andy2) => andy1.labelName.compareTo(andy2.labelName));
    super.initState();
  }

  void setAudioPlayer(AudioPlayer audioPlayer) {
    setState(() {
      currentPlayer = audioPlayer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
                expandedHeight: 175,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(widget.pageTitle),
                  background:
                      Image.asset('assets/${thumbNails[widget.id]}', fit: BoxFit.fitWidth),
                ),
              ),
              SliverPadding(
                  padding: EdgeInsets.all(4.0),
                  sliver: SliverGrid.count(
                    crossAxisCount: 2,
                    children: List.generate(data[widget.id].length, (index) {
                      AndySound currentSound = data[widget.id][index];
                      return AudioTile(
                        andySound: currentSound,
                        audioCache: audioCache,
                        setCurrentPlayer: setAudioPlayer,
                        currentPlayer: currentPlayer,
                      );
                    }),
                  ))
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.arrow_right),
        //   onPressed: () => Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => Surprise())),
        //   backgroundColor: Colors.blueAccent,
        // ),
      ),
    );
  }
}