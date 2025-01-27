import 'package:bloc/bloc.dart';
import 'package:youbloomdemo/bloc/home_bloc/home_event.dart';
import 'package:youbloomdemo/bloc/home_bloc/home_state.dart';
import 'package:youbloomdemo/model/product_model.dart';
import 'package:youbloomdemo/repository/home_repo/home_repository.dart';
import 'package:youbloomdemo/utils/enums.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepository homeRepository = HomeRepository();

  List<Products> filteredList = [];

  HomeBloc() : super(const HomeState()) {
    on<FetchProduct>(_fetchProducts);
    on<ScrollListenerEvent>(_scrollListener);
    on<FilterProduct>(_filterProduct);
  }

  void _fetchProducts(FetchProduct event, Emitter<HomeState> emit) async {
    emit(state.copyWith(productStatus: LoadingStatus.loading));

    try {
      final productData = await homeRepository.getProduct(7, state.page);
      final productList = productData.products ?? [];
      final hasMore = productList.isNotEmpty;
      final updatedProduct = [...state.productData, ...productList];
      emit(state.copyWith(
          productStatus: LoadingStatus.success,
          productData: updatedProduct,
          hasMoreProducts: hasMore,
          isLoadingMore: false));
    } catch (e) {
      emit(state.copyWith(
          productStatus: LoadingStatus.error, message: 'something_went_wrong'));
    }
  }

  void _scrollListener(ScrollListenerEvent event, Emitter<HomeState> emit) {
    final controller = event.controller;
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      if (!state.isLoadingMore && state.hasMoreProducts) {
        final int newPage = state.page + 1;
        emit(state.copyWith(page: newPage, isLoadingMore: true));
        add(FetchProduct());
      }
    }
  }

  void _filterProduct(FilterProduct event, Emitter<HomeState> emit) {
    if (event.key.isEmpty) {
      emit(state.copyWith(filteredData: [], message: ''));
    } else {
      final searchedKey = event.key.toLowerCase();
      filteredList = state.productData
          .where((product) =>
              product.title!.toString().toLowerCase().contains(searchedKey) ||
              product.description!
                  .toString()
                  .toLowerCase()
                  .contains(searchedKey) ||
              product.category!.toString().toLowerCase().contains(searchedKey))
          .toList();

      if (filteredList.isEmpty) {
        emit(state.copyWith(
          message: 'no_products_found'),);
      } else {
        emit(state.copyWith(filteredData: filteredList, message: ''));
      }
    }
  }
}
