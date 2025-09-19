import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final TextEditingController dinheiroGanhoController = TextEditingController();
  final TextEditingController pactoController = TextEditingController();

  String _infoDados = 'Informe seus dados';

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _limparDados() {
    dinheiroGanhoController.clear();
    pactoController.clear();
    setState(() {
      _infoDados = 'Informe seus dados';
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
        final pactoString = pactoController.text.replaceAll(',', '.');

        //Dízimo
        double renda = double.parse(dinheiroGanhoString);
        double dizimo = renda / 10;

        //Oferta
        double porcentagemPacto = double.parse(pactoString);
        double pacto = renda / porcentagemPacto;

        _infoDados =
            'Seu Dízimo: R\$ ${dizimo.toStringAsFixed(2)} \n Sua oferta: R\$ ${pacto.toStringAsFixed(2)}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF153862),
        title: Text(
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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Dinheiro ganho',
                      labelStyle: TextStyle(
                        color: Color(0xFF153862),
                        fontSize: 17,
                      ),
                      prefixText: 'R\$ ',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    controller: dinheiroGanhoController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o dinheiro ganho';
                      }
                      if (double.tryParse(value.replaceAll(',', '.')) == null) {
                        return 'Número inválido';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Porcentagem do pacto',
                      labelStyle: TextStyle(
                        color: Color(0xFF153862),
                        fontSize: 17,
                      ),
                      suffixText: '%',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    controller: pactoController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe a porcentagem';
                      }
                      if (double.tryParse(value.replaceAll(',', '.')) == null) {
                        return 'Número inválido';
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
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: _limparDados,
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
                  Text(
                    _infoDados,
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
