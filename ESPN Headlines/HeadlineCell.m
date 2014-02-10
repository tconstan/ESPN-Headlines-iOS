//
//  HeadlineCell.m
//  ESPN Headlines
//
//  Created by Thomas Constantin on 13-08-26.
//  Copyright (c) 2013 Thomas Constantin. All rights reserved.
//

#import "HeadlineCell.h"

@implementation HeadlineCell

@synthesize cellHeadline;
@synthesize cellThumbnail;
@synthesize cellDate;
@synthesize cellLongTitle;
@synthesize articleLink;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDetailsWithHeadline:(Headline*)headline
{
    /*
    NSString *headlineTitle = nil;
    //NSString *headlineCellDate = [NSString stringWithString:headline.created];
    
    headlineTitle = headline.name;
    
    cellHeadline.text = headlineTitle;
    //cellDate.text = headlineCellDate;
    */
    dispatch_queue_t imageQueue = dispatch_queue_create("Image Queue",NULL);

    if(headline.imageData)
    {
        dispatch_async(imageQueue, ^{
            UIImage *image = [UIImage imageWithData:headline.imageData];
            NSString *headlineTitle = headline.name;
            NSString *headlineCellLongTitle = headline.longName;
            NSString *headlineCellDate = headline.created;
            NSString *webLink = headline.articleLink;
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
            [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-5]];
            NSDate *date = [dateFormatter dateFromString:headlineCellDate];
            
            NSDateFormatter* df = [[NSDateFormatter alloc]init];
            [df setDateFormat:@"hh:mm a"];
            NSString *minuteDate = [df stringFromDate:date];
            
            [df setDateFormat:@"MMM d"];
            NSString *yearDate = [df stringFromDate:date];
            
            headlineCellDate = @"Last update: ";
            headlineCellDate = [headlineCellDate stringByAppendingString:minuteDate];
            headlineCellDate = [headlineCellDate stringByAppendingString:@", "];
            headlineCellDate = [headlineCellDate stringByAppendingString:yearDate];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                cellThumbnail.image = image;
                cellHeadline.text = headlineTitle;
                cellDate.text = headlineCellDate;
                cellLongTitle.text = headlineCellLongTitle;
                articleLink.text = webLink;
            });
        });
        
    }else{
        [headline loadData];
        
        dispatch_async(imageQueue, ^{
            UIImage *image = [UIImage imageWithData:headline.imageData];
            NSString *headlineTitle = headline.name;
            NSString *headlineCellLongTitle = headline.longName;
            NSString *headlineCellDate = headline.created;
            NSString *webLink = headline.articleLink;
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
            [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:-5]];
            NSDate *date = [dateFormatter dateFromString:headlineCellDate];
            
            NSDateFormatter* df = [[NSDateFormatter alloc]init];
            [df setDateFormat:@"hh:mm a"];
            NSString *minuteDate = [df stringFromDate:date];
            
            [df setDateFormat:@"MMM d"];
            NSString *yearDate = [df stringFromDate:date];
            
            headlineCellDate = @"Last update: ";
            headlineCellDate = [headlineCellDate stringByAppendingString:minuteDate];
            headlineCellDate = [headlineCellDate stringByAppendingString:@", "];
            headlineCellDate = [headlineCellDate stringByAppendingString:yearDate];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                cellThumbnail.image = image;
                cellHeadline.text = headlineTitle;
                cellDate.text = headlineCellDate;
                cellLongTitle.text = headlineCellLongTitle;
                articleLink.text = webLink;
            });
        });
    }
    
    
}

@end
