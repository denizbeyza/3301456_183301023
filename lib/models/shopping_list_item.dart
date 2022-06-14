class ShoppingListItem {
  String? text;
  String? id;
  ShoppingListItem({ this.text,  this.id});

  ShoppingListItem.fromJson(var json) {
    text = json["text"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["text"] = text;
    data["id"] = id;
    return data;
  }
}
