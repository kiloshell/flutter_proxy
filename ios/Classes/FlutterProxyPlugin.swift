import Flutter
import UIKit

public class FlutterProxyPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_proxy", binaryMessenger: registrar.messenger())
    let instance = FlutterProxyPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "getProxy":
      result(getProxy())
    default:
      result(FlutterMethodNotImplemented)
    }
  }
  
  func getProxy() -> String? {
    var proxyDict: NSDictionary?
    var host: String?
    var port: Int?
    // 获取系统代理设置
    proxyDict = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? NSDictionary
    // 提取HTTP代理信息
    if let proxies = proxyDict?[kCFNetworkProxiesHTTPProxy] as? String {
        host = proxies
    }
    if let portNumber = proxyDict?[kCFNetworkProxiesHTTPPort] as? Int {
        port = portNumber
    }
    if host != nil && port != nil {
      return "\(host!):\(port!)"
    }
    return nil
  }
}
