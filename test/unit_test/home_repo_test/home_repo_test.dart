import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:youbloomdemo/data/network/network_api_services.dart';
import 'package:youbloomdemo/model/product_model.dart';
import 'package:youbloomdemo/utils/app_url.dart';
import '../../../lib/repository/home_repo/home_repository.dart';
import '../login_repo_test/login_repo_test.mocks.dart';

@GenerateNiceMocks([MockSpec<NetworkApiServices>()])
void main() {
  late HomeRepository homeRepository;
  late MockNetworkApiServices mockNetworkApiServices;

  setUp(() {
    mockNetworkApiServices = MockNetworkApiServices();
    homeRepository = HomeRepository();
    homeRepository.apiService = mockNetworkApiServices;
  });

  group('HomeRepository Test', () {
    test(
        'getProduct should return ProductModel with correct pagination parameters',
        () async {
      // Arrange
      final limit = 10;
      final page = 1;
      final mockResponse = {
        "products": [
          {
            "id": 1,
            "title": "Essence Mascara Lash Princess",
            "description": "Test description",
            "category": "beauty",
            "price": 9.99,
            "discountPercentage": 7.17,
            "rating": 4.94,
            "stock": 5,
            "tags": ["beauty", "mascara"],
            "brand": "Essence",
            "sku": "RCH45Q1A",
            "weight": 2.0,
            "dimensions": {"width": 23.17, "height": 14.43, "depth": 28.01},
            "warrantyInformation": "1 month warranty",
            "shippingInformation": "Ships in 1 month",
            "availabilityStatus": "Low Stock",
            "reviews": [
              {
                "rating": 5,
                "comment": "Great product!",
                "date": "2024-05-23T08:56:21.618Z",
                "reviewerName": "John Doe",
                "reviewerEmail": "john@example.com"
              }
            ],
            "returnPolicy": "30 days return policy",
            "minimumOrderQuantity": 24.0,
            "images": ["image1.jpg", "image2.jpg"],
            "thumbnail": "thumbnail.jpg"
          }
        ]
      };

      // Setup mock behavior
      when(mockNetworkApiServices.getApi(
              '${AppUrl.productApi}?limit=$limit&skip=${limit * (page - 1)}'))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await homeRepository.getProduct(limit, page);

      // Assert
      expect(result, isA<ProductModel>());
      expect(result.products, isNotNull);
      expect(result.products!.length, 1);

      final product = result.products![0];
      expect(product.id, 1);
      expect(product.title, "Essence Mascara Lash Princess");
      expect(product.price, 9.99);
      expect(product.stock, 5);
      expect(product.brand, "Essence");
      expect(product.discountPercentage, 7.17);
      expect(product.rating, 4.94);
      expect(product.minimumOrderQuantity, 24.0);

      // Verify dimensions
      expect(product.dimensions?.width, 23.17);
      expect(product.dimensions?.height, 14.43);
      expect(product.dimensions?.depth, 28.01);

      // Verify reviews
      expect(product.reviews?.length, 1);
      expect(product.reviews?[0].rating, 5);
      expect(product.reviews?[0].reviewerName, "John Doe");

      verify(mockNetworkApiServices.getApi(
              '${AppUrl.productApi}?limit=$limit&skip=${limit * (page - 1)}'))
          .called(1);
    });

    test('getProduct should throw exception when API call fails', () async {
      // Arrange
      final limit = 10;
      final page = 1;
      when(mockNetworkApiServices.getApi(
              '${AppUrl.productApi}?limit=$limit&skip=${limit * (page - 1)}'))
          .thenAnswer((_) async => null);

      // Act & Assert
      expect(
        () => homeRepository.getProduct(limit, page),
        throwsA(isA<TypeError>()),
      );
      
      verify(mockNetworkApiServices.getApi(
              '${AppUrl.productApi}?limit=$limit&skip=${limit * (page - 1)}'))
          .called(1);
    });
  });
}
