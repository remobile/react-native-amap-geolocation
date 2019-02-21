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
    init(key) {
        return _module.init(Platform.select(key));
    },
    setOptions(options) {
        return _module.setOptions(options);
    },
    start() {
        return new Promise((resolve, reject) => {
            try {
                _module.start();
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
    stop() {
        return _module.stop();
    },
    getLastLocation() {
        return _module.getLastLocation();
    },
};
