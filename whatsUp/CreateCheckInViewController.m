//
//  CreateCheckInViewController.m
//  whatsUp
//
//  Created by sandy moon on 12/12/16.
//  Copyright © 2016 NYU. All rights reserved.
//

#import "CreateCheckInViewController.h"
#import "CheckIn.h"
@interface CreateCheckInViewController ()
@property (strong, nonatomic) UIAlertController *alertCtrl;
@property (weak, nonatomic) IBOutlet UIButton *imageForUpload;
@property (weak, nonatomic) IBOutlet UITextField *text;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) UIImagePickerController *imagePicker;

@property (weak, nonatomic) UIImage *image;
@end

@implementation CreateCheckInViewController
- (IBAction)back:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAlertCtrl];
    [self GetCurrentLocation_WithBlock:^{
        NSLog(@"Lat ::%f,Long ::%f",[self.current_Lat floatValue],[self.current_Long floatValue]);
    }];
}
- (IBAction)EnterPressed:(id)sender {
    NSDate * now = [NSDate date];
     NSString *time = [NSDateFormatter localizedStringFromDate:now
     dateStyle:NSDateFormatterNoStyle
     timeStyle:NSDateFormatterShortStyle];
  
    [CheckIn Add_Item: [CheckIn checkInfoWithsubtitle:time withtitle:self.text withImage:@"dessert.jpeg" withCoordinate:_coordinate]];
     [self dismissViewControllerAnimated:YES completion:nil];
   
}

#pragma mark - CLLocationManager
-(void)GetCurrentLocation_WithBlock:(void(^)())block {
    self._locationBlock = block;
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager setDelegate:self];
    [_locationManager setDistanceFilter:kCLDistanceFilterNone];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_locationManager requestWhenInUseAuthorization];
            [_locationManager requestAlwaysAuthorization];
        }
    
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *currentLoc=[locations objectAtIndex:0];
    _coordinate=currentLoc.coordinate;
    _current_Lat = [NSString stringWithFormat:@"%f",currentLoc.coordinate.latitude];
    _current_Long = [NSString stringWithFormat:@"%f",currentLoc.coordinate.longitude];
    NSLog(@"here lat %@ and here long %@",_current_Lat,_current_Long);
    self._locationBlock();
    [_locationManager stopUpdatingLocation];
    _locationManager = nil;
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
}

- (IBAction)uploadPhoto:(UIButton *)sender {
     [self presentViewController:self.alertCtrl animated:YES completion:nil];
}

- (void) setupAlertCtrl
{
    self.alertCtrl = [UIAlertController alertControllerWithTitle:@"Select Image"
                                                         message:nil
                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    //Create an action
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"From camera"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action)
                             {
                                 [self handleCamera];
                             }];
    UIAlertAction *imageGallery = [UIAlertAction actionWithTitle:@"From Photo Library"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       [self handleImageGallery];
                                   }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction *action)
                             {
                                 [self dismissViewControllerAnimated:YES completion:nil];
                             }];
    
    
    //Add action to alertCtrl
    [self.alertCtrl addAction:camera];
    [self.alertCtrl addAction:imageGallery];
    [self.alertCtrl addAction:cancel];
    
    
}
- (void)handleCamera
{
#if TARGET_IPHONE_SIMULATOR
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:@"Camera is not available on simulator"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction *action)
                         {
                             [self dismissViewControllerAnimated:YES completion:nil];
                         }];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
#elif TARGET_OS_IPHONE
    //Some code for iPhone
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
    
#endif
}

- (void)handleImageGallery
{
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePicker.delegate = self;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSData *dataImage = UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"],1);
    UIImage *img = [[UIImage alloc] initWithData:dataImage];
    self.image= img;
   [self.imageView setImage:img];
    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
    
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
