import 'package:ecommerce/helper/Colors.dart';
import 'package:ecommerce/helper/cartmodel.dart';
import 'package:ecommerce/helper/viewmodel.dart';
import 'package:ecommerce/success.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<CartModel> model = [];
  double totalvalue = 0;

  @override
  void initState() {
    super.initState();
    model = Provider.of<EcomViewModel>(context, listen: false).cartModel;
    print("COUNT INSIDE CART" + model.length.toString());
    model.forEach((element) {
      if (int.parse(element.qty) > 0) {
        totalvalue += double.parse(element.amount);

        print(totalvalue);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: blackColor),
        backgroundColor: textcolor,
        automaticallyImplyLeading: true,
        title: Text(
          "Order Summary",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: [
                    Consumer<EcomViewModel>(
                      builder: (context, model, child) => Card(
                        color: Colors.blueGrey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            model.cartcount.length.toString() + " Dishes",
                            style: TextStyle(color: textcolor),
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: model.length,
                        itemBuilder: (BuildContext context, int index) {
                          return int.parse(model[index].qty) > 0
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            model[index].product_type == "2"
                                                ? Image.asset(
                                                    'assets/images/veg.png',
                                                    height: 20,
                                                  )
                                                : Image.asset(
                                                    'assets/images/non-veg.png',
                                                    height: 20,
                                                  ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              model[index].product_name,
                                              style: TextStyle(
                                                  color: blackColor,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "INR " + model[index].amount,
                                          style: TextStyle(
                                              color: blackColor, fontSize: 14),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          model[index].calorie + " Calories",
                                          style: TextStyle(
                                              color: blackColor, fontSize: 14),
                                        ),
                                      ),
                                      Divider(
                                        height: 2,
                                        color: Colors.grey.shade500,
                                      )
                                    ],
                                  ),
                                )
                              : Container();
                        }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Total Amount ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            "INR " + totalvalue.toString(),
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Success(
                          // user: user,
                          ),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.blueGrey,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(
                        "Place order",
                        style: TextStyle(color: textcolor),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
