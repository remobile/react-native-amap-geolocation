#import "AmapGeoLocationModule.h"

@implementation RCTAMapGeolocationModule {
    AMapLocationManager *_manager;
}

RCT_EXPORT_MODULE(AMapGeolocation)

RCT_EXPORT_METHOD(setOptions:(NSDictionary *)options) {
    if (options[@"distanceFilter"]) {
        _manager.distanceFilter = [options[@"distanceFilter"] doubleValue];
    }
    if (options[@"reGeocode"]) {
        _manager.locatingWithReGeocode = [options[@"reGeocode"] boolValue];
    }
    if (options[@"background"]) {
        _manager.allowsBackgroundLocationUpdates = [options[@"background"] boolValue];
    }
     [_manager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    if (options[@"locationTimeout"]) {
        _manager.locationTimeout = [options[@"locationTimeout"] doubleValue];
    }
    if (options[@"reGeocodeTimeout"]) {
        _manager.reGeocodeTimeout = [options[@"reGeocodeTimeout"] doubleValue];
    }
    NSLog(@"高德地图setOptions完成");
}

RCT_REMAP_METHOD(configLocationManager, key:(NSString *)key resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    [AMapServices sharedServices].apiKey = key;
    if (!_manager) {
        _manager = [AMapLocationManager new];
        _manager.delegate = self;
        resolve(nil);
    } else {
        resolve(nil);
    }
    NSLog(@"高德地图configLocationManager完成");
}

RCT_EXPORT_METHOD(startSerialLocation) {
    [_manager startUpdatingLocation];
    NSLog(@"高德地图startSerialLocation完成");
}

RCT_EXPORT_METHOD(stopSerialLocation) {
    [_manager stopUpdatingLocation];
    NSLog(@"高德地图stopSerialLocation完成");
}

RCT_EXPORT_METHOD(startSingleLocation) {
    [_manager requestLocationWithReGeocode:NO completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {

        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);

            [self sendEventWithName:@"TencentGeolocation" body: @{
                                                                  @"errorCode": @(error.code),
                                                                  @"errorMsg": error.localizedDescription,
                                                                  }];
        }
        NSLog(@"location:%@", location);
        id json = [self json:location reGeocode:regeocode];
        [self sendEventWithName:@"AMapGeolocation" body: json];
         NSLog(@"高德地图startSingleLocation完成");
    }];
   
}

- (id)json:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode {
    if (reGeocode && reGeocode.formattedAddress.length) {
        return @{
            @"accuracy": @(location.horizontalAccuracy),
            @"latitude": @(location.coordinate.latitude),
            @"longitude": @(location.coordinate.longitude),
            @"altitude": @(location.altitude),
            @"speed": @(location.speed),
            @"direction": @(location.course),
            @"timestamp": @(location.timestamp.timeIntervalSince1970 * 1000),
            @"address": reGeocode.formattedAddress,
            @"poiName": reGeocode.POIName,
            @"country": reGeocode.country,
            @"province": reGeocode.province,
            @"city": reGeocode.city,
            @"cityCode": reGeocode.citycode,
            @"district": reGeocode.district,
            @"street": reGeocode.street,
            @"streetNumber": reGeocode.number,
            @"adCode": reGeocode.adcode,
        };
    } else {
        return @{
            @"accuracy": @(location.horizontalAccuracy),
            @"latitude": @(location.coordinate.latitude),
            @"longitude": @(location.coordinate.longitude),
            @"altitude": @(location.altitude),
            @"speed": @(location.speed),
            @"direction": @(location.course),
            @"timestamp": @(location.timestamp.timeIntervalSince1970 * 1000),
        };
    }
}

- (void)amapLocationManager:(AMapLocationManager *)manager
          didUpdateLocation:(CLLocation *)location
                  reGeocode:(AMapLocationReGeocode *)reGeocode {
    id json = [self json:location reGeocode:reGeocode];
    [self sendEventWithName:@"AMapGeolocation" body: json];
    [NSUserDefaults.standardUserDefaults setObject:json forKey:RCTAMapGeolocationModule.storeKey];
    NSLog(@"高德地图amapLocationManager didUpdateLocation");
}

- (NSArray<NSString *> *)supportedEvents {
    return @[@"AMapGeolocation"];
}

+ (NSString *)storeKey {
    return @"AMapGeolocation";
}

@end
