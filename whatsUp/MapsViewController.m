#import "MapsViewController.h"
#import <MapKit/MapKit.h>
#import "CheckIn.h"
#import "ImageViewController.h"

@import Firebase;


@interface MapsViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) NSMutableArray *checkInByUsers; // of Photo
@property (nonatomic,strong) NSMutableArray *mapAnnotations;
@property (nonatomic, strong) ImageViewController *imageViewController; // can be nil
@end

@implementation MapsViewController

-(NSMutableArray*)checkInByUsers{
    if(!_checkInByUsers){
        [CheckIn CheckInitiated];
        _checkInByUsers= [CheckIn getArray];
    }
    return _checkInByUsers;
    
}

- (void)setMapView:(MKMapView *)mapView
{
    _mapView = mapView;
    self.mapView.delegate = self;
    
    
    [self updateMapViewAnnotations];
    
}

- (void)updateMapViewAnnotations
{/*
  MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
  
  CLLocationCoordinate2D co;
  co.latitude=40.730610;
  co.longitude= -73.935242;
  point.coordinate = co;
  point.title = @"Where am I?";
  point.subtitle = @"I'm here!!!";
  
  [self.mapView addAnnotation:point];
  */
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotations:self.checkInByUsers];
    [self.mapView showAnnotations:self.checkInByUsers animated:YES];
    
    /*  if (self.imageViewController) {
     //    CheckIn *autoselectedPhoto = [self.checkInByUsers firstObject];
     if (autoselectedPhoto) {
     [self.mapView selectAnnotation:autoselectedPhoto animated:YES];
     [self prepareViewController:self.imageViewController
     forSegue:nil
     toShowAnnotation:autoselectedPhoto];
     }
     }*/
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *reuseId = @"MapsViewController";
    MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseId];
    if (!view) {
        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                               reuseIdentifier:reuseId];
        view.canShowCallout = YES;
        if (!self.imageViewController) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 46, 46)];
            view.leftCalloutAccessoryView = imageView;
            UIButton *disclosureButton = [[UIButton alloc] init];
            [disclosureButton setBackgroundImage:[UIImage imageNamed:@"disclosure"] forState:UIControlStateNormal];
            [disclosureButton sizeToFit];
            view.rightCalloutAccessoryView = disclosureButton;
        }
    }
    
    view.annotation = annotation;
    [self updateLeftCalloutAccessoryViewInAnnotationView:view];
    return view;
}
- (void)updateLeftCalloutAccessoryViewInAnnotationView:(MKAnnotationView *)annotationView
{
    UIImageView *imageView = nil;
    if ([annotationView.leftCalloutAccessoryView isKindOfClass:[UIImageView class]]) {
        imageView = (UIImageView *)annotationView.leftCalloutAccessoryView;
    }
    if (imageView) {
        CheckIn *checkin = nil;
        if ([annotationView.annotation isKindOfClass:[CheckIn class]]) {
            checkin = (CheckIn *)annotationView.annotation;
        }
        if (checkin) {
#warning Blocking main queue!
            imageView.image = [UIImage imageNamed:checkin.Image];
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view insertSubview:_mapView atIndex:0];
    
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
