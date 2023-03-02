class Category{
  String nameAr;
  String nameEn;
  String image;
  int id;
  List<SubCategories> subCategories;
  Category({required this.image,required this.nameEn,required this.id,required this.nameAr,required this.subCategories});
}

class SubCategories{
  String nameAr;
  String nameEn;
  String image;
  int id;
  SubCategories({required this.image,required this.nameEn,required this.id,required this.nameAr});
}

List<Category> categories = [];
List<SubCategories> sub = [];
List<SubCategories> allSub = [];
Future setCat(List _cat)async{
  categories = [];
  allSub.clear();
  _cat.forEach((e) {
    List<SubCategories> _subCat = [];
    e['sub_categories'].forEach((q){
      _subCat.add(SubCategories(image: e['src']+'/'+e['img'],nameEn: q['name_en'], id: q['id'], nameAr: q['name_ar']));
    });
    allSub.addAll(_subCat);
    categories.add(Category(image: e['src']+'/'+e['img'],nameEn: e['name_en'], id: e['id'], nameAr: e['name_ar'], subCategories: _subCat));
  });
  sub = allSub;
}