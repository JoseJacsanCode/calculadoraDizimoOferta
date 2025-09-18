import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  TextEditingController dinheiroGanhoController = TextEditingController();
  TextEditingController porcentagemDizimoController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String infoValores = 'Informe os valores';

  void _resetarCampos() {
    dinheiroGanhoController.clear();
    porcentagemDizimoController.clear();
    setState(() {
      infoValores = 'Informe os valores';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcular() {
    setState(() {
      final dinheiroGanhoString = dinheiroGanhoController.text.replaceAll(
        ',',
        '.',
      );
      final porcentagemDizimoString = porcentagemDizimoController.text
          .replaceAll(',', '.');
      double dinheiroGanho = double.parse(dinheiroGanhoString);
      double porcentagemDizimo = double.parse(porcentagemDizimoString);
      double resultado = (dinheiroGanho * porcentagemDizimo) / 100;
      infoValores = 'Dízimo: R\$ ${resultado.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF153862),
          centerTitle: true,
          title: Text(
            'Calculadora de Dízimo e Oferta',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            IconButton(
              onPressed: _resetarCampos,
              icon: Icon(Icons.refresh, size: 30, color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Dinheiro ganho',
                      labelStyle: TextStyle(color: Color(0xFF153862)),
                      prefix: Text('R\$ '),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    controller: dinheiroGanhoController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira o valor ganho';
                      }

                      if (double.tryParse(value.replaceAll(',', '.')) == null) {
                        return 'Insira um valor válido';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Porcentagem do dízimo',
                      labelStyle: TextStyle(color: Color(0xFF153862)),
                      suffix: Text('%'),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    controller: porcentagemDizimoController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Insira a porcentagem'; 
                      }
                    
                      if (double.tryParse(value.replaceAll(',', '.')) == null) {
                        return 'Insira uma porcentagem válida';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calcular();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF153862),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Calcular',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(infoValores),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
