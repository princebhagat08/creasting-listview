import 'package:equatable/equatable.dart';
import 'package:youbloomdemo/model/product_model.dart';
import 'package:youbloomdemo/utils/enums.dart';

class HomeState extends Equatable {
  final LoadingStatus productStatus;
  final List<Products> productData;
  final String message;

  final int page;
  final bool isLoadingMore;

  const HomeState({
    this.productStatus = LoadingStatus.initial,
    this.productData = const [],
    this.message = '',
    this.page = 1,
    this.isLoadingMore = false
  });

  HomeState copyWith({
    LoadingStatus? productStatus,
    List<Products>? productData,
    String? message,
    int? page,
    bool? isLoadingMore,
  }) {
    return HomeState(
      productStatus: productStatus ?? this.productStatus,
      productData: productData ?? this.productData,
      message: message ?? this.message,
      page: page ?? this.page,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props =>
      [productStatus, productData, message,page,isLoadingMore];
}
