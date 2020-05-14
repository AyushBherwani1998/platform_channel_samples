#include "battery_native_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <map>
#include <memory>
#include <sstream>

namespace {

class BatteryNativePlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  BatteryNativePlugin();

  virtual ~BatteryNativePlugin();

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

// static
void BatteryNativePlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "battery",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<BatteryNativePlugin>();

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

BatteryNativePlugin::BatteryNativePlugin() {}

BatteryNativePlugin::~BatteryNativePlugin() {}

void BatteryNativePlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  // Replace "getPlatformVersion" check with your plugin's method.
  // See:
  // https://github.com/flutter/engine/tree/master/shell/platform/common/cpp/client_wrapper/include/flutter
  // and
  // https://github.com/flutter/engine/tree/master/shell/platform/glfw/client_wrapper/include/flutter
  // for the relevant Flutter APIs.
  if (method_call.method_name().compare("getBattery") == 0) {
    SYSTEM_POWER_STATUS spsPwr;
     if( GetSystemPowerStatus(&spsPwr) ) {
       flutter::EncodableValue response(static_cast<double>(spsPwr.BatteryLifePercent));
       result->Success(&response);
    }else{
      result->Error("Something went wrong", "Not able to get battery percentage");
    }
  } else {
    result->NotImplemented();
  }
}

}  // namespace

void BatteryNativePluginRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  BatteryNativePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
