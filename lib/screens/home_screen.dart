import 'package:amazon_app/resources/cloundfirestore_method.dart';
import 'package:amazon_app/utils/constant.dart';
import 'package:amazon_app/widgets/banner_ad_widget.dart';
import 'package:amazon_app/widgets/categories_horizontal_list_view_bar.dart';
import 'package:amazon_app/widgets/loading_widget.dart';
import 'package:amazon_app/widgets/products_showcase_list_view.dart';
import 'package:amazon_app/widgets/search_bar_widget.dart';
import 'package:amazon_app/widgets/user_details_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();
  double offset = 0;
  List<Widget>? discount70;
  List<Widget>? discount60;
  List<Widget>? discount50;
  List<Widget>? discount0;

  @override
  void initState() {
    super.initState();
    getData();
    scrollController.addListener(() {
      setState(() {
        offset = scrollController.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  void getData() async {
    List<Widget> temp70 =
        await CloundFirestoreMethod().getProductsFromDiscount(70);
    List<Widget> temp60 =
        await CloundFirestoreMethod().getProductsFromDiscount(60);
    List<Widget> temp50 =
        await CloundFirestoreMethod().getProductsFromDiscount(50);
    List<Widget> temp0 =
        await CloundFirestoreMethod().getProductsFromDiscount(0);
    setState(() {
      discount70 = temp70;
      discount60 = temp60;
      discount50 = temp50;
      discount0 = temp0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
        isReadOnly: true,
        hasBackButton: false,
      ),
      body: discount70 != null &&
              discount60 != null &&
              discount50 != null &&
              discount0 != null
          ? Stack(
              children: [
                SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: kAppBarHeight / 2,
                      ),
                      const CategoriesHorizontalListViewBar(),
                      const BannerAddWidget(),
                      ProductShowcaseListView(
                          title: "Up to 70% Off", children: discount70!),
                      ProductShowcaseListView(
                          title: "Up to 60% Off", children: discount60!),
                      ProductShowcaseListView(
                          title: "Up to 50% Off", children: discount50!),
                      ProductShowcaseListView(
                          title: "Explore", children: discount0!),
                    ],
                  ),
                ),
                UserDetailsBar(
                  offset: offset,
                ),
              ],
            )
          : const LoadingWidget(),
    );
  }
}
