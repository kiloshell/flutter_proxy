
import 'flutter_proxy_platform_interface.dart';

class FlutterProxy {
  Future<String?> getPlatformVersion() {
    return FlutterProxyPlatform.instance.getPlatformVersion();
  }
}
