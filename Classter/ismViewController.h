//
//  ismViewController.h
//  Classter
//
//  Created by kanade on 13/04/01.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ismClassSelect.h"

#define MAILADDRESS		0
#define PASSWORD		1

@interface ismViewController : UIViewController
/*
@property UILabel* label_mail;
@property UILabel* label_pass;

@property UITextField* field_mail;
@property UITextField* fiele_pass;

@property UIButton* button_login;
*/
@property NSString* mailaddress;
@property NSString* password;

@end
