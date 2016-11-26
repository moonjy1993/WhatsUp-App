//
//  MapsViewController.m
//  whatsUp
//
//  Created by Ashley on 11/20/16.
//  Copyright © 2016 NYU. All rights reserved.
//

#import "MapsViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MapsViewController ()

@end

@implementation MapsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    // Do any additional setup after loading the view.
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    [locationManager startUpdatingLocation];
    
    double lat = locationManager.location.coordinate.latitude;
    double lon = locationManager.location.coordinate.longitude;
    
    CLLocation *myLocation = [[CLLocation alloc] initWithLatitude:lat longitude:lon];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:lat longitude:lon zoom: 11.5];
    
    //self.map
     */
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    self.view = mapView;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
