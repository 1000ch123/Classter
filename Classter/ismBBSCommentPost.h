//
//  ismBBSCommentPost.h
//  Classter
//
//  Created by kanade on 13/04/06.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ismBBSCommentPost : UIViewController{
	NSString* title;
	NSString* content;
	UITextView* contentField;
}

@property NSUserDefaults* ud;
@property ismWebApi* api;

@end
