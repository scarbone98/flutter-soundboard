import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AudioPlayerState extends Equatable {
  AudioPlayerState([List props = const <dynamic>[]]) : super(props);
}

class InitialAudioPlayerState extends AudioPlayerState {
  AudioCache audioCache = AudioCache();
}

class Stopped extends AudioPlayerState {
  AudioCache audioCache;
  Stopped(this.audioCache) : super([audioCache]);
}

class Playing extends AudioPlayerState {
  String tileId;
  AudioPlayer audioPlayer;
  Playing(this.tileId, this.audioPlayer) : super([tileId, audioPlayer]);
}