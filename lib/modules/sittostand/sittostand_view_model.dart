import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_view_model_example/global/dark_mode_controller.dart';

class SitToStandScreenViewModel {
  final Ref ref;
  SitToStandScreenViewModel(this.ref);

  static final provider = AutoDisposeProvider<SitToStandScreenViewModel>((ref) {
    return SitToStandScreenViewModel(ref);
  });

  static const maxSeconds = 60;
  static const maxPreSeconds = 3;
  static const maxPostSeconds = 6;

  int seconds = maxSeconds;
  int preSeconds = maxPreSeconds;
  int postSeconds = maxPreSeconds;

  // Declare the counterProvider as static to be accessed outside of instances
  static final counterProvider = StateProvider<int>((ref) => maxSeconds);
  static final preCounterProvider = StateProvider<int>((ref) => maxPreSeconds);
  static final postCounterProvider = StateProvider<int>((ref) => maxPostSeconds);


  Timer? timer;
  Timer? preTimerTimer;
  Timer? postTimerTimer;

  static const bool pretimerIsOn = false;
  static const bool posttimerIsOn = false;

  static final preTimerProvider = StateProvider<bool>((ref) => pretimerIsOn);
  static final postTimerProvider = StateProvider<bool>((ref) => posttimerIsOn);

  void startTimer() {
    // Reset the seconds to maxSeconds if timer is started again
    seconds = maxSeconds;
    ref.read(counterProvider.notifier).state = seconds;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds--;
        ref.read(counterProvider.notifier).state = seconds;
      } else {
        stopTimer();
        postTimer();
      }
    });
  }

  void preTimer() {
    ref.read(preTimerProvider.notifier).state = true;

    preTimerTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (preSeconds > 0) {
        preSeconds--;
        ref.read(preCounterProvider.notifier).state = preSeconds;
      } else {
        stopPreTimer();
        ref.read(preTimerProvider.notifier).state = false;
        preTimerTimer?.cancel();
        startTimer();
      }

      
    });
  }

    void postTimer() {
    ref.read(postTimerProvider.notifier).state = true;
    // Reset the seconds to maxSeconds if timer is started again
    postSeconds = maxPostSeconds;
    ref.read(postCounterProvider.notifier).state = postSeconds;

    postTimerTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (postSeconds > 0) {
        postSeconds--;
        ref.read(postCounterProvider.notifier).state = postSeconds;
      } else {
        ref.read(postTimerProvider.notifier).state = false;
        stopPostTimer();
      }
    });
  }



  void stopTimer() {
    timer?.cancel();
    seconds = maxSeconds;
    ref.read(counterProvider.notifier).state = seconds;
  }
   void stopPreTimer() {
    preTimerTimer?.cancel();
    preSeconds = maxPreSeconds;
    ref.read(preCounterProvider.notifier).state = preSeconds;
  }
   void stopPostTimer() {
    postTimerTimer?.cancel();
    postSeconds = maxPostSeconds;
    ref.read(postCounterProvider.notifier).state = postSeconds;
  }

  void dispose() {
    stopTimer();
    stopPreTimer();
    stopPostTimer();
  }
}