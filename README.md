# iBeaconReceiver

## How to run

1. To turn you Mac into a Beacon download [MactsAsBeacon](https://github.com/timd/MactsAsBeacon) and follow the instructions written in its README.
2. Set the UUID as `9C07E0AB-EC3C-4968-9296-59A0579D0678` (unfortunatly MactsAsBeacon doesn't allow you to paste it 😅).
3. Run `iBeaconReceiver` on an iOS Device.

## How it works

**iBeaconReceiver** sends an HTTP request every 4 seconds when there's the beacon near the device.

There are 2 tabs:

* `iBeacon`: used for the beacon recognition. The view gets **red** when there's no beacon, **yellow** when it's close to it and **green** when it's very close.

*  `Profile`: there are hardcoded some user info

## Software Design Decisions

### Storyboard

In the project there a file [Storyboard.swift](https://github.com/andreaantonioni/iBeaconReceiver/blob/master/iBeaconReceiver/Storyboard.swift)
which takes care to instantiate view controllers in a type-safe and declarative way.

### TabItem

In the project there a file [TabItem.swift](https://github.com/andreaantonioni/iBeaconReceiver/blob/master/iBeaconReceiver/TabItem.swift)
which takes care to set the view controller's `tabBarItem` property in a type-safe and declarative way.

### NetworkManager

The [NetworkManager](https://github.com/andreaantonioni/iBeaconReceiver/blob/master/iBeaconReceiver/NetworkManager.swift) is extremely simple.
It's a singleton which has a `Void` method that sends a HTTP Post request to an hardcoded API with a harcoded header.
It doesn't return any type of data because the response should not be used.


This network layer has an hardcoded style because it's extremely simple and the app is just a prototype.
In a real app I would a network layer like the one I used [here](https://github.com/andreaantonioni/Stargazers/tree/master/Stargazers/Network).

### Pattern Matching

I used the **Swift Pattern Matching** ([here is the line](https://github.com/andreaantonioni/iBeaconReceiver/blob/8800f3f16cdd66d58d94484678d4ec29ad3de765/iBeaconReceiver/BeaconViewController.swift#L110))
to check is there's a recognized beacon or none.


