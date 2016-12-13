//
//  LogInViewController.m
//  whatsUp
//
//  Created by Ashley on 11/20/16.
//  Copyright © 2016 NYU. All rights reserved.
//

#import "LogInViewController.h"
#import <AVFoundation/AVFoundation.h>
@import Firebase;

@interface LogInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailLogIn;
@property (weak, nonatomic) IBOutlet UITextField *passwordLogIn;

@end

@implementation LogInViewController


- (IBAction)logIn:(id)sender {
    NSString *email = _emailLogIn.text;
    NSString *password = _passwordLogIn.text;
    [[FIRAuth auth] signInWithEmail:email password:password completion:^(FIRUser *user, NSError *error){
        if(error){ //If there is an error with the email or password field
            NSLog(@"%@", error.localizedDescription); //Get the error
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:error.localizedDescription preferredStyle: UIAlertControllerStyleAlert]; //Output the error as a message to the user
            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){   //An action will be associated with the error, to which the user can press ok
            }]];
            [self presentViewController:alertController animated:YES completion:nil]; //Show the alert
            return;
        }
        else{  //If there is no error
            NSLog(@"Success");
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"map"];
            [self presentViewController:vc animated:YES completion:nil];
        }
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Checked if a user has already been logged in. If they are logged in, then show the map. 
    FIRUser *user = [FIRAuth auth].currentUser;
    if(user){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"map"];
        [self presentViewController:vc animated:YES completion:nil];
    }

    NSString *path = [NSString stringWithFormat:@"%@/organ_music.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundURL = [NSURL fileURLWithPath:path];
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
    audioPlayer.numberOfLoops = -1;
    
    if(audioPlayer == nil){
        NSLog(@"%@", [error description]);
    }
    else{
        [audioPlayer play];
    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(enteredBackground:)
                                                name:UIApplicationDidEnterBackgroundNotification
                                              object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(enteredForeground:)
                                                name:UIApplicationWillEnterForegroundNotification
                                              object:nil];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillDisappear:(BOOL)animated{
    [audioPlayer stop];
}

- (void) enteredBackground: (NSNotification*)notif{
    [audioPlayer stop];
}

- (void) enteredForeground: (NSNotification*)notif{
    [audioPlayer play];
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
