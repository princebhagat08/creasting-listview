import 'package:bloc/bloc.dart';
import 'package:youbloomdemo/bloc/home_bloc/home_event.dart';
import 'package:youbloomdemo/bloc/home_bloc/home_state.dart';
import 'package:youbloomdemo/repository/home_repo/home_repository.dart';
import 'package:youbloomdemo/utils/enums.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepository homeRepository = HomeRepository();

  HomeBloc() : super(const HomeState()) {
    on<FetchProduct>(_fetchProducts);
    on<ScrollListenerEvent>(_scrollListener);
  }

  void _fetchProducts(FetchProduct event, Emitter<HomeState> emit) async {
    emit(state.copyWith(productStatus: LoadingStatus.loading));

    try {
      final productData = await homeRepository.getProduct(7, state.page);
      final productList = productData.products ?? [];
      final updatedProduct = [...state.productData, ...productList];
      emit(state.copyWith(
          productStatus: LoadingStatus.success, productData: updatedProduct,isLoadingMore: false));
    } catch (e) {
      emit(state.copyWith(
          productStatus: LoadingStatus.error, message: e.toString()));
    }
  }

  void _scrollListener(ScrollListenerEvent event, Emitter<HomeState> emit) {
    final controller = event.controller;

    if (controller.position.pixels == controller.position.maxScrollExtent) {
      if(!state.isLoadingMore){
        final int newPage = state.page + 1;
        emit(state.copyWith(page: newPage, isLoadingMore: true));
        print('page Number : ${state.page}');
        add(FetchProduct());
      }
    } else {
      print("thoda aur");
    }

  }

}
