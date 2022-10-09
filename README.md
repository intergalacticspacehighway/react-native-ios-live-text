# React Native iOS Live Text Image

Scans text as well as QRCode.


https://user-images.githubusercontent.com/23293248/194712842-bb7f5ab0-7ea4-4b4b-8a55-e17263f8adea.mp4



# Installation

```
// yarn
yarn add react-native-live-text-image-view

// npm
npm install react-native-live-text-image-view

```

```
cd ios/ && pod install
```

Note: Requires iOS 16. Fallbacks to UIView below it.



# API

```jsx
import { LiveTextImageView } from 'react-native-live-text-image-view';

<LiveTextImageView>
  <Image
    source={{
      uri: 'https://images.unsplash.com/photo-1518893494013-481c1d8ed3fd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80',
    }}
    style={{ height, width }}
    resizeMode="contain"
  />
</LiveTextImageView>;
```



# Example

- git clone repo
- cd example
