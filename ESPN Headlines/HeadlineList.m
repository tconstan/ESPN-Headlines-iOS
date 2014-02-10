//
//  HeadlineList.m
//  ESPN_api
//
//  Created by Thomas Constantin on 13-08-26.
//  Copyright (c) 2013 Thomas Constantin. All rights reserved.
//

#import "HeadlineList.h"
#import "HeadlineCell.h"
#import "HeadlineDetail.h"
#import "SBJson.h"
#import "Headline.h"

@interface HeadlineList ()

@end

@implementation HeadlineList

@synthesize headlines;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        //
    }
    return self;
}

-(void) optionsButtonSelected:(id)button {
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 70, 40 );
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

- (void)viewDidLoad
{
    [self loadHeadlines];
    [super viewDidLoad];
    
    self.navigationItem.title = @"ESPN Headlines";
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:nil action:@selector(updateHeadlines) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    _optionsButton = [[UIBarButtonItem alloc] initWithTitle:@"Options"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(showPicker:)];
    self.navigationItem.rightBarButtonItem = self.optionsButton;
}

-(void) updateHeadlines{
    [self loadHeadlines];
    [self.refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [headlines count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    HeadlineCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray* objects = [[NSBundle mainBundle] loadNibNamed:@"HeadlineCell" owner:self options:nil];
        
        for(id currentObject in objects){
            if([currentObject isKindOfClass:[UITableViewCell class]]){
                cell = (HeadlineCell *)currentObject;
                break;
            }
        }
    }
    
    Headline *headline = [headlines objectAtIndex:indexPath.row];

    [cell setDetailsWithHeadline:headline];
    // Configure the cell...
    
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
    HeadlineDetail *detail = [[HeadlineDetail alloc] initWithNibName:@"HeadlineDetail" bundle:nil];
    detail.headline = [headlines objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)loadHeadlines
{
    NSString *url = @"http://api.espn.com/v1/sports/news/headlines/top?apikey=49a4zue63nk8xhz2aubajp38";
    
    dispatch_queue_t itemQueue = dispatch_queue_create("Image Queue",NULL);
    
    dispatch_async(itemQueue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });
    
    // Create new SBJSON parser object
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    // Prepare URL reques to download statuses from ESPN
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    // Perform request and get JSON back as a NSData object
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    // Get JSON as a NSString from NSData response
    NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    NSDictionary *headlineDictionary = [parser objectWithString:json_string];
    
    NSArray *headlineArray = (NSArray*)[headlineDictionary objectForKey:@"headlines"];
    
    self.headlines = [[NSMutableArray alloc] init];
    
    
    for(NSDictionary* dict in headlineArray)
    {
        Headline *headlineNews = [[Headline alloc] init];
        
        headlineNews.name = [dict objectForKey:@"headline"];
        headlineNews.longName = [dict objectForKey:@"title"];
        headlineNews.created = [dict objectForKey:@"published"];
        headlineNews.story = [dict objectForKey:@"description"];
        
        NSArray *images = [dict objectForKey:@"images"];
        headlineNews.thumbNail = [images[0] objectForKey:@"url"];
        
        /*for(NSDictionary* image in imagesArray)
        {
            headlineNews.thumbNail = [image objectForKey:@"url"];
        }*/
        
        NSDictionary *linksArray = [dict objectForKey:@"links"];
        NSDictionary *webArray = [linksArray objectForKey:@"mobile"];
        headlineNews.articleLink = [webArray objectForKey:@"href"];
        
        
        [headlines addObject:headlineNews];
    }
    
     
    [self.tableView reloadData];
}

@end
