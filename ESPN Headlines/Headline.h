//
//  Headline.h
//  ESPN
//
//  Created by Thomas Constantin on 13-08-25.
//  Copyright (c) 2013 Thomas Constantin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Headline : NSObject


@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *longName;
@property (nonatomic, copy) NSString *created;
@property (nonatomic, copy) NSString *thumbNail;
@property (nonatomic, copy) NSString *story;
@property (nonatomic, copy) NSString *articleLink;
@property (nonatomic, retain) NSData* imageData;

-(void)loadData;

@end
