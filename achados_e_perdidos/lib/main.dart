import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Achados e Perdidos',
      debugShowCheckedModeBanner: false,
      // CONFIGURAÇÃO WHITE MODE
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white, // Fundo totalmente branco
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue, // Cor base para os componentes
          brightness: Brightness.light,
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black, // Texto da AppBar em preto
          elevation: 0,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.shade200,
            height: 1.0,
          ), // Linha sutil abaixo da AppBar
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Itens registrados no sistema:',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            Text(
              '$_counter',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 30),

            // COMPONENTE GETWIDGET EM WHITE MODE
            GFButton(
              onPressed: _incrementCounter,
              text: "ADICIONAR ITEM",
              shape: GFButtonShape.pills,
              type: GFButtonType.solid,
              color: GFColors.PRIMARY, // Azul padrão
              size: GFSize.LARGE,
              fullWidthButton: false,
            ),
          ],
        ),
      ),
    );
  }
}
