import 'package:equatable/equatable.dart';
import 'package:youbloomdemo/model/product_model.dart';
import 'package:youbloomdemo/utils/enums.dart';

class HomeState extends Equatable {
  final LoadingStatus productStatus;
  final ProductModel? productData;
  final String message;

  const HomeState({
    this.productStatus = LoadingStatus.initial,
    this.productData,
    this.message = '',
  });

  HomeState copyWith({
    LoadingStatus? productStatus,
    ProductModel? productData,
    String? message,
  }) {
    return HomeState(
      productStatus: productStatus ?? this.productStatus,
      productData: productData ?? this.productData,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props =>
      [productStatus, productData, message];
}
