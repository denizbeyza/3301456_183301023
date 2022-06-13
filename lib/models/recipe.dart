class Recipe {
  String? id;
  String? notes;
  String? directions;
  String? preparationTime;
  String? photo;
  String? photoName;
  String? ingredients;
  String? cookingTime;
  String? title;
  bool? isFavorite;

  Recipe(
      {this.id,
      this.notes,
      this.directions,
      this.preparationTime,
      this.photo,
      this.photoName,
      this.ingredients,
      this.isFavorite,
      this.cookingTime,
      this.title});

  Recipe.fromJson(var json) {
    id = json["id"];
    notes = json['notes'];
    directions = json['directions'];
    preparationTime = json['preparation_time'];
    photo = json['photo'];
    photoName = json['photoName'];
    ingredients = json['ingredients'];
    cookingTime = json['cooking_time'];
    title = json['title'];
    isFavorite = json['is_favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notes'] = notes;
    data['id'] = id;
    data['directions'] = directions;
    data['preparation_time'] = preparationTime;
    data['photo'] = photo;
    data['photoName'] = photoName;
    data['ingredients'] = ingredients;
    data['cooking_time'] = cookingTime;
    data['title'] = title;
    data['is_favorite'] = isFavorite;
    return data;
  }
}
