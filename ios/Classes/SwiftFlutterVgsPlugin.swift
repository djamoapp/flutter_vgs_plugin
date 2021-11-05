import Flutter
import UIKit

public class SwiftFlutterVgsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
     let factory = CardShowViewFactory(messenger: registrar.messenger())
        registrar.register(factory, withId: "com.djamo.flutter_vgs/textview")
  /*   let channel = FlutterMethodChannel(name: "flutter_vgs", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterVgsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel) */
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
