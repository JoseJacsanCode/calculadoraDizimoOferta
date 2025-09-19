import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  TextEditingController dinheiroGanhoController = TextEditingController();
  TextEditingController pactoController = TextEditingController();

  GlobalKey<FormState> _chaveForm = GlobalKey<FormState>();

  String _infoDados = 'Preencha os campos acima';

  void _limparTudo() {
    dinheiroGanhoController.clear();
    pactoController.clear();
    setState(() {
      _infoDados = 'Preencha os campos acima';
      _chaveForm = GlobalKey<FormState>();
    });
  }

  void _calcular() {
    if (_chaveForm.currentState?.validate() ?? false) {
      setState(() {
        final dinheiroGanhoString = dinheiroGanhoController.text.replaceAll(
          ',',
          '.',
        );
        final pactoString = pactoController.text.replaceAll(',', '.');

        double renda = double.parse(dinheiroGanhoString);
        double dizimo = renda * 0.10;
        double porcentagemPacto = double.parse(pactoString);
        double pacto = renda / porcentagemPacto;

        _infoDados =
            'Seu dízimo: ${dizimo.toStringAsFixed(2)} \n Seu pacto: ${pacto.toStringAsFixed(2)}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: _chaveForm,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
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
                        return 'Digite um valor';
                      }
                      if (double.tryParse(value.replaceAll(',', '.')) == null) {
                        return 'Valor inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
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
                  ),
                  const SizedBox(height: 16),
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
                        child: const Text(
                          'Calcular',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: _limparTudo,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF153862),
                          padding: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Limpar tudo',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _infoDados,
                    style: const TextStyle(color: Colors.black, fontSize: 17),
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
