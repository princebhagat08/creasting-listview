import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youbloomdemo/bloc/home_bloc/home_bloc.dart';
import 'package:youbloomdemo/bloc/home_bloc/home_event.dart';
import 'package:youbloomdemo/bloc/home_bloc/home_state.dart';
import 'package:youbloomdemo/config/routes/routes_name.dart';
import 'package:youbloomdemo/config/text_style/text_style.dart';
import 'package:youbloomdemo/model/product_model.dart';
import 'package:youbloomdemo/screens/description_screen/description_screen.dart';
import 'package:youbloomdemo/utils/custom_widgets/custom_loader.dart';
import 'package:youbloomdemo/utils/enums.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youbloomdemo/config/routes/custom_page_route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = ScrollController();
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  // Initializing and fetching the product list
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FetchProduct());
    controller.addListener(
        () => context.read<HomeBloc>().add(ScrollListenerEvent(controller)));
  }

  // Dispose the controller
  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  // Remove the focus from the search bar
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // header
                Text(
                  'POPULAR PRODUCTS',
                  style: xLargeBoldText,
                ),
                const SizedBox(height: 16),

                // Search bar
                _searchbar(),
                const SizedBox(height: 16),

                // ListView of Products
                Expanded(
                  child: BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state.productStatus == LoadingStatus.loading &&
                          !state.isLoadingMore) {
                        return _buildShimmerEffect(size);
                      }

                      if (state.productStatus == LoadingStatus.error) {
                        return Center(child: Text(state.message));
                      }

                      if (state.productStatus == LoadingStatus.success ||
                          state.isLoadingMore) {
                        return state.message.isNotEmpty
                            ? Center(
                                child: Text(state.message),
                              )
                            : ListView.builder(
                                controller: controller,
                                itemCount: state.filteredData.isNotEmpty
                                    ? state.filteredData.length
                                    : state.isLoadingMore ?state.productData.length+1 :state.productData.length + (state.hasMoreProducts ? 0 : 1),
                                itemBuilder: (context, index) {
                                  if (state.filteredData.isEmpty && state.isLoadingMore && index == state.productData.length) {
                                    return const CustomLoader();
                                  }

                                  if (!state.hasMoreProducts && index == state.productData.length) {
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          "No more products",
                                          style: TextStyle(fontSize: 16, color: Colors.grey),
                                        ),
                                      ),
                                    );
                                  }

                                  final product = state.filteredData.isNotEmpty
                                      ? state.filteredData[index]
                                      : state.productData[index];

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 16.0),
                                    child: _singleProductCard(context, product, size),
                                  );
                                },
                              );
                      }

                      return const Center(child: Text('No products available'));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Shimmer effect for loading
  Widget _buildShimmerEffect(Size size) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: size.height * 0.2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        );
      },
    );
  }

// Search bar
  Widget _searchbar() {
    return TextField(
      controller: searchController,
      focusNode: searchFocusNode,
      decoration: InputDecoration(
        hintText: 'Search products...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      onChanged: (value) {
        if (value.trim().isEmpty) {
          context.read<HomeBloc>().add(const FilterProduct(''));
        } else {
          context.read<HomeBloc>().add(FilterProduct(value));
        }
      },
    );
  }

// Single Product Card
  Widget _singleProductCard(BuildContext context, Products product, Size size) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(RoutesName.productDescription, arguments: product);
      },
      child: Container(
        height: size.height * 0.25,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Hero(
                tag: product.id!,
                child: CachedNetworkImage(
                  imageUrl: product.thumbnail!,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text('${product.stock} items'),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.favorite_border),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${product.price}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Colors.yellow,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.shopping_bag_outlined),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
