import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';

import '../gitignore/ad_helper.dart';
import '../home/home_store.dart';
import 'resultado_store.dart';

class ResultadoPage extends StatefulWidget {
  final String title;
  const ResultadoPage({
    Key key,
    this.title = 'Resultado',
  }) : super(key: key);
  @override
  ResultadoPageState createState() => ResultadoPageState();
}

class ResultadoPageState extends State<ResultadoPage> {
  final ResultadoStore store = Modular.get();
  final HomeStore homeStore = Modular.get();

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
        title: Text(widget.title),
        centerTitle: true,
        leading: Container(),
      ),
      body: SingleChildScrollView(
        child: Observer(
          builder: (context) => Padding(
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
                  'Confira os valores à receber',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                Text('(Valores para ${homeStore.nomeController.text})'),
                SizedBox(height: 50),
                Text(
                  'Salário bruto calculado: R\$ ${NumberFormat.currency(locale: 'eu', symbol: '').format(homeStore.salarioBruto)}',
                  style: TextStyle(fontSize: 17),
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
                          'Desconto INSS: R\$ ${NumberFormat.currency(locale: 'eu', symbol: '').format(homeStore.valorInss)}',
                        ),
                        SizedBox(height: 20),
                        Text(
                            'Desconto IRRF: ${NumberFormat.currency(locale: 'eu', symbol: '').format(homeStore.valorIRRF)}'),
                        SizedBox(height: 20),
                        Text(
                          'Desconto pensão alimentícia: R\$ ${NumberFormat.currency(locale: 'eu', symbol: '').format(homeStore.valPensao)}',
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Desconto plano de saúde: R\$ ${NumberFormat.currency(locale: 'eu', symbol: '').format(homeStore.valPlanoSaude)}',
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Outros descontos: R\$ ${NumberFormat.currency(locale: 'eu', symbol: '').format(homeStore.valOutros)}',
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Total de descontos: R\$ ${NumberFormat.currency(locale: 'eu', symbol: '').format(homeStore.totalDescontos)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Salário líquido: R\$ ${NumberFormat.currency(locale: 'eu', symbol: '').format(homeStore.valorSalarioLiquido)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    Modular.to.pop();
                  },
                  child: Text('Editar dados'),
                ),
                ElevatedButton(
                  onPressed: () {
                    homeStore.limpar();
                    Modular.to.pop();
                  },
                  child: Text('Começar do zero'),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    store.checkForAd(),
                  ],
                ),
                SizedBox(height: 150),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
