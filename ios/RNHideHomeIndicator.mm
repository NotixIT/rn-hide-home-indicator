#import "RNHideHomeIndicator.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation RNHideHomeIndicator

RCT_EXPORT_MODULE()

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

- (void)setHidden:(BOOL)hidden {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *rootVC = [self getRootViewController];
        if (rootVC == nil) return;
        
        // Store state using associated objects
        objc_setAssociatedObject(rootVC,
                               @selector(prefersHomeIndicatorAutoHidden),
                               @(hidden),
                               OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        if (@available(iOS 11.0, *)) {
            [rootVC setNeedsUpdateOfHomeIndicatorAutoHidden];
        }
    });
}

- (UIViewController *)getRootViewController {
    // iOS 13+ way
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene *scene in UIApplication.sharedApplication.connectedScenes) {
            if (scene.activationState == UISceneActivationStateForegroundActive) {
                UIWindow *window = scene.windows.firstObject;
                if (window.isKeyWindow) {
                    return window.rootViewController;
                }
            }
        }
    }
    
    // Fallback for older versions
    UIWindow *window = UIApplication.sharedApplication.delegate.window;
    return window.rootViewController;
}

#ifdef RCT_NEW_ARCH_ENABLED
// Turbo Module methods
- (void)hide {
    [self setHidden:YES];
}

- (void)show {
    [self setHidden:NO];
}

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params {
    return std::make_shared<facebook::react::NativeRNHideHomeIndicatorSpecJSI>(params);
}
#else
// Legacy Bridge methods
RCT_EXPORT_METHOD(hide) {
    [self setHidden:YES];
}

RCT_EXPORT_METHOD(show) {
    [self setHidden:NO];
}
#endif

@end
