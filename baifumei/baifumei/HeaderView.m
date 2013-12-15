//
//  HeaderView.m
//  baifumei
//
//  Created by Zhu Zhihai on 13-12-15.
//  Copyright (c) 2013年 Zhu Zhihai. All rights reserved.
//

#import "HeaderView.h"
#define kImgH   30.0f
#define kImgW   30.0f
#define kLNH     30.0f
#define kLNW     100.0f
#define kLDH     30.0f
#define KLDW     100.0f

#define kPadding   15.0f
@implementation HeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame Name:(NSString *)name ImageUrl:(NSString *)imgUrl Date:(NSString *)dateStr
{
    self = [super initWithFrame:frame];
    if (self) {
        float height = frame.size.height;
        float width = frame.size.width;
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kPadding, (height - kImgH) *.5, kImgW, kImgH)];
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_iconImageView.frame.origin.x + kPadding, (height - kLNH) *.5, kLNW, kLNH)];
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake((width - KLDW) - 5, (height - kLDH) *.5, KLDW, kLDH)];
        [self addSubview:_iconImageView];
        [self addSubview:_nameLabel];
        [self addSubview:_dateLabel];
        
        dispatch_queue_t queue = dispatch_queue_create("queue", NULL);
        dispatch_async(queue, ^{
            UIImage *img = [UIImage imageWithContentsOfFile:imgUrl];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.iconImageView setImage:img];
            });
        });
        [self.nameLabel setText:name];
        [self.nameLabel setTextColor:[UIColor blackColor]];
        [self.nameLabel setFont:[UIFont systemFontOfSize:15]];
        
        [self.dateLabel setText:dateStr];
        [self.dateLabel setTextColor:[UIColor grayColor]];
        [self.dateLabel setFont:[UIFont systemFontOfSize:10]];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
