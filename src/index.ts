import { Platform } from 'react-native';
import NativeRNHideHomeIndicator from './NativeRNHideHomeIndicator';

/**
 * Hide the iOS home indicator (horizontal bar at bottom of screen).
 * Only works on iOS devices with home indicator (iPhone X and newer).
 */
export function hideHomeIndicator(): void {
  if (Platform.OS !== 'ios') {
    return;
  }
  NativeRNHideHomeIndicator?.hide();
}

/**
 * Show the iOS home indicator.
 */
export function showHomeIndicator(): void {
  if (Platform.OS !== 'ios') {
    return;
  }
  NativeRNHideHomeIndicator?.show();
}

/**
 * Set home indicator visibility.
 * @param hidden - true to hide, false to show
 */
export function setHomeIndicatorHidden(hidden: boolean): void {
  if (Platform.OS !== 'ios') {
    return;
  }

  if (hidden) {
    NativeRNHideHomeIndicator?.hide();
  } else {
    NativeRNHideHomeIndicator?.show();
  }
}
