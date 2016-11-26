//
//  LogInViewController.m
//  whatsUp
//
//  Created by Ashley on 11/20/16.
//  Copyright © 2016 NYU. All rights reserved.
//

#import "LogInViewController.h"
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
