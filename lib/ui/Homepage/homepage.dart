import 'package:anglara_ecommerce/bloc/category_bloc/category_bloc.dart';
import 'package:anglara_ecommerce/repository/banner_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

import '../../bloc/banner_bloc/banner_bloc.dart';
import '../../repository/category_repository.dart';
import '../ProductList/product_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(providers: [
        BlocProvider<BannerBloc>(
          create: (context) =>
              BannerBloc(BannerRepository())..add(FetchBanner()),
        ),
        BlocProvider<CategoryBloc>(
          create: (context) =>
              CategoryBloc(CategoryRepository())..add(FetchCategory()),
        ),
      ], child: const HomePageLayout()),
    );
  }
}

class HomePageLayout extends StatelessWidget {
  const HomePageLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            SizedBox(height: 8),
            BannerWidget(),
            CategoryWidget(),
          ],
        ),
      ),
    );
  }
}

class BannerWidget extends StatelessWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerBloc, BannerState>(
      builder: (context, state) {
        if (state is BannerLoadedState) {
          return FlutterCarousel(
            items: state.banner.map((i) {
              int index = state.banner.indexOf(i);
              return Builder(
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 25.0, left: 8),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image:
                                NetworkImage(state.banner[index].downloadUrl!),
                            fit: BoxFit.fill),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
                height: 200,
                reverse: false,
                autoPlay: true,
                initialPage: 0,
                aspectRatio: 16 / 9,
                pageSnapping: true,
                viewportFraction: .85,
                enableInfiniteScroll: false,
                slideIndicator: CircularStaticIndicator(
                    indicatorRadius: 4,
                    currentIndicatorColor: Colors.red,
                    indicatorBorderColor: Colors.black,
                    indicatorBackgroundColor: Colors.white)),
          );
        } else if (state is BannerLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is BannerErrorState) {
          return Text(state.error);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const SizedBox();
        } else if (state is CategoryLoadedState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GridView.builder(
              itemCount: state.category.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return ProductPage(
                            category:
                                state.category[index].toString().toUpperCase());
                      },
                    ));
                  },
                  radius: 10,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.redAccent.shade100,
                    ),
                    child: Text(
                      state.category[index].toString().toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is CategoryErrorState) {
          return Center(
            child: Text(state.error),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
