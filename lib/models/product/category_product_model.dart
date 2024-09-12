class CategoryResponse {
  final List<String> categories;

  CategoryResponse({required this.categories});

  factory CategoryResponse.fromJson(List<dynamic> json) {
    return CategoryResponse(
      categories: json.map((e) => e as String).toList(),
    );
  }
}
