//
//  HeadlineList.h
//  ESPN_api
//
//  Created by Thomas Constantin on 13-08-26.
//  Copyright (c) 2013 Thomas Constantin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadlineList : UITableViewController

@property (nonatomic, retain) NSMutableArray *headlines;
@property (nonatomic, strong) UIBarButtonItem *optionsButton;

- (void)loadHeadlines;

@end
