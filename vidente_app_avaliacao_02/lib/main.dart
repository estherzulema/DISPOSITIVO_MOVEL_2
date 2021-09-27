import 'package:flutter/material.dart';
import 'package:vidente_app_avaliacao_02/controllers/cidade_controller.dart';
import 'package:vidente_app_avaliacao_02/widgets/vidente_app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

Future main() async {
  await DotEnv.load(fileName: '.env');
  await CidadeController.instancia.inicializarDB();
  await CidadeController.instancia.inicializarCidade();
  runApp(VidenteApp());
}
