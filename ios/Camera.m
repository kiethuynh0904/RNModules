//
//  Camera.m
//  RNModules
//
//  Created by kiet.huynh on 1/11/24.
//
#import "RNModules-Bridging-Header.h"

@interface RCT_EXTERN_MODULE(CameraManager, NSObject)
RCT_EXTERN_METHOD(sayHello:(NSString *)name)
RCT_EXTERN_METHOD(requestCameraPermission:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(openCamera:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(toggleFlash:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)

@end
