//
//  JMAnimationNumberView.m
//  TinBer_New
//
//  Created by iStig on 15/7/16.
//  Copyright (c) 2015年 shentingting. All rights reserved.
//

#import "JMAnimationNumberView.h"
#import "ADTickerLabel.h"
@interface JMAnimationNumberView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) ADTickerLabel *numberLabel;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@end

@implementation JMAnimationNumberView

+ (instancetype)layoutNumberView {
    return [[JMAnimationNumberView alloc] init];
}

- (instancetype)init {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        CGRect rect = CGRectMake(0, 0, 240, 240);
        self.frame = rect;
        _backgroundImageView = [[UIImageView alloc] initWithFrame:rect];
        _backgroundImageView.image = [UIImage imageNamed:@"jm_img_number_background"];
        [self addSubview:_backgroundImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((240 - 82)/2, 69, 82, 16)];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.text = @"当前金币";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithRed:136.f/255.f green:136.f/255.f blue:136.f/255.f alpha:1.0];
        [self addSubview:_titleLabel];
        
        UIFont *font = [UIFont systemFontOfSize:45];
        _numberLabel = [[ADTickerLabel alloc] initWithFrame:CGRectMake((240 - 139)/2, CGRectGetMaxY(_titleLabel.frame)+20, 139, 30)];
        _numberLabel.textColor =  [UIColor colorWithRed:249.f/255.f green:69.f/255.f blue:61.f/255.f alpha:1.0];
        _numberLabel.font = font;
        _numberLabel.backgroundColor = [UIColor clearColor];
        _numberLabel.characterWidth = 24;
        _numberLabel.changeTextAnimationDuration = 0.5;
        [self addSubview:_numberLabel];
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setNumber:(NSString *)number {
    self.numberLabel.text = number;
}



@end
