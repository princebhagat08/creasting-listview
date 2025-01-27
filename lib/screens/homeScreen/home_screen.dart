import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youbloomdemo/bloc/home_bloc/home_bloc.dart';
import 'package:youbloomdemo/bloc/home_bloc/home_event.dart';
import 'package:youbloomdemo/bloc/home_bloc/home_state.dart';
import 'package:youbloomdemo/bloc/language_bloc/language_bloc.dart';
import 'package:youbloomdemo/bloc/language_bloc/language_event.dart';
import 'package:youbloomdemo/bloc/login_bloc/login_bloc.dart';
import 'package:youbloomdemo/bloc/login_bloc/login_event.dart';
import 'package:youbloomdemo/config/color/color.dart';
import 'package:youbloomdemo/config/internationalization/language.dart';
import 'package:youbloomdemo/config/routes/routes_name.dart';
import 'package:youbloomdemo/config/text_style/text_style.dart';
import 'package:youbloomdemo/model/product_model.dart';
import 'package:youbloomdemo/utils/custom_widgets/custom_loader.dart';
import 'package:youbloomdemo/utils/enums.dart';
import 'package:shimmer/shimmer.dart';

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

  @override
  Widget build(BuildContext context) {
    final language = context.read<LanguageBloc>().language;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.offWhite,
        title: _searchbar(),
        actions: [
          _changeLanguage(),
          _logout(),
        ],
        toolbarHeight: 80,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state.productStatus == LoadingStatus.loading &&
                    !state.isLoadingMore) {
                  return _buildShimmerEffect(size);
                }

                if (state.productStatus == LoadingStatus.error) {
                  return Center(child: Text(language.getText(state.message),));
                }

                if (state.productStatus == LoadingStatus.success ||
                    state.isLoadingMore) {
                  return state.message.isNotEmpty
                      ? Center(
                          child: Text(language.getText(state.message),),
                        )
                      : ListView.builder(
                          controller: controller,
                          itemCount: state.filteredData.isNotEmpty
                              ? state.filteredData.length
                              : state.isLoadingMore
                                  ? state.productData.length + 1
                                  : state.productData.length +
                                      (state.hasMoreProducts ? 0 : 1),
                          itemBuilder: (context, index) {
                            if (state.filteredData.isEmpty &&
                                state.isLoadingMore &&
                                index == state.productData.length) {
                              return const CustomLoader();
                            }

                            if (!state.hasMoreProducts &&
                                index == state.productData.length) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    language.getText('no_more_products'),
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey),
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

                return Center(
                    child: Text(
                  language.getText('no_product_fount'),
                ));
              },
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
    final language = context.read<LanguageBloc>().language;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: TextField(
        controller: searchController,
        focusNode: searchFocusNode,
        decoration: InputDecoration(
          hintText: language.getText('search_products'),
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
      ),
    );
  }

//   Widget logout
  Widget _logout() {
    return IconButton(
        onPressed: () {
          context.read<LoginBloc>().add(LogoutUser());
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.login, (route) => false);
        },
        icon: Icon(
          Icons.logout_outlined,
          color: Colors.red,
        ));
  }

//   Change language button
  Widget _changeLanguage() {
    return DropdownButton<String>(
      value: context.watch<LanguageBloc>().state.languageCode,
      style: smallColorText,
      icon: const Icon(
        Icons.language,
        color: AppColor.primaryColor,
      ),
      underline: Container(),
      items: const [
        DropdownMenuItem(
          value: Language.english,
          child: Text('English'),
        ),
        DropdownMenuItem(
          value: Language.hindi,
          child: Text('हिंदी'), // Hindi text
        ),
      ],
      onChanged: (String? newValue) {
        if (newValue != null) {
          context.read<LanguageBloc>().add(ChangeLanguage(newValue));
        }
      },
    );
  }

// Single Product Card
  Widget _singleProductCard(BuildContext context, Products product, Size size) {
    final language = context.read<LanguageBloc>().language;
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
                        child: Text(
                            '${product.stock} ${language.getText('items')}'),
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
