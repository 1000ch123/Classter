//
//  ismClassAdd.h
//  Classter
//
//  Created by kanade on 13/04/05.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ismClassAdd : UIViewController <UITextFieldDelegate>{
	NSString* addGroupName;
	NSString* joinGroupCode;
}

@property (weak, nonatomic) IBOutlet UILabel *addLabel;
@property (weak, nonatomic) IBOutlet UITextField *addField;
@property (weak, nonatomic) IBOutlet UILabel *joinLabel;
@property (weak, nonatomic) IBOutlet UITextField *joinField;

- (IBAction)addButton:(id)sender;
- (IBAction)joinButton:(id)sender;

@end
