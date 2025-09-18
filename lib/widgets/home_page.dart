import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  TextEditingController dinheiroGanhoController = TextEditingController();
  TextEditingController seuPactoController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoValores = 'Informe os dados';

  void _limparTudo() {
    dinheiroGanhoController.clear();
    seuPactoController.clear();
    setState(() {
      _infoValores = 'Informe os dados';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcular() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        final dinheiroGanhoString = dinheiroGanhoController.text.replaceAll(
          ',',
          '.',
        );
        final seuPactoString = seuPactoController.text.replaceAll(',', '.');

        //Dízimo
        double renda = double.parse(dinheiroGanhoString);
        double dizimo = renda * 0.10;

        //Pacto
        double porcentagemPacto = double.parse(seuPactoString);
        double pacto = renda * (porcentagemPacto / 100.0);

        _infoValores =
            'Seu dízimo: R\$ ${dizimo.toStringAsFixed(2)}\n Seu pacto: R\$ ${pacto.toStringAsFixed(2)}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF153862),
        title: const Text(
          'Calculadora de Dízimo e Oferta',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                //Dinheiro ganho
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Digite quanto você ganhou',
                    labelStyle: TextStyle(color: Color(0xFF153862)),
                    border: OutlineInputBorder(),
                    prefixText: 'R\$ ',
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: dinheiroGanhoController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    if (double.tryParse(value.replaceAll(',', '.')) == null) {
                      return 'Valor inválido';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16), //Espaçamento de 16px de altura
                //Seu pacto
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Porcentagem do pacto',
                    labelStyle: TextStyle(color: Color(0xFF153862)),
                    suffixText: '%',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: seuPactoController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    if (double.tryParse(value.replaceAll(',', '.')) == null) {
                      return 'Valor inválido';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _calcular,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF153862),
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Calcular',
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                    ),

                    SizedBox(width: 16),

                    ElevatedButton(
                      onPressed: _limparTudo,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF153862),
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Limpar tudo',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(_infoValores, style: TextStyle(fontSize: 17)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
