//
//  CustomTabbarView.h
//  Maybelline
//
//  Created by gongxuehan on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabImage : UIView 
{
    UIImageView *itemVImg;
    UILabel *label;
}
- (id)initWithFrame:(CGRect)frame index:(int)index;
- (void)setSelected:(BOOL)selected;
@end


@protocol CustomTabbarViewDelegate;
@interface CustomTabbarView : UIView
{
    NSMutableArray              *_items;
    SInt32                      _lastItemIndex;
//    id<CustomTabbarViewDelegate> _delegate;
}

@property (nonatomic, assign) id<CustomTabbarViewDelegate> delegate;
- (void)selectedItemFrom:(SInt32)oldIndex to:(SInt32)curIndex ;

@end
@protocol CustomTabbarViewDelegate <NSObject>

- (void)touchesBeganAt:(SInt32)index;
- (void)tabbarIsMovedFrom:(SInt32)oldIndex to:(SInt32)curIndex;
- (void)tabbarIsEndedAt:(SInt32)curIndex;

@end