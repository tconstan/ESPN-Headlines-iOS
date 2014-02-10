//
//  Headline.m
//  ESPN
//
//  Created by Thomas Constantin on 13-08-25.
//  Copyright (c) 2013 Thomas Constantin. All rights reserved.
//

#import "Headline.h"

@implementation Headline

@synthesize name;
@synthesize longName;
@synthesize created;
@synthesize thumbNail;
@synthesize imageData;
@synthesize story;
@synthesize articleLink;

-(void)loadData
{
    NSURL* url = [NSURL URLWithString:self.thumbNail];
    self.imageData = [NSData dataWithContentsOfURL:url];
}

@end
