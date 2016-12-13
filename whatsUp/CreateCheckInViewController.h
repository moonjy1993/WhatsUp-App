//
//  CreateCheckInViewController.h
//  whatsUp
//
//  Created by sandy moon on 12/12/16.
//  Copyright © 2016 NYU. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
typedef void(^locationBlock)();

@interface CreateCheckInViewController : ViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate, CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}
-(void)GetCurrentLocation_WithBlock:(void(^)())block;

@property (nonatomic, strong) locationBlock _locationBlock;
@property (nonatomic,copy)CLLocationManager *locationManager;
@property (nonatomic)CLLocationCoordinate2D coordinate;
@property (nonatomic,strong) NSString *current_Lat;
@property (nonatomic,strong) NSString *current_Long;
@end
