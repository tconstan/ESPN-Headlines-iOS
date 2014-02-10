//
//  HeadlineDetail.h
//  ESPN_api
//
//  Created by Thomas Constantin on 13-08-26.
//  Copyright (c) 2013 Thomas Constantin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Headline.h"

@interface HeadlineDetail : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *headlineMainImg;
@property (weak, nonatomic) IBOutlet UILabel *headlineMainTitle;
@property (weak, nonatomic) IBOutlet UITextView *headlineMainDesc;
@property (nonatomic,strong)IBOutlet UIButton *linkESPN;
@property (nonatomic, retain) Headline *headline;

- (IBAction) buttonLinkPressed:(id)sender;

@end
