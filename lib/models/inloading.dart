class InLoading {
  InLoading({
    this.address = true,
    this.cart = true,
    this.currentorder = true,
    this.order = true,
    this.user = true,
    this.dogproduct = true,
    this.allproduct = true,
    this.categoryload = true,
    this.servproduct = true,
    this.bestproduct = true,
    this.favproduct = true,
    this.selected = false,
    this.listofcategory,
  });

  bool address;
  bool cart;
  bool currentorder;
  bool order;
  bool user;
  bool dogproduct;
  bool selected;
  bool allproduct;
  bool categoryload;
  bool servproduct;
  bool bestproduct;
  bool favproduct;
  List<dynamic> listofcategory;

  factory InLoading.fromJson(Map<String, dynamic> json) => InLoading(
      address: json["address"],
      cart: json["cart"],
      currentorder: json["currentorder"],
      order: json["order"],
      user: json["user"],
      dogproduct: json["dogproduct"],
      selected: json['selected'],
      allproduct: json['allproduct'],
      categoryload: json['categoryload'],
      servproduct: json['servproduct'],
      bestproduct: json['bestproduct'],
      favproduct: json['favproduct'],
      listofcategory: json['listofcategory']);

  Map<String, dynamic> toJson() => {
        "address": address,
        "cart": cart,
        "currentorder": currentorder,
        "order": order,
        "user": user,
        "dogproduct": dogproduct,
        'selected': selected,
        'allproduct': allproduct,
        'categoryload': categoryload,
        'servproduct': servproduct,
        'bestproduct': bestproduct,
        'favproduct': favproduct,
        'listofcategory': listofcategory
      };
}
