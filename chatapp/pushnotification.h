//
//  pushnotification.h
//  chatapp
//
//  Created by Kako on 2015/03/03.
//  Copyright (c) 2015年 Kako. All rights reserved.
//

#import <Parse/Parse.h>

void		ParsePushUserAssign		(void);
void		ParsePushUserResign		(void);

//-------------------------------------------------------------------------------------------------------------------------------------------------
void		SendPushNotification	(NSString *roomId, NSString *text);
