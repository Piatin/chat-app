//
//  pushnotification.m
//  chatapp
//
//  Created by Kako on 2015/03/03.
//  Copyright (c) 2015年 Kako. All rights reserved.
//

#import "pushnotification.h"

#import <Parse/Parse.h>

#import "AppConstant.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
void ParsePushUserAssign(void)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    PFInstallation *installation = [PFInstallation currentInstallation];
    installation[PF_INSTALLATION_USER] = [PFUser currentUser];
    [installation saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
     {
         if (error != nil)
         {
             NSLog(@"ParsePushUserAssign save error.");
         }
     }];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
void ParsePushUserResign(void)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    PFInstallation *installation = [PFInstallation currentInstallation];
    [installation removeObjectForKey:PF_INSTALLATION_USER];
    [installation saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
     {
         if (error != nil)
         {
             NSLog(@"ParsePushUserResign save error.");
         }
     }];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
void SendPushNotification(NSString *roomId, NSString *text)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    PFQuery *query = [PFQuery queryWithClassName:PF_MESSAGES_CLASS_NAME];
    [query whereKey:PF_MESSAGES_ROOMID equalTo:roomId];
    [query whereKey:PF_MESSAGES_USER notEqualTo:[PFUser currentUser]];
    [query includeKey:PF_MESSAGES_USER];
    [query setLimit:1000];
    
    PFQuery *queryInstallation = [PFInstallation query];
    [queryInstallation whereKey:PF_INSTALLATION_USER matchesKey:PF_MESSAGES_USER inQuery:query];
    
    PFPush *push = [[PFPush alloc] init];
    [push setQuery:queryInstallation];
    [push setMessage:text];
    [push sendPushInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
     {
         if (error != nil)
         {
             NSLog(@"SendPushNotification send error.");
         }
     }];
}
