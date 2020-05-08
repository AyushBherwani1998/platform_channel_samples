#import "CounterNativePlugin.h"
#if __has_include(<counter_native/counter_native-Swift.h>)
#import <counter_native/counter_native-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "counter_native-Swift.h"
#endif

@implementation CounterNativePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCounterNativePlugin registerWithRegistrar:registrar];
}
@end
