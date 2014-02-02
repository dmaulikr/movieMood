//
//  SKYActivityIndicator.m
//  MovieMood
//
//  Created by Eric Lee on 2/2/14.
//  Copyright (c) 2014 Sky Apps. All rights reserved.
//

#import "SKYActivityIndicator.h"

@implementation SKYActivityIndicator

@synthesize activityIndicator = _activityIndicator;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGSize indicatorSize = CGSizeMake(frame.size.height * .7, frame.size.height * .7);
        NSLog(@"FIRE");
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((frame.size.width - indicatorSize.width) / 2,
                                                                                   (frame.size.height - indicatorSize.height) / 2,
                                                                                   indicatorSize.width, indicatorSize.height)];
        
        [self setBackgroundColor: [UIColor colorWithRed:242/255.f green:242/255.f blue:242/255.f alpha:.7]];
        self.layer.cornerRadius = 10;
        
        [_activityIndicator setColor:[self tintColor]];
        [self addSubview:_activityIndicator];
    }
    return self;
}
@end
