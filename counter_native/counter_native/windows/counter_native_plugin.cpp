#include "counter_native_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <map>
#include <memory>
#include <sstream>

namespace {

class CounterNativePlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  CounterNativePlugin();

  virtual ~CounterNativePlugin();

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

// static
void CounterNativePlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "counter_native",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<CounterNativePlugin>();

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

CounterNativePlugin::CounterNativePlugin() {}

CounterNativePlugin::~CounterNativePlugin() {}

void CounterNativePlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {

  if (method_call.method_name().compare("increment") == 0) {
    if(method_call.arguments()->IsMap()){
      const flutter::EncodableMap &args = method_call.arguments()->MapValue();
      const int &value = args.find(flutter::EncodableValue("count"))->second.IntValue();
      const int &temp =  value + 1;
      flutter::EncodableValue response(temp);
      result->Success(&response);
    }else{
      result->Error("Bad Arguments","Map Expected");
    }
  } else {
    result->NotImplemented();
  }
}

}  // namespace

void CounterNativePluginRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  CounterNativePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
