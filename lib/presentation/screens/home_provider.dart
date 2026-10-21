import 'package:flutter/foundation.dart';

class HomeProvider extends ChangeNotifier {
  int selectedCategoryIndex = 0;
  int bannerPage = 0;

  void selectCategory(int index) {
    if (selectedCategoryIndex == index) return;
    selectedCategoryIndex = index;
    notifyListeners();
  }

  void setBannerPage(int page) {
    if (bannerPage == page) return;
    bannerPage = page;
    notifyListeners();
  }
}
