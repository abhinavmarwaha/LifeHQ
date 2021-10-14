enum KnowledgeCat {
  project,
  area,
  reasearch,
  archive,
  fun,
}

extension KnowledgeCatExtensions on KnowledgeCat {
  int toInt() {
    switch (this) {
      case KnowledgeCat.project:
        return 0;
      case KnowledgeCat.area:
        return 1;
      case KnowledgeCat.reasearch:
        return 2;
      case KnowledgeCat.archive:
        return 3;
      case KnowledgeCat.fun:
        return 4;
      default:
        return -1;
    }
  }

  String title() {
    final title = this.toString().split(".")[1];
    return title[0].toUpperCase() + title.substring(1);
  }
}
