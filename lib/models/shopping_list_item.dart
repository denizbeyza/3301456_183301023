class ShoppingListItem {
  String? text;
  bool? checked;

  ShoppingListItem({required this.text, required this.checked});

  ShoppingListItem.fromJson(var json) {
    text = json["text"];
    checked = json["checked"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["text"] = text;
    data["checked"] = checked;
    return data;
  }
}
