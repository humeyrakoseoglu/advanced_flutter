import 'package:flutter/material.dart';

import 'app/app.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);


  //burada singleton örneğini kullanarak app state'i değişkeni güncellendi
  void updateAppState(){
    MyApp.instance.appState = 10;
  }

  void getAppState(){
    print(MyApp.instance.appState); //10  eğer yeni bir test2 dosyası oluşturursan ve appState değerini yazdırırsak her seferinde 10 olacaktır. Çünkü yalnızca tek bir uygulama sınıfı örneğimiz var. ve tek bu değişkeni içerir onu da zaten test.dart'ta güncelledik.
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
