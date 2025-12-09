# rn-hide-home-indicator

React Native plugin to hide iOS home indicator with Turbo Module support.

## Installation

```bash
npm install rn-hide-home-indicator
cd ios && pod install
```

**That's it!** No additional setup required. The plugin uses method swizzling to automatically work with any view controller.

## Usage

```typescript
import { 
  hideHomeIndicator, 
  showHomeIndicator, 
  setHomeIndicatorHidden 
} from 'rn-hide-home-indicator';

// Hide home indicator
hideHomeIndicator();

// Show home indicator
showHomeIndicator();

// Set based on boolean
setHomeIndicatorHidden(true);  // hide
setHomeIndicatorHidden(false); // show
```

## Examples

### Video Player

```typescript
import React, { useEffect } from 'react';
import { hideHomeIndicator, showHomeIndicator } from 'rn-hide-home-indicator';

function VideoPlayer() {
  useEffect(() => {
    hideHomeIndicator();
    return () => showHomeIndicator();
  }, []);

  return <Video />;
}
```

### Game Screen

```typescript
function GameScreen() {
  useEffect(() => {
    hideHomeIndicator();
    return () => showHomeIndicator();
  }, []);

  return <Game />;
}
```

### Dynamic Hiding

```typescript
const [fullscreen, setFullscreen] = useState(false);

useEffect(() => {
  setHomeIndicatorHidden(fullscreen);
}, [fullscreen]);
```

## API

### `hideHomeIndicator(): void`
Hide the iOS home indicator.

### `showHomeIndicator(): void`
Show the iOS home indicator.

### `setHomeIndicatorHidden(hidden: boolean): void`
Set home indicator visibility based on boolean value.

## Platform Support

- ✅ iOS 11+ (iPhone X and newer)
- ✅ Android (gracefully ignored)

## New Architecture

Plugin automatically supports both old and new React Native architecture (Turbo Modules).

## Troubleshooting

**Home indicator not hiding?**

1. Did you add the category to `main.m` or `AppDelegate.mm`?
2. Did you rebuild the app?
3. Are you on iPhone X or newer?

**Build error?**

```bash
cd ios
rm -rf Pods Podfile.lock
pod install
```

## License

MIT - NOTIX DOO BEOGRAD
