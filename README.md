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


module.exports = React.createClass({
    getInitialState () {
        return {
             location: {}
        };
    },
    componentWillMount () {
        SplashScreen.hide();
    },

     componentDidMount () {
        SplashScreen.hide();
        this.configLocationManager();
    },
    configLocationManager () {
        AMapGeolocation.configLocationManager({
            ios: "9bd6c82e77583020a73ef1af59d0c759",
            android: "a10f2e6fc68417d1698f32cf69ef8f5e"
        }).then(()=>{
            AMapGeolocation.setOptions({
                interval: 10000,
                distanceFilter: 10,
                background: true,
                reGeocode: true
                });
        }).catch(e => {
            console.warn(e, 'error');
        });
    },
    componentWillUnmount() {
      AMapGeolocation.stopSerialLocation();
  },
    updateLocationState(location) {
      if (location) {
        location.timestamp = new Date(location.timestamp).toLocaleString();
        this.setState({ location });
        console.log(location);
      }
  },

    startLocation (){
        AMapGeolocation.startSerialLocation()
        .then(data => {
            console.warn(JSON.stringify(data));
        })
        .catch(e => {
            console.warn(e, 'error');
        });
    },
    stopLocation (){
        AMapGeolocation.stopSerialLocation();
    },
    getLastLocationAmap() {
        AMapGeolocation.getCurrentPosition()
        .then(data => {
            console.warn(JSON.stringify(data));
            this.updateLocationState(data);
        })
        .catch(e => {
            console.warn(e, 'error');
        });
    } ,
    render() {
      const { location } = this.state;
      return (
        <View style={styles.container}>
          <ScrollView style={styles.controls}>
            <Button style={styles.button} onPress={this.getLastLocationAmap}>高德定位</Button>
            <Button style={styles.button} onPress={this.getPositionBaidu}>百度定位</Button>
            <Button style={styles.button} onPress={this.getLastLocationTencent}>腾讯定位</Button>
          </ScrollView>
        </View>
      );
  },
});

const styles = StyleSheet.create({
    container: {
        flex: 1,
    },
    controls: {
        height: sr.h/2,
    },
    button: {
        height: 46,
        width: 300,
        marginLeft: (sr.w - 300) / 2,
        marginTop: 60,
        backgroundColor: '#c81622',
        borderRadius:4,
    },
});
