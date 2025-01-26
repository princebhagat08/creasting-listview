import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:youbloomdemo/bloc/description_bloc/description_event.dart';
import 'package:youbloomdemo/bloc/description_bloc/description_state.dart';

class DescriptionBloc extends Bloc<DescriptionEvent,DescriptionState>{

  DescriptionBloc():super( DescriptionState()){
    on<AddToCart>(_addToCart);
  }

  void _addToCart(DescriptionEvent event, Emitter<DescriptionState> emit){
    Fluttertoast.showToast(msg: 'Product added to cart');
  }


}