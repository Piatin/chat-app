//
//  messages.h
//  chatapp
//
//  Created by Kako on 2015/03/03.
//  Copyright (c) 2015年 Kako. All rights reserved.
//

#import <Parse/Parse.h>

NSString* StartPrivateChat (PFUser *user1,PFUser *user2);

void		CreateMessageItem			(PFUser *user, NSString *roomId, NSString *description);
void		DeleteMessageItem			(PFObject *message);

//-------------------------------------------------------------------------------------------------------------------------------------------------
void		UpdateMessageCounter		(NSString *roomId, NSString *lastMessage);
void		ClearMessageCounter			(NSString *roomId);
