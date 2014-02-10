//
//  HeadlineCell.h
//  ESPN Headlines
//
//  Created by Thomas Constantin on 13-08-26.
//  Copyright (c) 2013 Thomas Constantin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Headline.h"

@interface HeadlineCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextView *cellHeadline;
@property (weak, nonatomic) IBOutlet UITextView *cellLongTitle;
@property (weak, nonatomic) IBOutlet UIImageView *cellThumbnail;
@property (weak, nonatomic) IBOutlet UILabel *cellDate;
@property (weak, nonatomic) IBOutlet UITextView *articleLink;

-(void)setDetailsWithHeadline:(Headline*)headline;

@end
