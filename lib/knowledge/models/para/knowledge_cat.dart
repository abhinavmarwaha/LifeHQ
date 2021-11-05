enum KnowledgeCat {
  project,
  area,
  research,
  archive,
  fun,
}

KnowledgeCat KnowledgeCatFromInt(int cat) {
  switch (cat) {
    case 0:
      return KnowledgeCat.project;
    case 1:
      return KnowledgeCat.area;
    case 2:
      return KnowledgeCat.research;
    case 3:
      return KnowledgeCat.archive;
    case 4:
      return KnowledgeCat.fun;
  }
  
  return KnowledgeCat.fun;
}

extension KnowledgeCatExtensions on KnowledgeCat {
  int toInt() {
    switch (this) {
      case KnowledgeCat.project:
        return 0;
      case KnowledgeCat.area:
        return 1;
      case KnowledgeCat.research:
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
