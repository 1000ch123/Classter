//
//  ismBBSCommentList.m
//  Classter
//
//  Created by kanade on 13/04/06.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import "ismBBSCommentList.h"

@interface ismBBSCommentList ()

@end

@implementation ismBBSCommentList

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
		self.ud = [[NSUserDefaults alloc]init];
		self.api =[[ismWebApi alloc]init];
		
		self.api.mailAddress	= [self.ud objectForKey:@"mailaddress"];
		self.api.password		= [self.ud objectForKey:@"password"];
		self.api.userId			= [self.ud objectForKey:@"user_id"];
		self.api.groupId		= [self.ud objectForKey:@"group_id"];
		self.api.memberId		= [self.ud objectForKey:@"member_id"];
		
		self.api.threadId		= [self.ud objectForKey:@"thread_id"];
		
		offset = 0;
		limit = 100;
		
		NSDictionary* resDict = [self.api getComments:offset limit:limit];
		
		self.commentList = resDict[@"comments"];

		//バーボタンに＋マーク表示
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
	NSLog(@"comments reload");
	
	self.api.threadId		= [self.ud objectForKey:@"thread_id"];
	NSLog(@"thread_id:%@",self.api.threadId);
	
	NSDictionary* resDict = [self.api getComments:offset limit:limit];
	
	self.commentList = resDict[@"comments"];
	
	[self.tableView reloadData];
	
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.commentList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	// Configure the cell...
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
									  reuseIdentifier:@"Cell"];
	}
	// Configure the cell...
	
	NSLog(@"called making cell");
	if (self.commentList) {
		cell.textLabel.text = self.commentList[indexPath.row][@"title"];
		cell.detailTextLabel.text = self.commentList[indexPath.row][@"created"];
	}else{
		cell.textLabel.text = @"コメントがありません";
	}
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
	[self.ud setObject:self.commentList[indexPath.row][@"comment_id"] forKey:@"comment_id"];
	ismBBSCommentDetail* controller = [[ismBBSCommentDetail alloc]init];
	
	[self.navigationController pushViewController:controller animated:YES];
}

-(void)addButtonPushed{
	NSLog(@"add button pushed");
	ismBBSCommentPost* controller = [[ismBBSCommentPost alloc]init];
	[self presentViewController:controller animated:YES completion:nil];
}


@end
