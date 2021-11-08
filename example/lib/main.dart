import 'package:flutter/material.dart';

//import 'package:flutter_vgs/flutter_vgs.dart';
import 'package:flutter_vgs/widgets/vgs_text_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const VAULT_ID = "tntsgokx54b";
    const DJAMO_VGS_PATH = "/post";
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('FLUTTER VGS'),
        ),
        body: Center(
            child: Column(children: [
          SizedBox(
              width: 180,
              height: 20,
              child: VgsTextView(
                key: Key("card_number"),
                id: "card_number",
                token: "tok_sandbox_uTsYqMdZbjd8xgeSAivQxg",
                vaultId: VAULT_ID,
                path: DJAMO_VGS_PATH,
              )),
          SizedBox(
              width: 180,
              height: 50,
              child: InkWell(
                onTap: () {
                  VgsTextView.copyContent(id: "card_number");
                },
                child: Icon(Icons.copy_all_outlined),
              ))
        ])),
      ),
    );
  }
}
