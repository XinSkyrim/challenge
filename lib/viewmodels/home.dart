class BannerItem {
  String id;
  String imgUrl;
  BannerItem({required this.id, required this.imgUrl});

  factory BannerItem.formJSON(Map<String, dynamic> json) {

    return BannerItem(id: json["id"] ?? "", imgUrl: json["imgUrl"] ?? "");
  }
}

class CategoryCardItem {
  String title;
  String description;
  String imageUrl;
  int rentedPropsCount;

  CategoryCardItem({
    required this.title,
    required this.description,
    required this.imageUrl,
    this.rentedPropsCount = 0,
  });

  factory CategoryCardItem.formJSON(Map<String, dynamic> json) {
    return CategoryCardItem(
      title: json["title"]?.toString() ?? json["name"]?.toString() ?? "",
      description:
          json["description"]?.toString() ?? json["subtitle"]?.toString() ?? "",
      imageUrl:
          json["imageUrl"]?.toString() ??
          json["image"]?.toString() ??
          json["picture"]?.toString() ??
          "",
      rentedPropsCount:
          int.tryParse(json["rented_props_count"]?.toString() ?? "0") ?? 0,
    );
  }
}

class CategoryCardList {
  List<CategoryCardItem> items;

  CategoryCardList({required this.items});

  factory CategoryCardList.formJSON(dynamic json) {
    List<CategoryCardItem> items = [];


    if (json is List) {
      items = json
          .map(
            (item) => CategoryCardItem.formJSON(item as Map<String, dynamic>),
          )
          .toList();
    }

    else if (json is Map) {
      if (json["items"] != null) {
        items = (json["items"] as List)
            .map(
              (item) => CategoryCardItem.formJSON(item as Map<String, dynamic>),
            )
            .toList();
      } else if (json["data"] != null) {
        items = (json["data"] as List)
            .map(
              (item) => CategoryCardItem.formJSON(item as Map<String, dynamic>),
            )
            .toList();
      }
    }

    return CategoryCardList(items: items);
  }
}
