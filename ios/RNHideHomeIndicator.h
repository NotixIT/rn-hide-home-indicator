#ifdef RCT_NEW_ARCH_ENABLED
#import <RNHideHomeIndicatorSpec/RNHideHomeIndicatorSpec.h>

@interface RNHideHomeIndicator : NSObject <NativeRNHideHomeIndicatorSpec>
#else
#import <React/RCTBridgeModule.h>

@interface RNHideHomeIndicator : NSObject <RCTBridgeModule>
#endif

@end
