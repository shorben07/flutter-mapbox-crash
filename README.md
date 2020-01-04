Demo application that demonstrates issues that appear in Mapbox under low memory conditions in flutter app

https://github.com/flutter/flutter/issues/48182

### Steps to reproduce the issue 

1. Open the app on a real device. For example, iPad mini 2 (Model A1489)
1. Perform some actions on the map during 10 seconds: zoom, pan etc.
1. After 10 seconds following can happen:
    1. Crash
    1. Drawing artifacts
    1. Black screen
    