### Installation
npm install @remobile/react-native-amap-geolocation --save

### Installation (Android)
- settings.gradle `
include ':react-native-amap-geolocation'
project(':react-native-amap-geolocation').projectDir = new File(settingsDir, '../node_modules/@remobile/react-native-amap-geolocation/android')`

- build.gradle `compile project(':react-native-amap-geolocation')`

- MainApplication`new AmapGeoLocationPackage()`

### Installation (iOS)
- Project navigator->Libraries->Add Files to 选择 @remobile/react-native-amap-geolocation/ios/RCTAmapGeoLocation.xcodeproj
- Project navigator->Build Phases->Link Binary With Libraries 加入 libRCTAmapGeoLocation.a

### Usage 使用方法

    const AmapGeoLocation =  require('react-native-amap-geolocation');
    componentWillMount() {
        AmapGeoLocation.startListener();
        this.subscription = DeviceEventEmitter.addListener('callStateUpdated', data => { console.warn(JSON.stringify(data)); });
    }
    componentWillUnmount() {
        AmapGeoLocation.stopListener();
    }
