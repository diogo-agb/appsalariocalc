import 'package:flutter_modular/flutter_modular.dart';
import 'package:salariocalc/app/modules/home/home_store.dart';

import 'resultado_page.dart';
import 'resultado_store.dart';

class ResultadoModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ResultadoStore()),
    Bind.lazySingleton((i) => HomeStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => ResultadoPage()),
  ];
}
