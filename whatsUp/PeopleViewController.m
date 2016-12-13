//
//  PeopleViewController.m
//  whatsUp
//
//  Created by Ashley on 12/9/16.
//  Copyright © 2016 NYU. All rights reserved.
//

#import "PeopleViewController.h"
#import "FriendViewController.h"
#import "User.h"
@import Firebase;
@import FirebaseDatabase;

@interface PeopleViewController ()

@property (strong, nonatomic) NSMutableArray *users;
@property (strong, nonatomic) User *user;


@end

@implementation PeopleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClicked:)];
    //This shows the back button in the left side of the navigation
    self.navigationItem.leftBarButtonItem = backButton;
    //Title of navigation
    self.navigationItem.title = @"People";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithWhite:0.200 alpha:1.000];
    _users = [[NSMutableArray alloc] init];
    [self getUsers]; //Calls method

}


//When back button is clicked, the view is dismissed
-(IBAction)backBtnClicked:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Method to retreive the email and names of users in the firebase
- (void)getUsers{
    
    //Get the child nodes of User
    [[[[FIRDatabase database] reference]child:@"users"]observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        //Store the snapshot value into the dicitionary
        NSDictionary *dict = snapshot.value;
        _user = [[User alloc] init];
        
        //The information is separated into name and email in user
        [_user setValuesForKeysWithDictionary:dict];
        
        //The user is stored into the array
        [_users addObject: _user];
        
        //Reloads the table
        dispatch_async(dispatch_get_main_queue(),^{
            self.tableView.reloadData;
        });
    }];
}

#pragma mark - Table view data source

//Default is 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//Returns the number in the User array, aka should be the amount of users in the firebase
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_users count];
}

//Displays the cells for the table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Dequeue is more memory efficient
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"thecell2" forIndexPath:indexPath];
    
    //Gets the value of user at specific rows
    User *userSnapshot = _users[indexPath.row];
    
    //Display the name as title and email as subtitle
    cell.textLabel.text= userSnapshot.name;
    cell.detailTextLabel.text = userSnapshot.email;
    
    // Configure the cell...
    return cell;
}


 //Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
     return YES;
 }

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    User *userIndex = _users[indexPath.row];
    NSLog(@"%@", @"Completed");
    
    
    FIRDatabaseReference *ref = [[FIRDatabase database] referenceFromURL:@"https://whatsup-d2a04.firebaseio.com/"];
    [[[[ref child:@"users"]queryOrderedByChild:@"email"]queryEqualToValue:userIndex.email]observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        //Get the key for the specified user
        NSLog(@"%@", snapshot.key);
       
        NSString *userRef = [FIRAuth auth].currentUser.uid;
        FIRUser *user = [FIRAuth auth].currentUser;
        NSLog(@"%@", userRef);
        NSDictionary *values = @{ snapshot.key: @"true"};
        
        [[[[ref child:@"users"]child:user.uid]child:@"friends"]updateChildValues:values withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
            if(error){
                NSLog(@"Error");
                return;
            }
            
            NSLog(@"Success");

        }];
    }];
     
}


- (void) addFriends:(UITableView *)cell isCompleted:(BOOL)isCompleted{
    
}



/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
