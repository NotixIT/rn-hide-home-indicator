# Quick Start - 2 Minutes

## 1. Install

```bash
npm install rn-hide-home-indicator
cd ios && pod install
```

## 2. Add 5 Lines to main.m

Open `ios/YourApp/main.m` and add **at the top**:

```objc
#import <objc/runtime.h>

@implementation UIViewController (HomeIndicator)
- (BOOL)prefersHomeIndicatorAutoHidden {
    NSNumber *hidden = objc_getAssociatedObject(self, @selector(prefersHomeIndicatorAutoHidden));
    return hidden ? [hidden boolValue] : NO;
}
@end
```

## 3. Use It

```typescript
import { hideHomeIndicator, showHomeIndicator } from 'rn-hide-home-indicator';

useEffect(() => {
  hideHomeIndicator();
  return () => showHomeIndicator();
}, []);
```

## 4. Rebuild

```bash
yarn ios
```

Done! 🎉
