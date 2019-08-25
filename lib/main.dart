import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'models/AndySound.dart';
import 'widgets/audio_tile.dart';

void main() => runApp(MyApp());

List<AndySound> list = [
  AndySound(labelName: 'Unlimited Power', soundName: 'Unlimited_Power.wav'),
  AndySound(labelName: 'Thx for the sub', soundName: 'Thx_for_the_sub.wav'),
  AndySound(labelName: 'Old Man', soundName: 'Old_Man.wav'),
  AndySound(labelName: 'Nadie hace na', soundName: 'Nadie_hace_na.wav'),
  AndySound(labelName: 'it\'s huge', soundName: 'its_huge.wav'),
  AndySound(labelName: 'he\'s just weird', soundName: 'hes_just_weird_dud.wav'),
  AndySound(labelName: 'AAAAAAA', soundName: 'AAAAAA.wav'),
  AndySound(
      labelName: 'Rip Mic',
      soundName: 'Andeefuckedhismicrophoneinsideout_1.wav'),
  AndySound(labelName: 'Wohaooo', soundName: 'wohaoooo.wav'),
  AndySound(labelName: 'THOTASS', soundName: 'THOTASS.wav'),
  AndySound(labelName: 'Oigin Fighting ;(', soundName: 'oigin_fighting.wav'),
  AndySound(labelName: 'Laughing', soundName: 'laughing.wav'),
  AndySound(
      labelName: 'I\'m actually shkd', soundName: 'ImActuallyShocked.wav'),
  AndySound(labelName: 'Had to do it toem', soundName: 'had_to_do_it_toem.wav'),
  AndySound(labelName: 'BANG', soundName: 'BANG.wav'),
  AndySound(
      labelName: 'DOUBLE DIGITS', soundName: 'YOU_BOTH_HAVE_DOUBLE_DIGITS.wav'),
  AndySound(labelName: 'Stuffed', soundName: 'stuffed_like_thanksgiving.wav'),
  AndySound(labelName: 'Staunton', soundName: 'Staunton.wav'),
  AndySound(labelName: 'SoT-1', soundName: 'SoT.wav'),
  AndySound(labelName: 'SoT-2', soundName: 'SoT_2.wav'),
  AndySound(labelName: 'LOAF', soundName: 'LOAFFF.wav'),
  AndySound(
      labelName: 'Shadows room',
      soundName: 'I_still_see_the_shadows_in_my_room.wav'),
  AndySound(labelName: 'Full COMMS', soundName: 'Full_Comms.wav'),
  AndySound(labelName: 'Ale x Andy', soundName: 'pulled_move.wav'),
  AndySound(labelName: 'Aroused', soundName: 'AROUSED.wav'),
  AndySound(labelName: 'Beatboxer Loop', soundName: 'BEATBOXER_LOOP.wav'),
  AndySound(labelName: 'F*** OFF', soundName: 'FUCKOFF.wav'),
  AndySound(labelName: 'I can\'t hear you', soundName: 'I_CANT_HEAR_YOU.wav'),
  AndySound(labelName: 'LET ME IN', soundName: 'LET_ME_IN.wav'),
  AndySound(labelName: 'Mac N Cheese', soundName: 'MAC_N_CHEESE.wav'),
  AndySound(labelName: 'NO BRO', soundName: 'NO_BRO.wav'),
  AndySound(labelName: 'OOOOOOOOOOOOOO', soundName: 'OOOOOOOOOOOOOO.wav'),
];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AudioCache audioCache = AudioCache();
  AudioPlayer currentPlayer;
  Duration currentPos;
  Duration totalDuration;

  @override
  void initState() {
    list.sort((andy1, andy2) => andy1.labelName.compareTo(andy2.labelName));
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
                  title: Text('Andy\'s Noises'),
                  background:
                      Image.asset('assets/Andy.png', fit: BoxFit.fitWidth),
                ),
              ),
              SliverPadding(
                  padding: EdgeInsets.all(4.0),
                  sliver: SliverGrid.count(
                    crossAxisCount: 2,
                    children: List.generate(list.length, (index) {
                      AndySound currentSound = list[index];
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
