class ListOfdata {
  final List<ProductsModel> model;

  ListOfdata({
    required this.model,
  });

  factory ListOfdata.fromJson(List<dynamic> parsedJson) {
    List<ProductsModel> photos = [];

    return new ListOfdata(
      model: photos,
    );
  }
}

class ProductsModel {
  late String restaurantId;
  late String restaurantName;
  late String restaurantImage;
  late String tableId;
  late String tableName;
  late String branchName;
  late String nexturl;
  late List<TableMenuList> tableMenuList;

  ProductsModel(
      {required this.restaurantId,
      required this.restaurantName,
      required this.restaurantImage,
      required this.tableId,
      required this.tableName,
      required this.branchName,
      required this.nexturl,
      required this.tableMenuList});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    restaurantId = json['restaurant_id'];
    restaurantName = json['restaurant_name'];
    restaurantImage = json['restaurant_image'];
    tableId = json['table_id'];
    tableName = json['table_name'];
    branchName = json['branch_name'];
    nexturl = json['nexturl'];
    if (json['table_menu_list'] != null) {
      tableMenuList = [];
      json['table_menu_list'].forEach((v) {
        tableMenuList.add(new TableMenuList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurant_id'] = this.restaurantId;
    data['restaurant_name'] = this.restaurantName;
    data['restaurant_image'] = this.restaurantImage;
    data['table_id'] = this.tableId;
    data['table_name'] = this.tableName;
    data['branch_name'] = this.branchName;
    data['nexturl'] = this.nexturl;
    if (this.tableMenuList != null) {
      data['table_menu_list'] =
          this.tableMenuList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TableMenuList {
  late String menuCategory;
  late String menuCategoryId;
  late String menuCategoryImage;
  late String nexturl;
  late List<CategoryDishes> categoryDishes;

  TableMenuList(
      {required this.menuCategory,
      required this.menuCategoryId,
      required this.menuCategoryImage,
      required this.nexturl,
      required this.categoryDishes});

  TableMenuList.fromJson(Map<String, dynamic> json) {
    menuCategory = json['menu_category'];
    menuCategoryId = json['menu_category_id'];
    menuCategoryImage = json['menu_category_image'];
    nexturl = json['nexturl'];
    if (json['category_dishes'] != null) {
      categoryDishes = [];
      json['category_dishes'].forEach((v) {
        categoryDishes.add(new CategoryDishes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_category'] = this.menuCategory;
    data['menu_category_id'] = this.menuCategoryId;
    data['menu_category_image'] = this.menuCategoryImage;
    data['nexturl'] = this.nexturl;
    if (this.categoryDishes != null) {
      data['category_dishes'] =
          this.categoryDishes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryDishes {
  late String dishId;
  late String dishName;
  late double dishPrice;
  late String dishImage;
  late String dishCurrency;
  late double dishCalories;
  late String dishDescription;
  late bool dishAvailability;
  late int dishType;
  late String nexturl;
  late List<AddonCat> addonCat;

  CategoryDishes(
      {required this.dishId,
      required this.dishName,
      required this.dishPrice,
      required this.dishImage,
      required this.dishCurrency,
      required this.dishCalories,
      required this.dishDescription,
      required this.dishAvailability,
      required this.dishType,
      required this.nexturl,
      required this.addonCat});

  CategoryDishes.fromJson(Map<String, dynamic> json) {
    dishId = json['dish_id'];
    dishName = json['dish_name'];
    dishPrice = json['dish_price'];
    dishImage = json['dish_image'];
    dishCurrency = json['dish_currency'];
    dishCalories = json['dish_calories'];
    dishDescription = json['dish_description'];
    dishAvailability = json['dish_Availability'];
    dishType = json['dish_Type'];
    nexturl = json['nexturl'];
    if (json['addonCat'] != null) {
      addonCat = [];
      json['addonCat'].forEach((v) {
        addonCat.add(new AddonCat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dish_id'] = this.dishId;
    data['dish_name'] = this.dishName;
    data['dish_price'] = this.dishPrice;
    data['dish_image'] = this.dishImage;
    data['dish_currency'] = this.dishCurrency;
    data['dish_calories'] = this.dishCalories;
    data['dish_description'] = this.dishDescription;
    data['dish_Availability'] = this.dishAvailability;
    data['dish_Type'] = this.dishType;
    data['nexturl'] = this.nexturl;
    if (this.addonCat != null) {
      data['addonCat'] = this.addonCat.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddonCat {
  late String addonCategory;
  late String addonCategoryId;
  late int addonSelection;
  late String nexturl;
  late List<Addons> addons;

  AddonCat(
      {required this.addonCategory,
      required this.addonCategoryId,
      required this.addonSelection,
      required this.nexturl,
      required this.addons});

  AddonCat.fromJson(Map<String, dynamic> json) {
    addonCategory = json['addon_category'];
    addonCategoryId = json['addon_category_id'];
    addonSelection = json['addon_selection'];
    nexturl = json['nexturl'];
    if (json['addons'] != null) {
      addons = [];
      json['addons'].forEach((v) {
        addons.add(new Addons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addon_category'] = this.addonCategory;
    data['addon_category_id'] = this.addonCategoryId;
    data['addon_selection'] = this.addonSelection;
    data['nexturl'] = this.nexturl;
    if (this.addons != null) {
      data['addons'] = this.addons.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Addons {
  late String dishId;
  late String dishName;
  late double dishPrice;
  late String dishImage;
  late String dishCurrency;
  late double dishCalories;
  late String dishDescription;
  late bool dishAvailability;
  late int dishType;

  Addons(
      {required this.dishId,
      required this.dishName,
      required this.dishPrice,
      required this.dishImage,
      required this.dishCurrency,
      required this.dishCalories,
      required this.dishDescription,
      required this.dishAvailability,
      required this.dishType});

  Addons.fromJson(Map<String, dynamic> json) {
    dishId = json['dish_id'];
    dishName = json['dish_name'];
    dishPrice = json['dish_price'];
    dishImage = json['dish_image'];
    dishCurrency = json['dish_currency'];
    dishCalories = json['dish_calories'];
    dishDescription = json['dish_description'];
    dishAvailability = json['dish_Availability'];
    dishType = json['dish_Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dish_id'] = this.dishId;
    data['dish_name'] = this.dishName;
    data['dish_price'] = this.dishPrice;
    data['dish_image'] = this.dishImage;
    data['dish_currency'] = this.dishCurrency;
    data['dish_calories'] = this.dishCalories;
    data['dish_description'] = this.dishDescription;
    data['dish_Availability'] = this.dishAvailability;
    data['dish_Type'] = this.dishType;
    return data;
  }
}
