//
//  SecondViewController.m
//  chatapp
//
//  Created by Kako on 2015/02/27.
//  Copyright (c) 2015年 Kako. All rights reserved.
//

#import "SecondViewController.h"
#import <Parse/Parse.h>

@interface SecondViewController ()<UITextFieldDelegate>
@property (weak,nonatomic)IBOutlet UITextField *nameField;
@property (weak,nonatomic)IBOutlet UIButton *icon;
@property (weak,nonatomic)IBOutlet UIImageView *iconImage;
@property (weak,nonatomic)IBOutlet UIButton *kettei;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

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
}

@end
