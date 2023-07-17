import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Barcode Scanner Listener TEST')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const BarcodeKeyBoardListenerPage()));
                },
                child: const Text("BarcodeKeyBoardListenerPage")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RawKeyboardListenerPage()));
                },
                child: const Text("RawKeyboardListenerPage")),
          ],
        ),
      ),
    );
  }
}

class BarcodeKeyBoardListenerPage extends StatefulWidget {
  const BarcodeKeyBoardListenerPage({super.key});

  @override
  State<BarcodeKeyBoardListenerPage> createState() => _BarcodeKeyBoardListenerPageState();
}

class _BarcodeKeyBoardListenerPageState extends State<BarcodeKeyBoardListenerPage> {
  late String barcode = "";

  @override
  Widget build(BuildContext context) {
    return BarcodeKeyboardListener(
      bufferDuration: const Duration(milliseconds: 200),
      onBarcodeScanned: (_barcode) {
        setState(() {
          barcode = _barcode;
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("BarcodeKeyboardListener"),
        ),
        body: Center(
          child: Text(
            barcode.isNotEmpty ? barcode : "Sin Data",
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ),
    );
  }
}

class RawKeyboardListenerPage extends StatefulWidget {
  const RawKeyboardListenerPage({super.key});

  @override
  State<RawKeyboardListenerPage> createState() => _RawKeyboardListenerPageState();
}

class _RawKeyboardListenerPageState extends State<RawKeyboardListenerPage> {
  late String barcode = "";

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
        autofocus: true,
        focusNode: FocusNode(),
        onKey: (event) {
          if (event is RawKeyDownEvent) {
            //Down Key
            if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
              //Refresh
              setState(() {});
            } else {
              barcode = barcode + event.logicalKey.keyLabel;
            }
          } else {
            //Up Key
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("RawKeyboardListener"),
          ),
          body: Center(
            child: Text(
              barcode.isNotEmpty ? barcode : "Sin Data",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ));
  }
}
