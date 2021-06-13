import UIKit
import Flutter
import MSAL

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        guard #available(iOS 13, *) else {
            
            let controller: FlutterViewController = (window?.rootViewController as? FlutterViewController)!
            let ms_graphChannel = FlutterMethodChannel(name: "ms_graph", binaryMessenger: controller.binaryMessenger)
            ms_graphChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
                switch call.method {
                case "getInterActiveToken":
                    FlutterChannelManager.shared.requestSignIn(parentView: controller, result: result)
                case "getSilentToken":
                    FlutterChannelManager.shared.receiveToken(parentView: controller, result: result)
                case "getMe":
                    FlutterChannelManager.shared.getMyAccountData(parentView: controller, result: result)
                case "logout":
                    FlutterChannelManager.shared.logout(result: result)
                case "getEvents":
                    FlutterChannelManager.shared.getEvents(parentView: controller, result: result)
                case "getEmails":
                    FlutterChannelManager.shared.getMessages(parentView: controller, result: result)
                case "getContacts":
                    FlutterChannelManager.shared.getContacts(parentView: controller, result: result)
                default:
                    result(FlutterMethodNotImplemented)
                }
            }
            return true
        }
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    
    // <HandleMsalResponseSnippet>
    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        guard let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String else {
            return false
        }
        
        return MSALPublicClientApplication.handleMSALResponse(url, sourceApplication: sourceApplication)
    }
    // </HandleMsalResponseSnippet>
}
