//
//  ismTimeTable.h
//  Classter
//
//  Created by kanade on 13/04/01.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ismTimeTableComments.h"
#import "ismTimeTableAdd.h"

#define MAX_CATEGORY 7
#define MAX_SUBCATEGORY 7

@interface ismTimeTable : UITableViewController{
	NSArray* categories;
	NSArray* subcategories;
	
	int countTable[MAX_CATEGORY][MAX_SUBCATEGORY];
}

@property NSMutableDictionary *LessenDict;		//dict[category][subcategory]でNSArrayを格納．時間割ビューで用いる
@property NSMutableDictionary *LessonListDict;	//dict[category]でNSArrayを格納．リスト系で用いる．目下はこっちかな
//	@property NSMutableArray *array;

@property ismWebApi *api;
@property NSUserDefaults *ud;


// 2段dictにしましょう．
// 1st key: @"MON",@"TUE",@"WED",@"THU",@"FRI",@"SAT",@"ETC" //section
// 2nd key: @"1", @"2", @"3", @"4",@"5",@"6",@"ETC",@"rows" //rows
// value: NSArray.

@end
