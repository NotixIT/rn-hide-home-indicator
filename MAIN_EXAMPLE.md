# Complete main.m Example

Here's how your `ios/YourApp/main.m` file should look with the category added:

```objc
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "AppDelegate.h"

// ADD THIS CATEGORY
@implementation UIViewController (HomeIndicator)

- (BOOL)prefersHomeIndicatorAutoHidden {
    NSNumber *hidden = objc_getAssociatedObject(self, @selector(prefersHomeIndicatorAutoHidden));
    return hidden ? [hidden boolValue] : NO;
}

@end

// Rest of the file stays the same
int main(int argc, char *argv[])
{
  @autoreleasepool {
    return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
  }
}
```

That's it! 5 lines of code and the plugin works. 🎉

## Where is main.m?

```
ios/
  YourApp/
    main.m          <-- Add category here
    AppDelegate.h
    AppDelegate.mm
```

## If You Don't Have main.m (Using AppDelegate.mm)

Add the category to `AppDelegate.mm` at the top after imports:

```objc
#import "AppDelegate.h"
#import <React/RCTBundleURLProvider.h>
#import <objc/runtime.h>  // Add this

// Add this category
@implementation UIViewController (HomeIndicator)

- (BOOL)prefersHomeIndicatorAutoHidden {
    NSNumber *hidden = objc_getAssociatedObject(self, @selector(prefersHomeIndicatorAutoHidden));
    return hidden ? [hidden boolValue] : NO;
}

@end

// Rest of AppDelegate code...
@implementation AppDelegate
// ...
@end
```
