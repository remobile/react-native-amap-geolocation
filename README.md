### Installation
npm install @remobile/react-native-amap-geolocation --save

### Installation (Android)
- settings.gradle `
include ':react-native-amap-geolocation'
project(':react-native-amap-geolocation').projectDir = new File(settingsDir, '../node_modules/@remobile/react-native-amap-geolocation/android')`

- build.gradle `compile project(':react-native-amap-geolocation')`

- MainApplication `new AmapGeoLocationPackage()`

### Installation (iOS)
- Project navigator->Libraries->Add Files to select @remobile/react-native-amap-geolocation/ios/RCTAmapGeoLocation.xcodeproj
- Project navigator->Build Phases->Link Binary With Libraries add libRCTAmapGeoLocation.a
- Add frameworks to your project, include AMapLocationKit.framework and AMapFoundationKit.framework
- Project navigator->Build Phases->Link Binary With Libraries add AMapLocationKit.framework and AMapFoundationKit.framework
### Usage

    const AmapGeoLocation =  require('react-native-amap-geolocation');
    startLocation (){
        AMapGeolocation.start()
        .then(data => {
            console.warn(JSON.stringify(data));
        })
        .catch(e => {
            console.warn(e, 'error');
        });
    },
    stopLocation (){
        AMapGeolocation.stop();
    },
    getPositionBaidu () {
        Geolocation.getCurrentPosition()
        .then(data => {
            console.warn(JSON.stringify(data));
            this.updateLocationState(data);
        })
        .catch(e => {
            console.warn(e, 'error');
        });
    },
    getLastLocation() {
        AMapGeolocation.getLastLocation()
        .then(data => {
            console.warn(JSON.stringify(data));
            this.updateLocationState(data);
        })
        .catch(e => {
            console.warn(e, 'error');
        });
    } ,
