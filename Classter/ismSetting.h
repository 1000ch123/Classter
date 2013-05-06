//
//  ismSetting.h
//  Classter
//
//  Created by kanade on 13/04/01.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ismCellTextField.h"

@interface ismSetting : UITableViewController{

NSArray* setting_classter;
NSArray* setting_user;
NSDictionary* userData;

}

@property NSArray* settingKeys;
@property NSDictionary* settingDict;

@property ismWebApi *api;
@property NSUserDefaults *ud;


@end
