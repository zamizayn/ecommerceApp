import 'package:badges/badges.dart';
import 'package:ecommerce/cart.dart';
import 'package:ecommerce/helper/Colors.dart';
import 'package:ecommerce/helper/authentication.dart';
import 'package:ecommerce/helper/cartmodel.dart';
import 'package:ecommerce/helper/productmodel.dart';
import 'package:ecommerce/helper/viewmodel.dart';
import 'package:ecommerce/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    final data = Provider.of<EcomViewModel>(context, listen: false).fetchData();

    return Scaffold(
        drawer: Container(
          color: textcolor,
          width: MediaQuery.of(context).size.width / 1.2,
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
              child: Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                user != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(user.photoURL.toString()),
                        radius: 50,
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      child: user != null
                          ? Text(
                              user.displayName.toString(),
                              style: TextStyle(color: blackColor, fontSize: 18),
                            )
                          : Container()),
                ),
                user != null ? Text(user.email.toString()) : Container(),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: TextButton(
                    style: ButtonStyle(),
                    child: Text("SIGN OUT"),
                    onPressed: () async {
                      await Authentication.signOut(context: context);

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(
                              // user: user,
                              ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          )),
        ),
        appBar: AppBar(
          backgroundColor: textcolor,
          iconTheme: IconThemeData(color: blackColor),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Cart(
                        // user: user,
                        ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<EcomViewModel>(
                  builder: (context, viewm, child) => Badge(
                      badgeContent: Text(
                        viewm.cartcount.length.toString(),
                        style: TextStyle(color: textcolor),
                      ),
                      badgeColor: Colors.red,
                      child: Icon(Icons.shopping_cart)),
                ),
              ),
            )
          ],
        ),
        body: FutureBuilder(
            future:
                Provider.of<EcomViewModel>(context, listen: false).fetchData(),
            builder: (BuildContext ctx, snapshot) =>
                snapshot.connectionState == ConnectionState.done
                    ? Container(
                        child: Consumer<EcomViewModel>(
                        builder: (context, modelData, child) => Container(
                          child: DefaultTabController(
                            length: modelData.getData[0].tableMenuList.length,
                            child: Scaffold(
                              appBar: AppBar(
                                backgroundColor: textcolor,
                                toolbarHeight: 80,
                                bottom: TabBar(
                                  indicatorColor: Colors.red,
                                  isScrollable: true,
                                  tabs: List.generate(
                                    modelData.getData[0].tableMenuList.length,
                                    (index) => Tab(
                                      child: Text(
                                        modelData.getData[0]
                                            .tableMenuList[index].menuCategory,
                                        style: TextStyle(color: blackColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              body: TabBarView(
                                  children: List.generate(
                                      modelData.getData[0].tableMenuList.length,
                                      (index) => Tab(
                                            iconMargin: EdgeInsets.zero,
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    ListView.builder(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount: modelData
                                                            .getData[0]
                                                            .tableMenuList[
                                                                index]
                                                            .categoryDishes
                                                            .length,
                                                        itemBuilder: (BuildContext
                                                                context,
                                                            int indexDishes) {
                                                          CategoryDishes data = modelData
                                                                  .getData[0]
                                                                  .tableMenuList[
                                                                      index]
                                                                  .categoryDishes[
                                                              indexDishes];
                                                          modelData.cartModel.add(CartModel(
                                                              product_name:
                                                                  data.dishName,
                                                              product_type: data
                                                                  .dishType
                                                                  .toString(),
                                                              amount: data
                                                                  .dishPrice
                                                                  .toString(),
                                                              calorie: data
                                                                  .dishCalories
                                                                  .toString(),
                                                              qty: "0"));
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Card(
                                                                child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 8,
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              data.dishType == 2
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
                                                                                data.dishName.toString()[0].toUpperCase() + data.dishName.substring(1),
                                                                                style: TextStyle(
                                                                                  color: blackColor,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Text("INR " + data.dishPrice.toString()),
                                                                              Spacer(),
                                                                              Text(data.dishCalories.toString() + " Calories"),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            data.dishDescription,
                                                                            style:
                                                                                TextStyle(color: Colors.grey.shade500),
                                                                          ),
                                                                        ),
                                                                        Card(
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                                          color:
                                                                              greencolor,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 12.0, right: 12),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: GestureDetector(
                                                                                    onTap: () {
                                                                                      modelData.removeItem(CartModel(product_name: data.dishName, product_type: data.dishType.toString(), amount: data.dishPrice.toString(), calorie: data.dishCalories.toString(), qty: "1"));
                                                                                    },
                                                                                    child: Text(
                                                                                      "-",
                                                                                      style: TextStyle(fontSize: 25, color: textcolor),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: modelData.cartModel.length > 0 && modelData.cartModel[indexDishes].toString().length > 1 ? Text(modelData.cartModel[indexDishes].qty, style: TextStyle(fontSize: 16, color: textcolor)) : Text("0", style: TextStyle(fontSize: 16, color: textcolor)),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: GestureDetector(
                                                                                      onTap: () {
                                                                                        print('clicked');
                                                                                        modelData.addTocart(CartModel(product_name: data.dishName, product_type: data.dishType.toString(), amount: data.dishPrice.toString(), calorie: data.dishCalories.toString(), qty: "1"));
                                                                                      },
                                                                                      child: Text("+", style: TextStyle(fontSize: 25, color: textcolor))),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        data.addonCat.length >
                                                                                0
                                                                            ? Text(
                                                                                "Customizations Available",
                                                                                style: TextStyle(color: Colors.red),
                                                                              )
                                                                            : Container()
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 3,
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/firebase.png',
                                                                      height:
                                                                          50,
                                                                      width: 50,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            )),
                                                          );
                                                        })
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ))),
                            ),
                          ),
                        ),
                      ))
                    : Center(
                        child: CircularProgressIndicator(),
                      )));
  }
}
