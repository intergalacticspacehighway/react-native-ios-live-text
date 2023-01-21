import * as React from 'react';

import { StyleSheet, View,  Dimensions } from 'react-native';
import { LiveTextImageView } from 'react-native-live-text-image-view';
import { Image } from "expo-image"

const { width, height } = Dimensions.get('window');
export default function App() {
  return (
    <View style={styles.container}>
      <LiveTextImageView>
        <Image
          source={{
            uri: 'https://images.unsplash.com/photo-1518893494013-481c1d8ed3fd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80',
          }}
          style={{ height, width }}
          contentFit="contain"
        />
      </LiveTextImageView>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'black',
  },
  box: {
    width: 160,
    height: 160,
    marginVertical: 20,
  },
});
