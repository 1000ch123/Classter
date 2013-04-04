//
//  ismMainTabController.m
//  Classter
//
//  Created by kanade on 13/04/01.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import "ismMainTabController.h"


#import "ismTimeLine.h"
#import "ismTimeTable.h"
#import "ismBBS.h"
#import "ismContact.h"
#import "ismSetting.h"

@interface ismMainTabController ()

@end

@implementation ismMainTabController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		ismTimeLine *timeline = [[ismTimeLine alloc] init];
		ismTimeTable *timetable = [[ismTimeTable alloc] init];
		ismBBS *BBS = [[ismBBS alloc] init];
		ismContact *contact = [[ismContact alloc] init];
		ismSetting *setting = [[ismSetting alloc] initWithStyle:UITableViewStyleGrouped];
		
		
		
		NSArray *controllers = [NSArray arrayWithObjects:
								[[UINavigationController alloc] initWithRootViewController:timeline],
								[[UINavigationController alloc] initWithRootViewController:timetable],
								[[UINavigationController alloc] initWithRootViewController:BBS],
								[[UINavigationController alloc] initWithRootViewController:contact],
								[[UINavigationController alloc] initWithRootViewController:setting],
								nil];
		[self setViewControllers:controllers animated:NO];
		[self.navigationItem setHidesBackButton:YES];
		
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
