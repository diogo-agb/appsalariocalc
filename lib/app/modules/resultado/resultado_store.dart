import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mobx/mobx.dart';

part 'resultado_store.g.dart';

class ResultadoStore = _ResultadoStoreBase with _$ResultadoStore;

abstract class _ResultadoStoreBase with Store {
  TextEditingController nomeController = TextEditingController();
  TextEditingController valorHoraController = TextEditingController();
  TextEditingController qtdDiasController = TextEditingController();
  TextEditingController qtdHoraPorDiaController = TextEditingController();

  BannerAd ad;

  @observable
  int value = 0;

  @observable
  bool isLoaded;

  @action
  setIsLoaded(bool value) {
    isLoaded = value;
  }

  Widget checkForAd() {
    if (isLoaded == true) {
      return Container(
        child: AdWidget(
          ad: ad,
        ),
        width: ad.size.width.toDouble(),
        height: ad.size.height.toDouble(),
        alignment: Alignment.center,
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  @action
  void increment() {
    value++;
  }
}
