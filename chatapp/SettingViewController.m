//
//  SettingViewController.m
//  chatapp
//
//  Created by Kako on 2015/02/27.
//  Copyright (c) 2015年 Kako. All rights reserved.
//

#import "SettingViewController.h"
#import <Parse/Parse.h>

@interface SettingViewController ()<UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate>
@property (weak,nonatomic) IBOutlet UIPickerView *ninzu;
@property (weak,nonatomic) IBOutlet UITextField *roomNameField;
@property (weak,nonatomic) IBOutlet UIButton *doneButton;
@end

@implementation SettingViewController

#pragma UIViewController lifecycle

-(void)viewDidLoad{
    [super viewDidLoad];
    self.ninzu.dataSource = self;
    self.ninzu.delegate = self;
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 10;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"%d",row);
   
    PFObject *object= [PFObject objectWithClassName:@"Object"];
//    object[@"kazu"] = self.ninzu.row;
    [object saveInBackground];
}

-(IBAction)doneButtonTapped{
    PFObject *roomName;
    if (self.roomName) {
        roomName = self.roomName;
    }else{
        roomName = [PFObject objectWithClassName:@"room"];
    }
    
    roomName[@"name"]=self.roomNameField.text;
    [roomName saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!succeeded) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"エラー"
                                                                message:error.localizedDescription
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
            
            return;
        }
        
        [self dismissViewControllerAnimated:YES completion:NULL];
    }];

}

#pragma mark - UITextField delegate

- (void)textFieldDidEndEditing:(UITextField *)roomNametextField
{
    self.doneButton.enabled = (self.roomNameField.text.length > 0);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    self.doneButton.enabled = (self.roomNameField.text.length > 0);
    
    return YES;
}

@end
