//
//  ismTimeTableComments.m
//  Classter
//
//  Created by kanade on 13/04/03.
//  Copyright (c) 2013年 kanade. All rights reserved.
//

#import "ismTimeTableComments.h"

@interface ismTimeTableComments ()

@end

@implementation ismTimeTableComments

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

		NSLog(@"called next view");
		// Custom initialization
		self.ud = [NSUserDefaults standardUserDefaults];
		//API使う準備
		self.api = [[ismWebApi alloc]init];
		self.api.mailAddress = [self.ud objectForKey:@"mailaddress"];
		self.api.password = [self.ud objectForKey:@"password"];
		self.api.userId = [self.ud objectForKey:@"user_id"];
		self.api.groupId = [self.ud objectForKey:@"group_id"];
		self.api.memberId = [self.ud objectForKey:@"member_id"];
		
		NSDictionary* tmpThread = [self.ud objectForKey:@"tmpthread"];
		NSLog(@"into thread:%@",tmpThread);
		
		NSLog(@"select lesson: thread-id:%@",[NSString stringWithFormat:@"%@",tmpThread[@"thread_id"]]);
		self.api.threadId = [NSString stringWithFormat:@"%@",tmpThread[@"thread_id"]];
		self.navigationItem.title = tmpThread[@"name"];
		
		[self.ud setObject:self.api.threadId forKey:@"thread_id"];
		
		int offset = 0;
		int limit = 100;
		
		NSLog(@"call get comments");
		NSMutableDictionary* resdict = [self.api getComments:offset limit:limit];
		
		NSLog(@"%@",resdict);
		NSLog(@"dict of comments");
		
		commentList = resdict[@"comments"];
		
		UIBarButtonItem* plus = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
																			  target:self
																			  action:@selector(postNewComment)];
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
	UIActivityIndicatorView* ai = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	ai.center = self.view.center;
	[self.view addSubview:ai];
	[ai startAnimating];
	
	int offset = 0;
	int limit = 100;
	NSMutableDictionary* resdict = [self.api getComments:offset limit:limit];
	commentList = resdict[@"comments"];
	[self.tableView reloadData];
	
	[ai stopAnimating];
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
	if (![commentList isEqual: @{}]) {
		NSLog(@"called table section rows");
		return [commentList count];
	}else{
		return 1;
	}
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
	if (commentList) {
		cell.textLabel.text = commentList[indexPath.row][@"title"];
		cell.detailTextLabel.text = commentList[indexPath.row][@"created"];
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
	
	//コメント欄でないならリターン
	if ([commentList[indexPath.row] isEqual:nil]) {
		NSLog(@"this cell is not comment");
		return;
	}
	
	[self.ud setObject:commentList[indexPath.row][@"comment_id"] forKey:@"comment_id"];

ismTimeTableCommentDetail* detailView = [[ismTimeTableCommentDetail alloc] init];
[self.navigationController pushViewController:detailView animated:YES];
}

-(void)postNewComment{
	ismTimeTableCommentPost* postView = [[ismTimeTableCommentPost alloc] init];
	//[self.navigationController pushViewController:postView animated:YES];
	
	NSLog(@"post will thread:%@",[self.ud objectForKey:@"tmpthread"][@"thread_id"]);
	[self presentViewController:postView animated:YES completion:nil];
}

@end
