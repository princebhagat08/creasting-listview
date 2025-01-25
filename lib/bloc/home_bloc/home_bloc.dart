import 'package:bloc/bloc.dart';
import 'package:youbloomdemo/bloc/home_bloc/home_event.dart';
import 'package:youbloomdemo/bloc/home_bloc/home_state.dart';
import 'package:youbloomdemo/repository/home_repo/home_repository.dart';
import 'package:youbloomdemo/utils/enums.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepository homeRepository = HomeRepository();

  HomeBloc() : super(const HomeState()) {
    on<FetchProduct>(_fetchProducts);
  }

  void _fetchProducts(FetchProduct event, Emitter<HomeState> emit) async {
    emit(state.copyWith(productStatus: LoadingStatus.loading));

    try {
      final productData = await homeRepository.getProduct();
      print(productData.products!.first.title);
      emit(state.copyWith(
          productStatus: LoadingStatus.success, productData: productData));
    } catch (e) {
      emit(state.copyWith(
          productStatus: LoadingStatus.error, message: e.toString()));
    }
  }
}
