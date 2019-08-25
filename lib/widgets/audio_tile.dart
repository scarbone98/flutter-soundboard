import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:andy_board/models/AndySound.dart';
import 'package:random_color/random_color.dart';

class AudioTile extends StatefulWidget {
  final AndySound andySound;
  final AudioCache audioCache;
  final AudioPlayer currentPlayer;
  final Function setCurrentPlayer;

  const AudioTile(
      {Key key,
      @required this.andySound,
      @required this.currentPlayer,
      @required this.audioCache,
      @required this.setCurrentPlayer})
      : super(key: key);

  _AudioTileState createState() => _AudioTileState();
}

class _AudioTileState extends State<AudioTile>
    with AutomaticKeepAliveClientMixin {
  Duration currentPos;
  Duration totalDuration;
  Color tileColor;
  @override
  void initState() {
    super.initState();
    RandomColor randomColor = RandomColor();
    setState(() {
      tileColor = randomColor.randomColor(colorHue: ColorHue.red);
    });
  }

  Widget buildProgressBar() {
    if (currentPos != null && totalDuration != null) {
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: LinearProgressIndicator(
            value: currentPos.inMicroseconds / totalDuration.inMicroseconds,
            backgroundColor: Colors.black,
          ),
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(2, 1, 2, 1),
        child: FlatButton(
          color: tileColor,
          onPressed: () async {
            if (widget.currentPlayer != null) {
              widget.currentPlayer.stop();
            }
            AudioPlayer player =
                await widget.audioCache.play(widget.andySound.soundName);

            player.onDurationChanged.listen((Duration p) {
              setState(() {
                totalDuration = p;
              });
            });

            player.onAudioPositionChanged.listen((Duration p) {
              setState(() {
                currentPos = p;
              });
            });

            player.onPlayerStateChanged.listen((AudioPlayerState s) {
              if (s == AudioPlayerState.COMPLETED ||
                  s == AudioPlayerState.STOPPED) {
                setState(() {
                  currentPos = null;
                  totalDuration = null;
                });
              }
            });
            widget.setCurrentPlayer(player);
          },
          child: Container(
            child: Stack(children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  widget.andySound.labelName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: LinearProgressIndicator(
                      value: currentPos != null && totalDuration != null
                          ? currentPos.inMicroseconds /
                              totalDuration.inMicroseconds
                          : 0,
                      backgroundColor: Colors.black,
                    ),
                  ),
                ),
                visible: currentPos != null && totalDuration != null,
              )
            ]),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
