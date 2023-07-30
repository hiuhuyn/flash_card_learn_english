class Language {
  String title;
  String key;
  Language({required this.title, required this.key});
}

List<Language> getLanguages = [
  Language(key: "en", title: "English"),
  Language(key: "vi", title: "Việt Nam"),
];
