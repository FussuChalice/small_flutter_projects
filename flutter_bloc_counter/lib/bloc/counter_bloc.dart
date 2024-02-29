import 'package:flutter_bloc/flutter_bloc.dart';

part "counter_event.dart";

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementEvent>(_onIncrement);
    on<CounterDecrimentEvent>(_onDecriment);
  }

  _onIncrement(CounterIncrementEvent event, Emitter<int> emitter) {
    if (state >= 100) {
      return;
    }

    emitter(state + 1);
  }

  _onDecriment(CounterDecrimentEvent event, Emitter<int> emitter) {
    if (state <= -100) {
      return;
    }

    emitter(state - 1);
  }
}
