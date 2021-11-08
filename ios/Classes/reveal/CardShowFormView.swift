import Foundation
import Flutter
import UIKit
import VGSShowSDK
class CardShowFormView: NSObject, FlutterPlatformView {
   // private var _view: UIView
    let vgsShow: VGSShow
	let vgsTextView: VGSLabel
 	let messenger: FlutterBinaryMessenger
	let channel: FlutterMethodChannel
	let viewId: Int64
    let args:Any

    init(
        frame: CGRect,
        binaryMessenger messenger: FlutterBinaryMessenger,
        viewIdentifier viewId: Int64,
        arguments args: Any
    ) {
        self.messenger = messenger
        self.viewId = viewId
        self.vgsTextView = VGSLabel()
        self.args = args
        let argData = args as? Dictionary<String, Any>
    
        let env = argData?["environment"] as? String == "live" ? VGSEnvironment.live: VGSEnvironment.sandbox
       
        let fieldKey:String = (argData?["id"] as? String?)! ?? "pan"
        self.vgsShow =  VGSShow(id:argData?["vaultId"] as? String ?? "", environment: env)
        // Set channel
        channel = FlutterMethodChannel(name: "com.djamo.flutter_vgs/textview_\(String(describing: fieldKey))",binaryMessenger: messenger)
        super.init()
       //Convert Dart Map object to Swift Array
        if let argData = args as? Dictionary<String, Any>,
           let fieldId = argData["id"] as? String{
            vgsTextView.contentPath = "\(String(describing: fieldId))"
            vgsTextView.placeholder = "..."
            vgsTextView.translatesAutoresizingMaskIntoConstraints = false
            vgsTextView.widthAnchor.constraint(equalToConstant: 250).isActive = true
            if(fieldId == "pan"){
                do {
                            let cardNumberPattern = "(\\d{4})(\\d{4})(\\d{4})(\\d{4})"
                            let template = "$1 $2 $3 $4"
                            let regex = try NSRegularExpression(pattern: cardNumberPattern, options: [])

                            // Add transformation regex to your label.
                    vgsTextView.addTransformationRegex(regex, template: template)
                        } catch {
                            assertionFailure("invalid regex, error: \(error)")
                        }
            }
            //Set UI
            vgsTextView.font = UIFont.systemFont(ofSize: 14)
            vgsTextView.placeholderStyle.color = .black
            vgsTextView.placeholderStyle.textAlignment = .left
            vgsTextView.textAlignment = .left
            vgsTextView.borderWidth = (0)
            //VGS subscribe
         
            vgsShow.subscribe(vgsTextView)
         
        }
    //Method call
        channel.setMethodCallHandler({ (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            switch call.method {
            case "revealVGSText":
                self.revealVGSText(with: call, result: result)
            case "copyVGSText":
                self.copyVGSText(with: call, result: result)
            default:
                    result(FlutterMethodNotImplemented)
            }
        })
    }

    func view() -> UIView {
        return vgsTextView
    }

    private func copyVGSText(with flutterMethodCall: FlutterMethodCall, result: @escaping FlutterResult)  {
        do {
         vgsTextView.copyTextToClipboard()
            return result(true)
            } catch {
                return result(false)
            }
   }
    private func revealVGSText(with flutterMethodCall: FlutterMethodCall, result: @escaping FlutterResult)  {
        var errorInfo: [String : Any] = [:]
        var payload: [String : Any] = [:]
        var otherPath: [String : Any] = [:]
        if let args = flutterMethodCall.arguments as? Dictionary<String, Any>,
           let fieldId = args["id"] as? String, let path = args["path"] as? String, let fieldToken = args["token"] as? String{
            payload = ["\(fieldId)":fieldToken]
            otherPath = ["path":path]
        }
       else {
                   errorInfo["show_error_code"] = 999
                   errorInfo["show_error_message"] = "No payload to reveal."
                   result(errorInfo)
                   return
               }
        vgsShow.request(path:otherPath["path"] as! String,
                                                method: .post, payload: payload) { (requestResult) in

                    switch requestResult {
                    case .success(let code):
                        var successInfo: [String : Any] = [:]
                        successInfo["show_status_code"] = code
                        //print("vgsshow success, code: \(code)")
                        result(successInfo)
                    case .failure(let code, let error):
                       // print("vgsshow failed, code: \(code), error: \(String(describing: error))")
                        errorInfo["show_error_code"] = code
                        if let message = error?.localizedDescription {
                            errorInfo["show_error_message"] = message
                        }

                        result(errorInfo)
                    }
        }
    }
}
