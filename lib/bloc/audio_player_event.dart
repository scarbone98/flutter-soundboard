import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AudioPlayerEvent extends Equatable {
  AudioPlayerEvent([List props = const <dynamic>[]]) : super(props);
}

class PlayerStop extends AudioPlayerEvent {
  AudioPlayer audioPlayer;
  PlayerStop(this.audioPlayer) : super([audioPlayer]);
}

class PlayerPlay extends AudioPlayerEvent {
  AudioCache audioPlayer;
  String tileId;
  PlayerPlay(this.audioPlayer, this.tileId) : super([audioPlayer, tileId]);
}