//
//  ismTimeTableAdd.h
//  Classter
//
//  Created by kanade on 13/04/05.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ismTimeTableAdd : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>{
	NSArray* terms;
	NSArray* categories;
	NSArray* subcategories;
	NSArray* dataList;
	
	NSString* lessonTitle;
	NSString* addTerm;
	NSString* addCategory;
	NSString* addSubCategory;
}

@property ismWebApi* api;
@property NSUserDefaults* ud;

@property (weak, nonatomic) IBOutlet UILabel *lessonNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lessonDetail;
@property (weak, nonatomic) IBOutlet UITextField *lessonNameField;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
- (IBAction)registerLesson:(id)sender;
- (IBAction)cancelButton:(id)sender;

@end
