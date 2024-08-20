class Category {
  int? id;
  String? name;

  Category({
    this.id,
    this.name,
  });

  static mapToCategory(map) {
    Category newCategory = Category();
    newCategory.id = map['id'];
    newCategory.name = map['name'];
    return newCategory;
  }

  static categoryToMap(item) {
    var mapping = <String, dynamic>{};
    mapping['id'] = item.id;
    mapping['name'] = item.name;
    return mapping;
  }
}
