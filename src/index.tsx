import {
  requireNativeComponent,
  UIManager,
  Platform,
  View,
} from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-live-text-image-view' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';

type LiveTextImageViewProps = {
  children: React.ReactNode;
};

const ComponentName = 'LiveTextImageViewView';

export const LiveTextImageView =
  Platform.OS === 'ios'
    ? UIManager.getViewManagerConfig(ComponentName) != null
      ? requireNativeComponent<LiveTextImageViewProps>(ComponentName)
      : () => {
          throw new Error(LINKING_ERROR);
        }
    : View;
