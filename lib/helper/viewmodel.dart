import 'package:ecommerce/helper/cartmodel.dart';
import 'package:ecommerce/helper/productmodel.dart';
import 'package:ecommerce/helper/repository.dart';
import 'package:ecommerce/helper/web_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EcomViewModel extends ChangeNotifier {
  List<CartModel> cartModel = [];
  List<ProductsModel>? model = [];
  WebService service = WebService();
  List cartcount = [];
  double total = 0;

  void totalAmount(double value) {
    double sum = 0;

    total += value;

    print(total);
  }

  void clearAll() {
    cartModel.clear();
    cartcount.clear();
  }

  addTocart(CartModel modeldata) async {
    int index = cartModel.indexWhere(
        (element) => element.product_name == modeldata.product_name);
    if (index >= 0) {
      int value = int.parse(cartModel[index].qty);

      cartModel[index].qty = (value + 1).toString();
      notifyListeners();
    }
    if (index < 0) {
      cartModel.add(modeldata);
    }
    cartcount.clear();
    cartModel.forEach((element) {
      int count = int.parse(element.qty);
      if (count > 0) {
        cartcount.add(element);
      }
    });

    await Future.delayed(const Duration(milliseconds: 100), () {});
  }



  removeItem(CartModel modeldata) {
    int index = cartModel.indexWhere(
        (element) => element.product_name == modeldata.product_name);
    if (index >= 0) {
      int value = int.parse(cartModel[index].qty);
      if (value > 0) {
        cartModel[index].qty = (value - 1).toString();
      }
      notifyListeners();
    }

    //cartcount.remove(id);
  }

  List<ProductsModel> get getData {
    Future.delayed(const Duration(milliseconds: 100), () {
      //notifyListeners();
    });

    return model!;
  }

  Future<List<ProductsModel>> fetchData() async {
    await Future.delayed(const Duration(milliseconds: 100), () {});
    this.model = await service.get();
    print("GOT THE DATA");
    notifyListeners();
    return model!;
  }

  getTabs() {
    List<Tab> myTabs = List.generate(
      model![0].tableMenuList.length,
      (index) => Tab(text: 'TAB $index'),
    );
  }
}
