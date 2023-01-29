import 'package:flutter/cupertino.dart';
import 'package:jewelery_shop_managmentsystem/model/filter_model.dart';
import 'package:jewelery_shop_managmentsystem/model/item_model.dart';

class Basket {
    Basket({
        required this.currentPage,
        required this.data,
        required this.firstPageUrl,
        required this.from,
        required this.lastPage,
        required this.lastPageUrl,
        required this.links,
        this.nextPageUrl,
        required this.path,
        required this.perPage,
        this.prevPageUrl,
        required this.to,
        required this.total,
    });

    int? currentPage;
    List<ItemBasket>? data;
    String? firstPageUrl;
    int? from;
    int? lastPage;
    String? lastPageUrl;
    List<Link>? links;
    dynamic? nextPageUrl;
    String? path;
    int? perPage;
    dynamic? prevPageUrl;
    int? to;
    int? total;

    factory Basket.fromJson(Map<String, dynamic> json) => Basket(
        currentPage: json["current_page"],
        data: List<ItemBasket>.from(json["data"].map((x) => ItemBasket.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );
    }
class ItemBasket with ChangeNotifier{
    ItemBasket({
          this.id,
         this.name,
         this.size,
         this.weight,
         this.profit,
         this.img,
         this.quantity,
         this.isFavourited,
         this.price,
         this.inBasket,
         this.caratMs,
         this.caratType,
         this.countryName,
    });

    int? id;
    String? name;
    int? size;
    int? weight;
    double? profit;
    String? img;
    int? quantity;
    bool? isFavourited;
    double? price;
    bool? inBasket;
    String? caratType;
    String? caratMs;
    String? countryName;

    factory ItemBasket.fromJson(Map<String, dynamic> json) => ItemBasket(
        id: json["id"],
        name: json["name"],
        size: json["size"],
        weight: json["weight"],
        profit: json["profit"]?.toDouble(),
        img: json["img"],
        quantity: json["quantity"],
        isFavourited: json["is_favourited"],
        price: json["price"]?.toDouble(),
        inBasket: json["in_basket"],
        caratType: Carat.fromJson(json["carat"]).type,
        caratMs: Carat.fromJson(json["carat"]).carat,
        countryName: Country.fromJson(json["country"]).name,
    );

   
}
class Pivot {
    Pivot({
        required this.userId,
        required this.itemId,
    });

    int userId;
    int itemId;

    factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        userId: json["user_id"],
        itemId: json["item_id"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "item_id": itemId,
    };
}

class Link {
    Link({
        this.url,
        required this.label,
        required this.active,
    });

    String? url;
    String label;
    bool active;

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
    };
}
