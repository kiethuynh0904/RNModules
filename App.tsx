/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import React from 'react';
import {
  Button,
  NativeModules,
  SafeAreaView,
  StyleSheet,
  useColorScheme,
  View,
} from 'react-native';

import {Colors} from 'react-native/Libraries/NewAppScreen';
import CameraManager from './NativeModules/CameraManager';

function App(): React.JSX.Element {
  const isDarkMode = useColorScheme() === 'dark';

  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };

  const handleNativeModule = async () => {
    try {
      const granted = await CameraManager.requestCameraPermission();
      if (granted) {
        const success = await CameraManager.openCamera();
        if (success) {
          console.log('Camera opened');
        }
      }
    } catch (error) {
      console.log('Camera error', error);
    }
  };

  const handleToggleFlash = async () => {
    try {
      const isFlashOn = await CameraManager.toggleFlash();
      console.log('Flash is', isFlashOn ? 'on' : 'off');
    } catch (error) {
      console.log('Toggle flash error', error);
    }
  };

  return (
    <SafeAreaView style={[backgroundStyle, {flex: 1}]}>
      <View style={{flex: 1, justifyContent: 'center', alignItems: 'center'}}>
        <Button onPress={handleNativeModule} title="Open Camera" />
        <Button onPress={handleToggleFlash} title="Toggle flash" />
      </View>
    </SafeAreaView>
  );
}

export default App;
