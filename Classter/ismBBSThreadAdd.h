//
//  ismBBSThreadAdd.h
//  Classter
//
//  Created by kanade on 13/04/06.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ismBBSThreadAdd : UIViewController{
	NSString* titleString;
}

@property NSUserDefaults* ud;
@property ismWebApi* api;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleField;

- (IBAction)returnButton:(id)sender;
- (IBAction)addButton:(id)sender;

-(void)addThread;

@end
