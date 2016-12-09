//
//  FriendViewController.m
//  whatsUp
//
//  Created by Ashley on 12/4/16.
//  Copyright © 2016 NYU. All rights reserved.
//

#import "FriendViewController.h"
#import "User.h"
@import Firebase;
@import FirebaseDatabase;

@interface FriendViewController ()

@property (strong, nonatomic) NSMutableArray *users;
@property (strong, nonatomic) User *user;

@end

/*
    This basically shows the registered people from the database and displays it in a table
*/
@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    //This creates the "Back" button in the table view
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClicked:)];
    //This shows the back button in the left side of the navigation
     self.navigationItem.leftBarButtonItem = backButton;
    //Title of navigation
     self.navigationItem.title = @"Member List";
     self.navigationController.navigationBar.barTintColor = [UIColor colorWithWhite:0.200 alpha:1.000];
    _users = [[NSMutableArray alloc] init];
    [self getUsers]; //Calls method
}

//When back button is clicked, the view is dismissed
-(IBAction)backBtnClicked:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"thecell" forIndexPath:indexPath];
    
    //Gets the value of user at specific rows
    User *userSnapshot = _users[indexPath.row];
    
    //Display the name as title and email as subtitle
    cell.textLabel.text= userSnapshot.name;
    cell.detailTextLabel.text = userSnapshot.email;
    
    // Configure the cell...
    return cell;
}
/*

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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
