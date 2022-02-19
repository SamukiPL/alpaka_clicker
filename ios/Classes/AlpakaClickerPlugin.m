#import "AlpakaClickerPlugin.h"
#if __has_include(<alpaka_clicker/alpaka_clicker-Swift.h>)
#import <alpaka_clicker/alpaka_clicker-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "alpaka_clicker-Swift.h"
#endif

@implementation AlpakaClickerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAlpakaClickerPlugin registerWithRegistrar:registrar];
}
@end
