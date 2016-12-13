//
//  CreateCheckInViewController.m
//  whatsUp
//
//  Created by sandy moon on 12/12/16.
//  Copyright © 2016 NYU. All rights reserved.
//

#import "CreateCheckInViewController.h"

@interface CreateCheckInViewController ()
@property (strong, nonatomic) UIAlertController *alertCtrl;
@property (weak, nonatomic) IBOutlet UIButton *imageForUpload;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@end

@implementation CreateCheckInViewController
- (IBAction)back:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAlertCtrl];
    // Do any additional setup after loading the view.
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
  //  [self.imageView setImage:img];
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
