//
//  ismBBS.m
//  Classter
//
//  Created by kanade on 13/04/01.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import "ismBBS.h"

@interface ismBBS ()

@end

@implementation ismBBS

- (id)initWithStyle:(UITableViewStyle)style
{
	NSLog(@"bbs view initialized");
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
		self.title = @"BBS";
		
		self.ud = [[NSUserDefaults alloc]init];
		self.api =[[ismWebApi alloc]init];
		
		self.api.mailAddress	= [self.ud objectForKey:@"mailaddress"];
		self.api.password		= [self.ud objectForKey:@"password"];
		self.api.userId			= [self.ud objectForKey:@"user_id"];
		self.api.groupId		= [self.ud objectForKey:@"group_id"];
		self.api.memberId		= [self.ud objectForKey:@"member_id"];
		
		NSLog(@"make ismBBS.%@",self.api.userId);
		
		
		NSDictionary* resDict = [self.api getThreads];
		NSArray* threadList = resDict[@"threads"];
		
		NSMutableArray* bbsList = [@[] mutableCopy];
		
		for (NSDictionary* thread in threadList) {
			if ([thread[@"category"] isEqualToString:@"BBS"]) {
				[bbsList addObject:thread];
			}
		}
		
		self.threadList = bbsList;
		
		
		//self.threadList = [[NSArray alloc] initWithObjects:@"hello",@"hello2", nil];
		
		UIBarButtonItem* plus = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
																			 target:self
																			 action:@selector(addButtonPushed)];
		self.navigationItem.rightBarButtonItem = plus;

	}
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSLog(@"bbs view loaded");
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;


}

-(void)viewWillAppear:(BOOL)animated{
	
	if (![_ud boolForKey:@"reloadData"]) {
		return;
	}
	
	[_ud setBool:NO forKey:@"reloadData"];
	
	NSLog(@"thread reload!");
	NSDictionary* resDict = [self.api getThreads];
	NSArray* threadList = resDict[@"threads"];
	
	NSMutableArray* bbsList = [@[] mutableCopy];
	
	for (NSDictionary* thread in threadList) {
		if ([thread[@"category"] isEqualToString:@"BBS"]) {
			[bbsList addObject:thread];
		}
	}
	
	[self.tableView reloadData];
	return;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.threadList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	// Configure the cell...
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithFrame:CGRectZero
									  reuseIdentifier:@"Cell"];
	}
	//NSLog(@"%@",self.threadList);
	cell.textLabel.text = self.threadList[indexPath.row][@"name"];//[self.threadList objectAtIndex:indexPath.row];
	
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
	
	
	[_ud setBool:YES forKey:@"reloadData"];
	
	ismBBSCommentList *commentBBS = [[ismBBSCommentList alloc] init];
	
	[self.ud setObject:self.threadList[indexPath.row][@"thread_id"] forKey:@"thread_id"];
	[self.navigationController pushViewController:commentBBS animated:YES];

}


-(void)addButtonPushed{
	NSLog(@"add button pushed");
	
	ismBBSThreadAdd* controller = [[ismBBSThreadAdd alloc]init];
	[self presentViewController:controller animated:YES completion:nil];
}

@end
