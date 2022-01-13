import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static const platform = MethodChannel('floating_button');

  int count = 0;

  @override
  void initState() {
    super.initState();

    platform.setMethodCallHandler((methodCall) {
      if( methodCall.method == "cliqueBotao"){
        setState(() {
          count += 1;
        });
      }

      return Future<void>(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Floating Button'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('$count', textAlign: TextAlign.center, style: const TextStyle(fontSize: 50),),
            ElevatedButton(
              child: const Text('Criar Botão'),
              onPressed: _criarBotao,
            ),
            ElevatedButton(
              child: const Text('Mostrar'),
              onPressed: _mostrarBotao,
            ),
            ElevatedButton(
              child: const Text('Ocultar'),
              onPressed: _ocultarBotao,
            ),
            ElevatedButton(
              child: const Text('isShowing'),
              onPressed: _isShowing,
            ),
          ],
        ),
      ),
    );
  }

  void _criarBotao() {
    platform.invokeMethod('criarBotao');
  }

  void _mostrarBotao() {
    platform.invokeMethod('mostrarBotao');
  }

  void _ocultarBotao() {
    platform.invokeMethod('ocultarBotao');
  }

  void _isShowing() {
    platform.invokeMethod("isShowing").then((isShowing){
      print(isShowing);
    });
  }
}
