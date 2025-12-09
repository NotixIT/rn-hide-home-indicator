#import "RNHideHomeIndicator.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation UIViewController (RNHomeIndicatorSwizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(prefersHomeIndicatorAutoHidden);
        SEL swizzledSelector = @selector(rn_prefersHomeIndicatorAutoHidden);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class,
                                           originalSelector,
                                           method_getImplementation(swizzledMethod),
                                           method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                              swizzledSelector,
                              method_getImplementation(originalMethod),
                              method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (BOOL)rn_prefersHomeIndicatorAutoHidden {
    NSNumber *hidden = objc_getAssociatedObject(self, @selector(rn_homeIndicatorHidden));
    if (hidden != nil) {
        return [hidden boolValue];
    }
    
    return [self rn_prefersHomeIndicatorAutoHidden];
}

@end

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
                               @selector(rn_homeIndicatorHidden),
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
