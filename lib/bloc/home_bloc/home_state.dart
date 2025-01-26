import 'package:equatable/equatable.dart';
import 'package:youbloomdemo/model/product_model.dart';
import 'package:youbloomdemo/utils/enums.dart';

class HomeState extends Equatable {
  final LoadingStatus productStatus;
  final List<Products> productData;
  final String message;
  final int page;
  final bool isLoadingMore;
  final bool hasMoreProducts;
  final List<Products> filteredData;

  const HomeState({
    this.productStatus = LoadingStatus.initial,
    this.productData = const [],
    this.message = '',
    this.page = 1,
    this.isLoadingMore = false,
    this.hasMoreProducts = false,
    this.filteredData = const []
  });

  HomeState copyWith({
    LoadingStatus? productStatus,
    List<Products>? productData,
    String? message,
    int? page,
    bool? isLoadingMore,
    bool? hasMoreProducts,
    List<Products>? filteredData

  }) {
    return HomeState(
      productStatus: productStatus ?? this.productStatus,
      productData: productData ?? this.productData,
      message: message ?? this.message,
      page: page ?? this.page,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        hasMoreProducts: hasMoreProducts ?? this.hasMoreProducts,
      filteredData: filteredData ?? this.filteredData
    );
  }

  @override
  List<Object?> get props =>
      [productStatus, productData, message,page,isLoadingMore, hasMoreProducts, filteredData];
}
