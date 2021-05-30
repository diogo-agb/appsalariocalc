import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final formKey = GlobalKey<FormState>();
  TextEditingController nomeController = TextEditingController();
  TextEditingController valorHoraController = TextEditingController();
  TextEditingController qtdDiasController = TextEditingController();
  TextEditingController qtdHoraPorDiaController = TextEditingController();
  TextEditingController valPensaoController = TextEditingController();
  TextEditingController valPlanoSaudeController = TextEditingController();
  TextEditingController valOutrosDescController = TextEditingController();
  TextEditingController numDependentesController = TextEditingController();

  BannerAd ad;

  @observable
  int counter = 0;

  @observable
  bool isLoaded;

  //Calculado
  double salarioBruto;
  double valorInss;
  double baseCalculoIRRF;
  double aliquota;
  double deducao;
  double irrf;
  double valorIRRF;
  double totalDescontos;
  double valorSalarioLiquido;

  //Formulário
  double qtdDiasTrabalhados;
  double qtdHorasTrabalhadas;
  double valHoraTrabalhada;
  double valPensao;
  double valPlanoSaude;
  double valOutros;
  double numDependentes;
  double valorSalarioBruto;

  void setarValores() {
    valPensao = valPensaoController.text != ''
        ? double.parse(valPensaoController.text
            .replaceAll('BRL', '')
            .replaceAll('.', '')
            .replaceAll(',', '.'))
        : 0.00;

    valPlanoSaude = valPlanoSaudeController.text != ''
        ? double.parse(valPlanoSaudeController.text
            .replaceAll('BRL', '')
            .replaceAll('.', '')
            .replaceAll(',', '.'))
        : 0.00;

    valOutros = valOutrosDescController.text != ''
        ? double.parse(valOutrosDescController.text
            .replaceAll('BRL', '')
            .replaceAll('.', '')
            .replaceAll(',', '.'))
        : 0.00;

    valHoraTrabalhada = valorHoraController.text != ''
        ? double.parse(valorHoraController.text
            .replaceAll('BRL', '')
            .replaceAll('.', '')
            .replaceAll(',', '.'))
        : 0.00;

    qtdHorasTrabalhadas = qtdHoraPorDiaController.text != ''
        ? double.parse(qtdHoraPorDiaController.text)
        : 0;

    qtdDiasTrabalhados =
        qtdDiasController.text != '' ? double.parse(qtdDiasController.text) : 0;

    numDependentes = numDependentesController.text != ''
        ? double.parse(numDependentesController.text)
        : 0;

    salarioBruto =
        qtdDiasTrabalhados * (valHoraTrabalhada * qtdHorasTrabalhadas);

    valorInss = getValorInss(salarioBruto);

    baseCalculoIRRF =
        salarioBruto - valorInss - valPensao - (numDependentes * 189.59);

    valorIRRF = getValorIRRF(baseCalculoIRRF);

    totalDescontos =
        valorInss + valorIRRF + valPensao + valPlanoSaude + valOutros;

    valorSalarioLiquido = salarioBruto - totalDescontos;

    //   valor hora trabalhada = 1,00
    //   qtd horas do dia = 8
    //   qtd dias tarbalhados

    // INSS = calculado sobre o salario bruto
  }

  double getValorIRRF(double baseCalculoIRRF) {
    if (baseCalculoIRRF <= 1903.98) {
      aliquota = 0;
      deducao = 0;
      irrf = (baseCalculoIRRF * aliquota) - deducao;
      return irrf < 0 ? 0 : irrf;
    } else if (baseCalculoIRRF >= 1903.99 && baseCalculoIRRF <= 2826.65) {
      aliquota = 0.075;
      deducao = 142.80;
      irrf = (baseCalculoIRRF * aliquota) - deducao;
      return irrf < 0 ? 0 : irrf;
    } else if (baseCalculoIRRF >= 2826.66 && baseCalculoIRRF <= 3751.05) {
      aliquota = 0.15;
      deducao = 354.80;
      irrf = (baseCalculoIRRF * aliquota) - deducao;
      return irrf < 0 ? 0 : irrf;
    } else if (baseCalculoIRRF >= 3751.06 && baseCalculoIRRF <= 4664.68) {
      aliquota = 0.225;
      deducao = 636.13;
      irrf = (baseCalculoIRRF * aliquota) - deducao;
      return irrf < 0 ? 0 : irrf;
    } else {
      aliquota = 0.275;
      deducao = 869.36;
      irrf = (baseCalculoIRRF * aliquota) - deducao;
      return irrf < 0 ? 0 : irrf;
    }
  }

  double getValorInss(double salarioBruto) {
    if (salarioBruto <= 1100.00) {
      return salarioBruto * 0.075;
    } else if (salarioBruto >= 1100.01 && salarioBruto <= 2202.48) {
      return salarioBruto * 0.09;
    } else if (salarioBruto >= 2203.49 && salarioBruto <= 3305.22) {
      return salarioBruto * 0.12;
    } else if (salarioBruto >= 3305.23 && salarioBruto <= 6433.57) {
      return salarioBruto * 0.14;
    } else {
      return 751.99;
    }
  }

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

  void limpar() {
    nomeController.text = '';
    valorHoraController.text = '';
    qtdDiasController.text = '';
    qtdHoraPorDiaController.text = '';
    valPensaoController.text = '';
    valPlanoSaudeController.text = '';
    valOutrosDescController.text = '';
    numDependentesController.text = '';
  }

  String validador(String value) {
    if (value == null || value.isEmpty) {
      return 'Preencha este campo';
    }
    return null;
  }

  void validarForm(BuildContext context) {
    if (formKey.currentState.validate()) {
      setarValores();
      Modular.to.pushNamed('/resultado');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Verifique os campos obrigatórios'),
        ),
      );
    }
  }

  TextFormField input({
    TextEditingController controller,
    String hintText,
    List<TextInputFormatter> inputFormatters,
    bool enabled,
    String labelText,
    TextInputType keyboardType,
    String Function(String) validator,
  }) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      inputFormatters: inputFormatters,
      enabled: enabled,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
      ),
      validator: validator,
    );
  }

  Future<void> increment() async {
    counter = counter + 1;
  }
}
