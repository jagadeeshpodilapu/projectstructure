import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// value provider will give the value only

final valueProvider = Provider<int>((ref) {
  return 36;
});

/* StateProvider
So far we managed to read a provider's value inside a widget. 
But Provider itself doesn't give us any capability to change its value.
 For that we need to create a StateProvider: */

final counterStateProvider = StateProvider<int>((ref) {
  return 0;
});

// 1 way to do Using a Consumer
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // 1. Add a Consumer
        child: Consumer(
          // 2. specify the builder and obtain a WidgetRef
          builder: (_, WidgetRef ref, __) {
            // 3. use ref.watch() to get the value of the provider
            final value = ref.watch(counterStateProvider);
            return Text(
              'Value: $value',
              style: Theme.of(context).textTheme.headline4,
            );
          },
        ),
      ),
    );
  }
}

// 1. Widget class now extends [ConsumerWidget]
class HomePage2 extends ConsumerWidget {
  @override
  // 2. build() method has an extra [WidgetRef] argument
  Widget build(BuildContext context, WidgetRef ref) {
    // 3. use ref.watch() to get the value of the provider
    final value = ref.watch(counterStateProvider);
    return Scaffold(
      body: Center(
        child: Text(
          'Value: $value',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          // access the provider via ref.read(), then increment its state.
          onPressed: () => ref.read(counterStateProvider.notifier).state++,
          child: Icon(Icons.add)),
    );
  }
}

/* 

1. stateful widget -> consumerStatefullwidget

2. ref.read()  -- should  be used in life cycle methods

3. ref.watch() -- could be used in build method only


if we need to listen state full widget  init state we can use ref.read and build method we can use ref.watch.



 */

// StateNotifierProvider
// ---> Provider and StateProvider are sufficient for simple use cases like the counter example.

class Clock extends StateNotifier<DateTime> {
  // 1. initialize with current time
  Clock() : super(DateTime.now()) {
    // 2. create a timer that fires every second
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      // 3. update the state with the current time
      state = DateTime.now();
    });
  }

  late final Timer _timer;

  // 4. cancel the timer when finished
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

final clockProvider = StateNotifierProvider<Clock, DateTime>((ref) {
  return Clock();
});

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // this line is used to watch the provider's *state*
    // to get an instance of the clock itself,
    // call `ref.watch(clockProvider.notifier)`
    final currentTime = ref.watch(clockProvider);
    // format the time as `hh:mm:ss`
    final timeFormatted = DateFormat.Hms().format(currentTime);
    return Scaffold(
      body: Center(
        child: Text(
          timeFormatted,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}
