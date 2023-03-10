import 'dart:async';

import 'package:advanced_flutter/domain/model.dart';
import 'package:advanced_flutter/presentation/base/baseviewmodel.dart';
import 'package:advanced_flutter/presentation/resources/assets_manager.dart';

import '../resources/string_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  //stream controllers: view'den göndermemiz gereken tüm bilgileri içerir.  Burada model bölümünden verileri alıp, view dosyasına gönderir ardından view bölümünden de verileri listeledikten sonrasında kullanıcıya view dosyası şeklinde sunulur
  final StreamController _streamController =
  StreamController<SliderViewObject>();

  //verileri içeren liste yaz
  late final List<SliderObject> _list;

  //mevcut indexi tutalım listedeki nesneler için
  int _currentIndex = 0;

  // inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    // send this slider data to our view
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = _currentIndex++; // +1
    if (nextIndex >= _list.length) {
      _currentIndex = 0; // infinite loop to go to first item inside the slider
    }
    return _currentIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = _currentIndex--; // -1
    if (previousIndex == -1) {
      _currentIndex =
          _list.length - 1; // infinite loop to go to the length of slider list
    }
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView(); //kontrolleri yaptıktan sonra veriyi çekmek istiyoruz
  }

  //inputs
  @override
  Sink get inputSliderViewObject => _streamController.sink;

  // outputs
  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((slideViewObject) => slideViewObject);

  // private functions
  List<SliderObject> _getSliderData() => [
    SliderObject(AppStrings.onBoardingTitle1,
        AppStrings.onBoardingSubTitle1, ImageAssets.onBoardingLogo1),
    SliderObject(AppStrings.onBoardingTitle2,
        AppStrings.onBoardingSubTitle2, ImageAssets.onBoardingLogo2),
    SliderObject(AppStrings.onBoardingTitle3,
        AppStrings.onBoardingSubTitle3, ImageAssets.onBoardingLogo3),
    SliderObject(AppStrings.onBoardingTitle4,
        AppStrings.onBoardingSubTitle4, ImageAssets.onBoardingLogo4)
  ];

  _postDataToView() {
    //SlideViewObject(sliderObject,numOfSlides, currentIndex)
    inputSliderViewObject.add(
        SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

// inputs mean the orders that our view model will recieve from our view
abstract class OnBoardingViewModelInputs {
  void goNext(); // when user clicks on right arrow or swipe left.
  void goPrevious(); // when user clicks on left arrow or swipe right.
  void onPageChanged(int index);

  Sink
  get inputSliderViewObject; // this is the way to add data to the stream .. stream input
}

// outputs mean data or results that will be sent from our view model to our view
abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}
