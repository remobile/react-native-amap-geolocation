#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface RCTLocationModule : RCTEventEmitter <RCTBridgeModule, AMapLocationManagerDelegate>

@end
