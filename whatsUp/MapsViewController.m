//
//  MapsViewController.m
//  whatsUp
//
//  Created by Ashley on 11/20/16.
//  Copyright © 2016 NYU. All rights reserved.
//

#import "MapsViewController.h"
#import <GoogleMaps/GoogleMaps.h>
@import Firebase;

@interface MapsViewController ()

@end

@implementation MapsViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
  //  [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, self.view.frame.size.width,100.0)];
    // Do any additional setup after loading the view.
    //Feel free to change this, I just needed to make sure the buttons can be on top of the map view
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    //Get the longitude and latitude
    double lat = locationManager.location.coordinate.latitude;
    double lon = locationManager.location.coordinate.longitude;
    
    //CLLocation *myLocation = [[CLLocation alloc] initWithLatitude:lat longitude:lon];
    
    //Specifies center and zoom level of map
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:lat longitude:lon zoom: 11.5];
    
    GMSMapView *mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    mapView.myLocationEnabled = YES;
    [self.view insertSubview:mapView atIndex:0]; //Set the view controller's view to the map. Its at index 0, so the buttons can be on top of the map
}


//Signs out the current user
- (IBAction)signOut:(id)sender {
    NSError *error;
    [[FIRAuth auth] signOut:&error];
    if(!error){
        //If user successfully logs out
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        //Print out error
        NSLog(@"Error: %@", error);
        return;
    }
    
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
