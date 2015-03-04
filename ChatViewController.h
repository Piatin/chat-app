//
//  ChatViewController.h
//  chatapp
//
//  Created by Kako on 2015/03/03.
//  Copyright (c) 2015年 Kako. All rights reserved.
//

#import "JSQMessages.h"

@interface ChatViewController : JSQMessagesViewController <UIActionSheetDelegate,UIImagePickerControllerDelegate>

-(id)initWith:(NSString *)roomId_;

@end
