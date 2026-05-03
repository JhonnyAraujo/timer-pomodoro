import 'dart:async';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:mobx/mobx.dart';
part 'home.store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

// The store-class
abstract class HomeStoreBase with Store {
  Timer? _relogio;

  @observable
  int _cycleCount = 0;
  int get cycleCount => _cycleCount;

  @observable
  int _longRestTimer = 900;
  int get longRestTimer => _longRestTimer;

  @observable
  int _focusTimer = 1500;
  int get focusTimer => _focusTimer;

  @observable
  int _restTimer = 300;
  int get restTimer => _restTimer;

  @observable
  bool _isRunning = false;
  bool get isRunner => _isRunning;

  @observable
  bool _isFocusMode = true;

  @computed
  String get formattedTime {
    int min = 0;
    int sec = 0;

    if (_isFocusMode) {
      min = _focusTimer ~/ 60;
      sec = _focusTimer % 60;
    } else if (_cycleCount == 4 || _cycleCount == 8) {
      min = _longRestTimer ~/ 60;
      sec = _longRestTimer % 60;
    } else {
      min = _restTimer ~/ 60;
      sec = _restTimer % 60;
    }

    String minStr = min.toString().padLeft(2, '0');
    String secStr = sec.toString().padLeft(2, '0');

    return '$minStr:$secStr';
  }

  @action
  void startTimer() {
    if (_relogio != null && _relogio!.isActive) {
      _relogio!.cancel();
      _isRunning = false;
      return;
    }

    _isRunning = true;

    if (_isFocusMode) {
      _relogio = Timer.periodic(const Duration(seconds: 1), (timer) {
        _focusTimer--;

        if (_focusTimer < 0) {
          FlutterRingtonePlayer().playAlarm();
          Future.delayed(const Duration(seconds: 6), () {
            FlutterRingtonePlayer().stop();
          });

          _isFocusMode = false;
          _focusTimer = 1500;
          _isRunning = false;
          _cycleCount++;
          timer.cancel();
        }
      });
    }

    if (!_isFocusMode) {
      _relogio = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_cycleCount == 4 || _cycleCount == 8) {
          _longRestTimer--;

          if (_longRestTimer < 0) {
            FlutterRingtonePlayer().playAlarm();
            Future.delayed(const Duration(seconds: 6), () {
              FlutterRingtonePlayer().stop();
            });

            _relogio?.cancel();
            _isFocusMode = true;
            _longRestTimer = 900;
            _isRunning = false;
            if (_cycleCount == 8) _cycleCount = 0;
            timer.cancel();
          }
        } else {
          _restTimer--;

          if (_restTimer < 0) {
            FlutterRingtonePlayer().playAlarm();
            Future.delayed(const Duration(seconds: 6), () {
              FlutterRingtonePlayer().stop();
            });

            _relogio?.cancel();
            _isFocusMode = true;
            _restTimer = 300;
            _isRunning = false;
            timer.cancel();
          }
        }
      });
    }
  }

  @action
  void resetTimer() {
    _relogio?.cancel();
    _isRunning = false;
    _focusTimer = 1500;
    _restTimer = 300;
  }

  @action
  void nextTimer() {
    _isFocusMode = !_isFocusMode;
    _focusTimer = 1500;
    _restTimer = 300;
    _isRunning = false;
  }
}
