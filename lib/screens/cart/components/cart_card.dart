import 'package:carteasy/models/Cart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset(cart.product.images[0]),
            ),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cart.product.title,
                style: TextStyle(color: Colors.black, fontSize: 13),
                maxLines: 2,
              ),
              SizedBox(height: 5),
              Text.rich(
                TextSpan(
                  text: "\$${cart.product.price}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                  children: [
                    // TextSpan(
                    //     text: " x${cart.numOfItem}",
                    //     style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 79,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[100]),
                    borderRadius: BorderRadius.circular(3)),
                child: Row(
                  children: [
                    Container(
                        width: 25,
                        height: 25,
                        child:
                            Center(child: Icon(Icons.add, color: Colors.grey))),
                    Container(width: 1, height: 25, color: Colors.grey[100]),
                    Container(
                        width: 25,
                        height: 25,
                        child: Center(child: Text(cart.numOfItem.toString()))),
                    Container(width: 1, height: 25, color: Colors.grey[100]),
                    Container(
                        width: 25,
                        height: 25,
                        child: Center(
                            child: Icon(Icons.remove, color: Colors.grey))),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
