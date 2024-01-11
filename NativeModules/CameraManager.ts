import {NativeModules} from 'react-native';
const {CameraManager} = NativeModules;
interface CameraManagerInterface {
  sayHello(name: string): void;
  requestCameraPermission(): Promise<boolean>;
  openCamera(): Promise<boolean>;
  toggleFlash(): Promise<boolean>;
}
export default CameraManager as CameraManagerInterface;
