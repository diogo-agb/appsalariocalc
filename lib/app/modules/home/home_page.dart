import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../services/ad_helper.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  void initState() {
    store.ad = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.largeBanner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          store.setIsLoaded(true);
        },
        onAdFailedToLoad: (_, error) {
          print("Falha ao carregar o Ad erro: $error");
        },
      ),
    );
    store.ad.load();
    super.initState();
  }

  @override
  void dispose() {
    store.ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SalarioCalc APP'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Observer(
          builder: (context) => Form(
            key: store.formKey,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 30,
                left: 30,
                right: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Informe os dados a seguir para calcular o valor à receber, campos com (*) são obrigatórios',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  store.input(
                    controller: store.nomeController,
                    labelText: '*Seu nome',
                    validator: (value) {
                      return store.validador(value);
                    },
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(
                            'Preencha estes campos para calcular o seu salário bruto.',
                            textAlign: TextAlign.center,
                          ),
                          store.input(
                            controller: store.valorHoraController,
                            labelText: '*Valor da hora trabalhada',
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              return store.validador(value);
                            },
                            inputFormatters: [
                              CurrencyTextInputFormatter(
                                locale: 'pt_BR',
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          store.input(
                            controller: store.qtdHoraPorDiaController,
                            labelText: '*Quantidade de horas por dia',
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            validator: (value) {
                              return store.validador(value);
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                          SizedBox(height: 20),
                          store.input(
                            controller: store.qtdDiasController,
                            labelText: '*Quantidade de dias trabalhados',
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              return store.validador(value);
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Text(
                    'Campos opcionais',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  store.input(
                    controller: store.numDependentesController,
                    labelText: 'Número de dependentes',
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  SizedBox(height: 20),
                  store.input(
                    controller: store.valPensaoController,
                    labelText: 'Valor da pensão alimentícia',
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      CurrencyTextInputFormatter(
                        locale: 'pt_BR',
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  store.input(
                    controller: store.valPlanoSaudeController,
                    labelText: 'Valor do plano de saúde',
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      CurrencyTextInputFormatter(
                        locale: 'pt_BR',
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  store.input(
                    controller: store.valOutrosDescController,
                    hintText: 'Valor de outros descontos',
                    labelText: 'Valor de outros descontos',
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      CurrencyTextInputFormatter(
                        locale: 'pt_BR',
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      store.validarForm(context);
                    },
                    child: Text('Calcular valor à receber'),
                  ),
                  SizedBox(height: 20),
                  store.checkForAd(),
                  SizedBox(height: 150),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
