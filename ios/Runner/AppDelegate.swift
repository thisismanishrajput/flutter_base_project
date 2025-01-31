import UIKit
import Flutter
import Firebase
import UserNotifications
import path_provider_foundation



func registerPlugins(registry: FlutterPluginRegistry) -> () {

}

@main
@objc class AppDelegate: FlutterAppDelegate, MessagingDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let flavorChannel = FlutterMethodChannel(name: "flavor_channel",
                                                binaryMessenger: controller.binaryMessenger)
      flavorChannel.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        // This method is invoked on the UI thread.
        guard call.method == "getFlavor" else {
          result(FlutterMethodNotImplemented)
          return
        }
        #if DEV
          result("dev")
        #elseif PROD
          result("prod")
        #endif
      })

       // Using active compilation conditions to provide the right API key for the right flavor.
     #if DEV
         GMSServices.provideAPIKey("")
     #elseif PROD
         GMSServices.provideAPIKey("")
     #endif

    GeneratedPluginRegistrant.register(with: self)
    
//    let center = UNUserNotificationCenter.current()
//    center.delegate = self
//    center.requestAuthorization(options: [.alert, .sound, .badge])
//    { granted, error in
//      debugPrint("Is Granted \(granted)")
//    }
    
//    Messaging.messaging().delegate = self
//    application.registerForRemoteNotifications()

      BackgroundLocatorPlugin.setPluginRegistrantCallback(registerPlugins)
      registerOtherPlugins()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }


  func registerOtherPlugins() {
          if !hasPlugin("io.flutter.plugins.pathprovider") {
              PathProviderPlugin.register(with: registrar(forPlugin: "io.flutter.plugins.pathprovider") as! FlutterPluginRegistrar)
          }
      }

    override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let application = UIApplication.shared
        
        let userInfo = response.notification.request.content.userInfo
        debugPrint(userInfo)
        
        if(application.applicationState == .active){
            debugPrint("App in active state")
        }
        
        if(application.applicationState == .background)
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                debugPrint("App in backgroud state")
            }
        }
        completionHandler()
    }
    
  override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
      debugPrint(error.localizedDescription)
  }
    
  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
    -> Void) {
      let userInfo = notification.request.content.userInfo
        debugPrint("Push notification received in foreground. \(userInfo)")
      completionHandler([.alert, .sound, .badge])
    }
    
 // This is already managed in flutter so no need to handle this here.
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      debugPrint("Firebase registration token: \(String(describing: fcmToken))")
  }
}
