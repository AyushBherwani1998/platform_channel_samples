#import "BatteryNativePlugin.h"
#if __has_include(<battery_native/battery_native-Swift.h>)
#import <battery_native/battery_native-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "battery_native-Swift.h"
#endif

@implementation BatteryNativePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBatteryNativePlugin registerWithRegistrar:registrar];
}
@end
