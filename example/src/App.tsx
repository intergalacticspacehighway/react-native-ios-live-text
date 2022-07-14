import * as React from 'react';

import { StyleSheet, View, Image, Dimensions } from 'react-native';
import { LiveTextImageViewView } from 'react-native-live-text-image-view';

const { width, height } = Dimensions.get('window');
export default function App() {
  const [loaded, setLoaded] = React.useState(false);
  return (
    <View style={styles.container}>
      <LiveTextImageViewView enabled={loaded}>
        <Image
          source={{
            uri: 'https://images.unsplash.com/photo-1518893494013-481c1d8ed3fd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80',
          }}
          style={{ height, width }}
          resizeMode="contain"
          onLoadEnd={() => setLoaded(true)}
        />
      </LiveTextImageViewView>
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
