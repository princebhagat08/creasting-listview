import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:youbloomdemo/bloc/home_bloc/home_bloc.dart';
import 'package:youbloomdemo/bloc/home_bloc/home_event.dart';
import 'package:youbloomdemo/bloc/home_bloc/home_state.dart';
import 'package:youbloomdemo/model/product_model.dart';
import 'package:youbloomdemo/repository/home_repo/home_repository.dart';
import 'package:youbloomdemo/utils/enums.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

class MockScrollController extends Mock implements ScrollController {}

void main() {
  late HomeBloc homeBloc;
  late MockHomeRepository mockHomeRepository;
  late MockScrollController mockScrollController;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    mockScrollController = MockScrollController();
    homeBloc = HomeBloc()..homeRepository = mockHomeRepository;
  });

  tearDown(() {
    homeBloc.close();
  });

  group('HomeBloc', () {
    final mockProducts = ProductModel(
      products: [
        Products(
          id: 1,
          title: 'Test Product',
          description: 'Test Description',
          category: 'Test Category',
        ),
      ],
    );

    test('initial state is correct', () {
      expect(homeBloc.state, const HomeState());
    });

    blocTest<HomeBloc, HomeState>(
      'emits [loading, success] when FetchProduct is successful',
      build: () {
        when(() => mockHomeRepository.getProduct(any(), any()))
            .thenAnswer((_) async => mockProducts);
        return homeBloc;
      },
      act: (bloc) => bloc.add(FetchProduct()),
      expect: () => [
        const HomeState(productStatus: LoadingStatus.loading),
        HomeState(
          productStatus: LoadingStatus.success,
          productData: mockProducts.products!,
          hasMoreProducts: true,
          isLoadingMore: false,
        ),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'emits [loading, error] when FetchProduct fails',
      build: () {
        when(() => mockHomeRepository.getProduct(any(), any()))
            .thenThrow('Error fetching products');
        return homeBloc;
      },
      act: (bloc) => bloc.add(FetchProduct()),
      expect: () => [
        const HomeState(productStatus: LoadingStatus.loading),
        const HomeState(
          productStatus: LoadingStatus.error,
          message: 'Error fetching products',
        ),
      ],
    );
  });
}
