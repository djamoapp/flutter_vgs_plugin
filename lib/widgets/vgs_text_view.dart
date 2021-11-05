import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

//typedef void TextViewCreatedCallback(TextViewController controller);

class VgsTextView extends StatefulWidget {
  //final TextViewCreatedCallback? onTextViewCreated;
  final String id;
  final String token;
  final String vaultId;
  final String path;
  final String environment;

  const VgsTextView(
      {Key? key,
      /* this.onTextViewCreated, */ required this.id,
      required this.token,
      required this.vaultId,
      required this.path,
      this.environment = "sandbox"})
      : super(key: key);

  @override
  _VgsTextViewState createState() => _VgsTextViewState();
}

class _VgsTextViewState extends State<VgsTextView> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> creationParams = {
      "id": widget.id,
      "token": widget.token,
      "vaultId": widget.vaultId,
      "path": widget.path,
      "environment": widget.environment
    };
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'com.djamo.flutter_vgs/textview',
        onPlatformViewCreated: (int id) =>
            _onPlatformViewCreated(id, creationParams),
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: 'com.djamo.flutter_vgs/textview',
        layoutDirection: TextDirection.ltr,
        onPlatformViewCreated: (int id) =>
            _onPlatformViewCreated(id, creationParams),
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
    return Text('$defaultTargetPlatform is not yet supported by the plugin');
  }

  void _onPlatformViewCreated(int id, Map<String, dynamic> creationParams) {
    final MethodChannel _channel;
    _channel = new MethodChannel('com.djamo.flutter_vgs/textview_$id');
    _channel.invokeMethod('revealVGSText', creationParams);
    return;
  }
}

/* class TextViewController {
  TextViewController._(int id)
      : _channel = new MethodChannel('com.djamo.flutter_vgs/textview_$id');

  final MethodChannel _channel;

  Future<void> setToken(String? token) async {
    assert(token != null);
    return _channel.invokeMethod('revealVGSText', token);
  }
}
 */