import {
    requireNativeComponent,
    NativeModules,
    Platform,
    NativeEventEmitter,
} from 'react-native';

import React, {
    Component,
    PropTypes
} from 'react';

const _module = NativeModules.AMapGeolocation;
const eventEmitter = new NativeEventEmitter(_module);

export default {
    configLocationManager(key) {
        return _module.configLocationManager(Platform.select(key));
    },
    setOptions(options) {
        return _module.setOptions(options);
        eventEmitter.addListener("AMapGeolocation", listener)
    },
    startSerialLocation() {
        return new Promise((resolve, reject) => {
            try {
                _module.startSerialLocation();
            }
            catch (e) {
                reject(e);
                return;
            }
            eventEmitter.addListener("AMapGeolocation", resp => {
                resolve(resp);
            });
        });
    },
    stopSerialLocation() {
        return _module.stopSerialLocation();
    },
    getCurrentPosition() {
        return new Promise((resolve, reject) => {
            try {
                _module.startSingleLocation();
            }
            catch (e) {
                reject(e);
                return;
            }
            eventEmitter.addListener("AMapGeolocation", resp => {
                resolve(resp);
            });
        });
    },
};
