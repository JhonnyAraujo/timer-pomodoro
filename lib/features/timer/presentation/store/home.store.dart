import 'dart:async';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:mobx/mobx.dart';
part 'home.store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

// The store-class
abstract class HomeStoreBase with Store {
  @observable
  int _studyTimer = 1500;
  int get studyTimer => _studyTimer;

  @observable
  int _restTimer = 300;
  int get restTimer => _restTimer;

  @observable
  bool _isRunning = false;
  bool get isRunner => _isRunning;

  @observable
  bool _isStudyMode = true;

  @computed
  String get formattedTime {
    int min = 0;
    int sec = 0;

    if (_isStudyMode) {
      min = _studyTimer ~/ 60;
      sec = _studyTimer % 60;
    } else {
      min = _restTimer ~/ 60;
      sec = _restTimer % 60;
    }

    String minStr = min.toString().padLeft(2, '0');
    String secStr = sec.toString().padLeft(2, '0');

    return '$minStr:$secStr';
  }

  Timer? _relogio;

  @action
  void startTimer() {
    if (_relogio != null && _relogio!.isActive) {
      _relogio!.cancel();
      _isRunning = false;
      return;
    }

    _isRunning = true;

    if (_isStudyMode) {
      _relogio = Timer.periodic(Duration(seconds: 1), (timer) {
        _studyTimer--;

        if (_studyTimer < 0) {
          FlutterRingtonePlayer().playAlarm();
          Future.delayed(Duration(seconds: 6), () {
            FlutterRingtonePlayer().stop();
          });

          _isStudyMode = false;
          _studyTimer = 1500;
          _isRunning = false;
          timer.cancel();
        }
      });
    }

    if (!_isStudyMode) {
      _relogio = Timer.periodic(Duration(seconds: 1), (timer) {
        _restTimer--;

        if (_restTimer < 0) {
          FlutterRingtonePlayer().playAlarm();
          Future.delayed(Duration(seconds: 6), () {
            FlutterRingtonePlayer().stop();
          });

          _relogio?.cancel();
          _isStudyMode = true;
          _restTimer = 300;
          _isRunning = false;
          timer.cancel();
        }
      });
    }
  }
}
