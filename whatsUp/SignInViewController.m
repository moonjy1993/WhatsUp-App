//
//  SignInViewController.m
//  whatsUp
//
//  Created by Ashley on 11/20/16.
//  Copyright © 2016 NYU. All rights reserved.
//

#import "SignInViewController.h"
@import Firebase;

@interface SignInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailSignIn;
@property (weak, nonatomic) IBOutlet UITextField *passwordSignIn;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;

@end

@implementation SignInViewController

//Sign Up an account with the user
- (IBAction)signUp:(id)sender {
    NSString *email = _emailSignIn.text;
    NSString *password = _passwordSignIn.text;
    [[FIRAuth auth] createUserWithEmail: email
                               password: password
                             completion: ^(FIRUser *_Nullable user, NSError * _Nullable error){
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
                                     UIAlertController *sucess = [UIAlertController alertControllerWithTitle:@"Success" message:@"You made a new account!" preferredStyle:UIAlertControllerStyleAlert]; //Show a success message
                                     [sucess addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){  //After user presses ok, the view will change to the log in view
                                        [self dismissViewControllerAnimated:YES completion:nil];
                                     }]];
                                     [self presentViewController:sucess animated:YES completion:nil]; //Show the message
                                }
                            }];
} //end of sign up


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
