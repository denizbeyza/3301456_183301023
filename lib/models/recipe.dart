class Recipe {
  String? notes;
  String? directions;
  int? preparationTime;
  String? photo;
  String? ingredients;
  int? cookingTime;
  String? title;

  Recipe(
      {this.notes,
      this.directions,
      this.preparationTime,
      this.photo,
      this.ingredients,
      this.cookingTime,
      this.title});

  Recipe.fromJson(var json) {
    notes = json['notes'];
    directions = json['directions'];
    preparationTime = json['preparation_time'];
    photo = json['photo'];
    ingredients = json['ingredients'];
    cookingTime = json['cooking_time'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notes'] = notes;
    data['directions'] = directions;
    data['preparation_time'] = preparationTime;
    data['photo'] = photo;
    data['ingredients'] = ingredients;
    data['cooking_time'] = cookingTime;
    data['title'] = title;
    return data;
  }
}
