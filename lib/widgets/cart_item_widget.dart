import 'package:amazon_app/model/product_model.dart';
import 'package:amazon_app/resources/cloundfirestore_method.dart';
import 'package:amazon_app/screens/product_screen.dart';
import 'package:amazon_app/utils/color_theme.dart';
import 'package:amazon_app/utils/utils.dart';
import 'package:amazon_app/widgets/custom_simple_rounded_button.dart';
import 'package:amazon_app/widgets/custom_square_button.dart';
import 'package:amazon_app/widgets/product_information_widget.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final ProductModel productModel;

  const CartItemWidget({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize(context);
    return Container(
      padding: const EdgeInsets.all(25),
      height: screenSize.height / 2,
      width: screenSize.width,
      decoration: const BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductScreen(productModel: productModel)),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenSize.width / 3,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Center(
                        child: Image.network(productModel.url),
                      ),
                    ),
                  ),
                  ProductInformationWidget(
                    productName: productModel.productName,
                    cost: productModel.cost,
                    sellerName: productModel.sellerName,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                CustomSquareButton(
                  child: const Icon(Icons.remove),
                  onPressed: () {},
                  color: backgroundColor,
                  dimension: 40,
                ),
                CustomSquareButton(
                  child: const Text(
                    "0",
                    style: TextStyle(color: activeCyanColor),
                  ),
                  onPressed: () {},
                  color: Colors.white,
                  dimension: 40,
                ),
                CustomSquareButton(
                  child: const Icon(Icons.add),
                  onPressed: () async {
                    await CloundFirestoreMethod().addProductToCart(
                        productModel: ProductModel(
                            url: productModel.url,
                            productName: productModel.productName,
                            cost: productModel.cost,
                            discount: productModel.discount,
                            uid: Utils().getUid(),
                            sellerName: productModel.sellerName,
                            sellerUid: productModel.sellerUid,
                            rating: productModel.rating,
                            noOfRating: productModel.noOfRating));
                  },
                  color: backgroundColor,
                  dimension: 40,
                ),
              ],
            ),
            flex: 1,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CustomSimpleRoundedButton(
                          onPressed: () async {
                            CloundFirestoreMethod()
                                .deleteProductFromCart(uid: productModel.uid);
                          },
                          text: "Delete"),
                      const SizedBox(
                        width: 5,
                      ),
                      CustomSimpleRoundedButton(
                          onPressed: () {}, text: "Save for later"),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "See more like this",
                        style: TextStyle(
                          color: activeCyanColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
