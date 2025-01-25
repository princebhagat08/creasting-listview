import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youbloomdemo/bloc/home_bloc/home_bloc.dart';
import 'package:youbloomdemo/bloc/home_bloc/home_event.dart';
import 'package:youbloomdemo/bloc/home_bloc/home_state.dart';
import 'package:youbloomdemo/utils/custom_widgets/custom_loader.dart';
import 'package:youbloomdemo/utils/enums.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FetchProduct());
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'POPULAR PRODUCTS',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state.productStatus == LoadingStatus.loading) {
                        return  CustomLoader();
                      }

                      if (state.productStatus == LoadingStatus.error) {
                        return Center(child: Text(state.message));
                      }

                      if (state.productStatus == LoadingStatus.success) {
                        final products = state.productData?.products;
                        return ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            final product = products![index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Container(
                                height: 250,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        product.thumbnail!,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.contain,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 4,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Text(
                                                    '${product.stock} items'),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                    Icons.favorite_border),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '\$${product.price}',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.yellow,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const Icon(Icons
                                                        .shopping_bag_outlined),
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
      );

  }
}
