//
//  HeadlineDetail.m
//  ESPN_api
//
//  Created by Thomas Constantin on 13-08-26.
//  Copyright (c) 2013 Thomas Constantin. All rights reserved.
//

#import "HeadlineDetail.h"

@interface HeadlineDetail ()

@end

@implementation HeadlineDetail

@synthesize headlineMainDesc;
@synthesize headlineMainImg;
@synthesize headlineMainTitle;
@synthesize linkESPN;
@synthesize headline;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) { // if iOS 7
        self.edgesForExtendedLayout = UIRectEdgeNone; //layout adjustements
    }
    
    headlineMainImg.image = [UIImage imageWithData:headline.imageData];
    headlineMainTitle.text = headline.longName;
    headlineMainDesc.text = headline.story;
    
    
    // Do any additional setup after loading the view from its nib.
}

- (IBAction) buttonLinkPressed:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:headline.articleLink]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
