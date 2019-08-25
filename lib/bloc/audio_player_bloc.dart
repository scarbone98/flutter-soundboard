import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'audio_player_state.dart';
import 'audio_player_event.dart';
import 'package:audioplayers/audioplayers.dart' as players;

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  @override
  AudioPlayerState get initialState => InitialAudioPlayerState();

  @override
  Stream<AudioPlayerState> mapEventToState(
    AudioPlayerEvent event,
  ) async* {
    if (event is PlayerStop) {
      event.audioPlayer.stop();
      yield Stopped();
    } else if (event is PlayerPlay) {
      players.AudioPlayer audioPlayer = await event.audioPlayer.play(event.tileId);
      yield Playing(event.tileId, audioPlayer);
    }
  }
}
