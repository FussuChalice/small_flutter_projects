part of "counter_bloc.dart";

abstract class CounterEvent {}

class CounterIncrementEvent extends CounterEvent {}

class CounterDecrimentEvent extends CounterEvent {}
