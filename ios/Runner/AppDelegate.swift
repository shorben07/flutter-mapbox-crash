import UIKit
import Flutter
import Mapbox

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        let viewFactory = MyMapboxPlatformViewFactory()
        registrar(forPlugin: "Kitty").register(viewFactory, withId: "MyMapboxView")
        
        perform(#selector(postApplicationDidReceiveMemoryWarningNotification), with: self, afterDelay: 10)
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        print("FlutterAppDelegate: applicationDidReceiveMemoryWarning")
    }
    
    /// Method that posts fake didReceiveMemoryWarningNotification notification for flutter engine
    @objc func postApplicationDidReceiveMemoryWarningNotification() {
        print("FlutterAppDelegate: postApplicationDidReceiveMemoryWarningNotification")
        NotificationCenter.default.post(name: UIApplication.didReceiveMemoryWarningNotification, object: nil)
    }
    
    /// Use this method to create a real memory warning by allocating big amount of memory
    /// perform(#selector(allocateMemory), with: self)
    @objc func allocateMemory() {
        let numberOfMegaBytes = 250
        let mb = 1048576
        let newBuffer = [UInt8](repeating: 0, count: numberOfMegaBytes * mb)
        buffer += newBuffer
    }
    var buffer = [UInt8]()
}

class MyMapboxPlatformViewFactory: NSObject, FlutterPlatformViewFactory {
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return MyMapboxPlatformView(frame, viewId: viewId, args: args)
    }
}

class MyMapboxPlatformView: NSObject, FlutterPlatformView  {
    let frame: CGRect
    let viewId: Int64
    let myView: MyMapboxView
    
    init(_ frame: CGRect, viewId: Int64, args: Any?) {
        self.frame = frame
        self.viewId = viewId
        self.myView =  MyMapboxView(frame: frame)
    }
    
    func view() -> UIView {
        return myView
    }
    
    deinit {
        // wrokaround for https://github.com/flutter/flutter/issues/45697
        myView.subviews.first?.removeFromSuperview()
    }
}

class MyMapboxView: UIView, MGLMapViewDelegate{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let mapView = MGLMapView(frame: frame)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        MGLAccountManager.accessToken = "pk.eyJ1Ijoic2VyZ2V5bmUiLCJhIjoiY2s0enp5YzA4MGZrNTNsc2EzcGpuNWZxdCJ9.DkEmFgRzjtSzEx5fRJMp-Q"
        let url = URL(string: "mapbox://styles/mapbox/satellite-streets-v9")
        mapView.styleURL = url
        addSubview(mapView)
        mapView.delegate = self
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
