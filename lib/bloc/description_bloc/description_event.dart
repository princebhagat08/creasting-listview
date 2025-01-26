import 'package:equatable/equatable.dart';

abstract class DescriptionEvent extends Equatable{
 const DescriptionEvent();

 @override
  List<Object> get props => [];
}

class AddToCart extends DescriptionEvent{}

