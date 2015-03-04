//
//  utilities.h
//  chatapp
//
//  Created by Kako on 2015/03/03.
//  Copyright (c) 2015年 Kako. All rights reserved.
//

#import <UIKit/UIKit.h>

void			LoginUser					(id target);

UIImage*		ResizeImage					(UIImage *image, CGFloat width, CGFloat height);

void			PostNotification			(NSString *notification);

//-------------------------------------------------------------------------------------------------------------------------------------------------
NSString*		TimeElapsed					(NSTimeInterval seconds);
