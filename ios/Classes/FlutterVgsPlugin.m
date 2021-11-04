#import "FlutterVgsPlugin.h"
#if __has_include(<flutter_vgs/flutter_vgs-Swift.h>)
#import <flutter_vgs/flutter_vgs-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_vgs-Swift.h"
#endif

@implementation FlutterVgsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterVgsPlugin registerWithRegistrar:registrar];
}
@end
