# Quick Start - 1 Minute

## 1. Install

```bash
npm install rn-hide-home-indicator
cd ios && pod install
```

## 2. Use It

```typescript
import { hideHomeIndicator, showHomeIndicator } from 'rn-hide-home-indicator';

useEffect(() => {
  hideHomeIndicator();
  return () => showHomeIndicator();
}, []);
```

## 3. Rebuild

```bash
yarn ios
```

Done! 🎉

**No additional setup required!** The plugin automatically swizzles `UIViewController` to support home indicator hiding.
