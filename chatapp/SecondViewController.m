//
//  SecondViewController.m
//  chatapp
//
//  Created by Kako on 2015/02/27.
//  Copyright (c) 2015年 Kako. All rights reserved.
//

#import "SecondViewController.h"
#import <Parse/Parse.h>
<<<<<<< HEAD

@interface SecondViewController ()<UITextFieldDelegate>
@property (weak,nonatomic)IBOutlet UITextField *nameField;
@property (weak,nonatomic)IBOutlet UIButton *icon;
@property (weak,nonatomic)IBOutlet UIImageView *iconImage;
@property (weak,nonatomic)IBOutlet UIButton *kettei;
=======
#import <ParseUI/ParseUI.h>
#import "ProgressHUD.h"
#import "AppConstant.h"
#import "pushnotification.h"
#import "utilities.h"

@interface SecondViewController ()
@property (strong,nonatomic)IBOutlet UITextField *nameField;
@property (strong,nonatomic)IBOutlet UIButton *icon;
@property (strong,nonatomic)IBOutlet UIImageView *iconImage;
@property (strong,nonatomic)IBOutlet PFImageView *userImage;
@property (strong,nonatomic)IBOutlet UIButton *kettei;

>>>>>>> 66ec8b065dab862a4aee3ae30ff7c6f3a466062b
@end

@implementation SecondViewController

@synthesize nameField;
@synthesize icon,iconImage;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil

{
self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
if (self)
{
    [self.tabBarItem setImage:[UIImage imageNamed:@"tab_profile"]];
    self.tabBarItem.title = @"Profile";
}
return self;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [super viewDidLoad];
    self.title = @"Profile";
    //---------------------------------------------------------------------------------------------------------------------------------------------
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Log out" style:UIBarButtonItemStylePlain target:self
                                                                             action:@selector(actionLogout)];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)]];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    iconImage.layer.cornerRadius = iconImage.frame.size.width / 2;
    iconImage.layer.masksToBounds = YES;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidAppear:(BOOL)animated
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [super viewDidAppear:animated];
    //---------------------------------------------------------------------------------------------------------------------------------------------
//    if ([PFUser currentUser] != nil)
//    {
//        [self loadUser];
//    }
//    else LoginUser(self);
}

<<<<<<< HEAD
-(IBAction)ketteiTapped{
    PFObject *user;
    
    if (self.user) {
        user = self.user;
    } else {
        user = [PFObject objectWithClassName:@"User"];
    }
    
    user[@"name"] = self.nameField.text;
    
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!succeeded) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"エラー"
                                                                message:error.localizedDescription
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
            
            return;
        }
        
        //[self dismissViewControllerAnimated:YES completion:NULL];
        NSLog(@"ここまで");
    }];

}

-(IBAction)onTap{
    if ( self.nameField.isFirstResponder )
        {
            [self.nameField resignFirstResponder];
        }
    
            NSLog(@"キーボード");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
=======
//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)dismissKeyboard
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [self.view endEditing:YES];
>>>>>>> 66ec8b065dab862a4aee3ae30ff7c6f3a466062b
}

#pragma mark - Backend actions

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)loadUser
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    PFUser *user = [PFUser currentUser];
    
    [_userImage setFile:user[PF_USER_PICTURE]];
    [_userImage loadInBackground];
    
    nameField.text = user[PF_USER_FULLNAME];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)saveUser
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    NSString *fullname = nameField.text;
    if ([fullname length] != 0)
    {
        PFUser *user = [PFUser currentUser];
        user[PF_USER_FULLNAME] = fullname;
        user[PF_USER_FULLNAME_LOWER] = [fullname lowercaseString];
        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
         {
             if (error == nil)
             {
                 [ProgressHUD showSuccess:@"Saved."];
             }
             else [ProgressHUD showError:@"Network error."];
         }];
    }
    else [ProgressHUD showError:@"Name field must be set."];
}

#pragma mark - User actions

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)actionCleanup
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    iconImage.image = [UIImage imageNamed:@"profile_blank"];
    nameField.text = nil;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)actionLogout
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
                                               otherButtonTitles:@"Log out", nil];
    [action showFromTabBar:[[self tabBarController] tabBar]];
}

#pragma mark - UIActionSheetDelegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    if (buttonIndex != actionSheet.cancelButtonIndex)
    {
        [PFUser logOut];
        ParsePushUserResign();
        PostNotification(NOTIFICATION_USER_LOGGED_OUT);
        [self actionCleanup];
//        LoginUser(self);
    }
}

//-------------------------------------------------------------------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (IBAction)actionSave:(id)sender
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [self dismissKeyboard];
    [self saveUser];
}

#pragma mark - UIImagePickerControllerDelegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    if (image.size.width > 140) image = ResizeImage(image, 140, 140);
    //---------------------------------------------------------------------------------------------------------------------------------------------
    PFFile *filePicture = [PFFile fileWithName:@"picture.jpg" data:UIImageJPEGRepresentation(image, 0.6)];
    [filePicture saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
     {
         if (error != nil) [ProgressHUD showError:@"Network error."];
     }];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    iconImage.image = image;
    //---------------------------------------------------------------------------------------------------------------------------------------------
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    if (image.size.width > 30) image = ResizeImage(image, 30, 30);
    //---------------------------------------------------------------------------------------------------------------------------------------------
    PFFile *fileThumbnail = [PFFile fileWithName:@"thumbnail.jpg" data:UIImageJPEGRepresentation(image, 0.6)];
    [fileThumbnail saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
     {
         if (error != nil) [ProgressHUD showError:@"Network error."];
     }];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    PFUser *user = [PFUser currentUser];
    user[PF_USER_PICTURE] = filePicture;
    user[PF_USER_THUMBNAIL] = fileThumbnail;
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
     {
         if (error != nil) [ProgressHUD showError:@"Network error."];
     }];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    return 2;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    return 1;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------

@end
