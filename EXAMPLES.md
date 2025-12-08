# Usage Examples

## Video Player

```typescript
import React, { useEffect } from 'react';
import { View } from 'react-native';
import { hideHomeIndicator, showHomeIndicator } from 'rn-hide-home-indicator';
import Video from 'react-native-video';

function VideoPlayer({ videoUrl }) {
  const [fullscreen, setFullscreen] = React.useState(false);

  useEffect(() => {
    if (fullscreen) {
      hideHomeIndicator();
    } else {
      showHomeIndicator();
    }
  }, [fullscreen]);

  return (
    <Video
      source={{ uri: videoUrl }}
      onFullscreenPlayerWillPresent={() => setFullscreen(true)}
      onFullscreenPlayerWillDismiss={() => setFullscreen(false)}
    />
  );
}
```

## Game Screen

```typescript
import { hideHomeIndicator, showHomeIndicator } from 'rn-hide-home-indicator';

function GameScreen() {
  useEffect(() => {
    // Hide when game starts
    hideHomeIndicator();
    
    // Show when game ends
    return () => {
      showHomeIndicator();
    };
  }, []);

  return <GameCanvas />;
}
```

## Image Gallery

```typescript
import { View, Image, TouchableOpacity } from 'react-native';
import { setHomeIndicatorHidden } from 'rn-hide-home-indicator';

function ImageGallery({ images }) {
  const [fullscreen, setFullscreen] = useState(false);

  const toggle = () => {
    const newState = !fullscreen;
    setFullscreen(newState);
    setHomeIndicatorHidden(newState);
  };

  return (
    <TouchableOpacity onPress={toggle}>
      <Image 
        source={images[0]} 
        style={fullscreen ? { flex: 1 } : { width: 200, height: 200 }}
      />
    </TouchableOpacity>
  );
}
```

## Modal

```typescript
import { Modal } from 'react-native';
import { hideHomeIndicator, showHomeIndicator } from 'rn-hide-home-indicator';

function FullscreenModal({ visible, onClose }) {
  useEffect(() => {
    if (visible) {
      hideHomeIndicator();
    } else {
      showHomeIndicator();
    }
  }, [visible]);

  return (
    <Modal visible={visible} onRequestClose={onClose}>
      {/* content */}
    </Modal>
  );
}
```

## Navigation (React Navigation)

```typescript
import { useNavigationState } from '@react-navigation/native';
import { hideHomeIndicator, showHomeIndicator } from 'rn-hide-home-indicator';

// Screens where you want to hide home indicator
const HIDE_SCREENS = ['VideoPlayer', 'Game', 'Gallery'];

function App() {
  const currentRoute = useNavigationState(state => 
    state?.routes[state.index]?.name
  );

  useEffect(() => {
    if (HIDE_SCREENS.includes(currentRoute)) {
      hideHomeIndicator();
    } else {
      showHomeIndicator();
    }
  }, [currentRoute]);

  return <Navigation />;
}
```

## Presentation / Slideshow

```typescript
function PresentationMode({ slides }) {
  const [isPresenting, setIsPresenting] = useState(false);

  useEffect(() => {
    if (isPresenting) {
      hideHomeIndicator();
    } else {
      showHomeIndicator();
    }
  }, [isPresenting]);

  return (
    <View>
      {isPresenting ? (
        <Slideshow slides={slides} />
      ) : (
        <Button 
          title="Start Presentation" 
          onPress={() => setIsPresenting(true)} 
        />
      )}
    </View>
  );
}
```

## E-book Reader

```typescript
function BookReader({ book }) {
  const [readingMode, setReadingMode] = useState(false);

  useEffect(() => {
    if (readingMode) {
      hideHomeIndicator();
    } else {
      showHomeIndicator();
    }
  }, [readingMode]);

  return (
    <View>
      <Switch 
        value={readingMode}
        onValueChange={setReadingMode}
      />
      <BookContent book={book} />
    </View>
  );
}
```

## Best Practices

### ✅ Always restore home indicator

```typescript
useEffect(() => {
  hideHomeIndicator();
  
  // Cleanup function - IMPORTANT!
  return () => {
    showHomeIndicator();
  };
}, []);
```

### ✅ Use with dependency array

```typescript
const [hide, setHide] = useState(false);

useEffect(() => {
  setHomeIndicatorHidden(hide);
}, [hide]); // Re-run only when hide changes
```

### ❌ Don't forget cleanup

```typescript
// BAD - home indicator stays hidden!
useEffect(() => {
  hideHomeIndicator();
  // Missing return cleanup
}, []);

// GOOD
useEffect(() => {
  hideHomeIndicator();
  return () => showHomeIndicator();
}, []);
```

### ✅ Platform check (if needed)

```typescript
import { Platform } from 'react-native';
import { hideHomeIndicator } from 'rn-hide-home-indicator';

useEffect(() => {
  if (Platform.OS === 'ios') {
    // Plugin automatically ignores Android, but you can do this too
    hideHomeIndicator();
  }
}, []);
```

## Debugging

### Testing if it works

```typescript
import { hideHomeIndicator, showHomeIndicator } from 'rn-hide-home-indicator';

// In component
useEffect(() => {
  console.log('Hiding home indicator...');
  hideHomeIndicator();
  
  setTimeout(() => {
    console.log('Showing home indicator...');
    showHomeIndicator();
  }, 3000);
}, []);
```

Home indicator should disappear for 3 seconds!
