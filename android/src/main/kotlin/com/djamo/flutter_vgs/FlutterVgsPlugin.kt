package com.djamo.flutter_vgs

import androidx.annotation.NonNull

import com.djamo.flutter_vgs.reveal.CardShowViewFactory
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.platform.PlatformView

/** FlutterVgsPlugin */
class FlutterVgsPlugin: FlutterPlugin {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity

  override fun onAttachedToEngine(@NonNull binding: FlutterPluginBinding) {
    binding.platformViewRegistry.registerViewFactory("com.djamo.flutter_vgs/textview", CardShowViewFactory(binding.binaryMessenger))
   // channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_vgs")
    //channel.setMethodCallHandler(this)
  }
    
  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
  }
}
