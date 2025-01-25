import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class HomeEvent extends Equatable{
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchProduct extends HomeEvent{}

class ScrollListenerEvent extends HomeEvent{
  final ScrollController controller;
  const ScrollListenerEvent(this.controller);
  @override
  List<Object> get props =>[];
}