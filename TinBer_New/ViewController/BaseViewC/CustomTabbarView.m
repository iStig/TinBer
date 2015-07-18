//
//  CustomTabbarView.m
//  Maybelline
//
//  Created by gongxuehan on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomTabbarView.h"

#define TAB_ITEM_COUNT 4
#define TAB_ITEM_WIDTH (self.frame.size.width / TAB_ITEM_COUNT)

#define TAB_IMG_FRAME               CGRectMake(0.0, 0, 80, 49)

@implementation TabImage

- (id)initWithFrame:(CGRect)frame index:(int)index
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSString *strNormalImage = nil;
        NSString *strSelectedImage = nil;
        
        CGRect imgFrame = frame;
        imgFrame.origin = CGPointZero;
        itemVImg = [[UIImageView alloc] initWithFrame:imgFrame];
        strNormalImage = [NSString stringWithFormat:@"TabBtn%d.png",index];
        strSelectedImage = [NSString stringWithFormat:@"TabBtnSelected%d.png",index];
        
//        itemVImg.contentMode = UIViewContentModeCenter;
        itemVImg.image = [UIImage imageNamed:strNormalImage];
        itemVImg.highlightedImage = [UIImage imageNamed:strSelectedImage];
        [self addSubview:itemVImg];
        [itemVImg release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    if (selected) {
        itemVImg.highlighted = YES;
    } else {
        itemVImg.highlighted = NO;
    }
    [self setNeedsDisplay];
}

@end

@implementation CustomTabbarView
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = TTClearColor;
        
        UIView * viewBg = [[UIView alloc] initWithFrame:self.bounds];
        viewBg.alpha = 0.5;
        viewBg.backgroundColor = TTRGBColor(254, 254, 254);
        [self addSubview:viewBg];
        [viewBg release];

        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWhite, 1)];
        line.backgroundColor = TTRGBColor(190, 190, 190);
        [self addSubview:line];
        [line release];
        
        _items = [[NSMutableArray alloc] initWithCapacity:5];
        for (int i = 0; i < TAB_ITEM_COUNT; i++) {
            CGRect frame = CGRectOffset(TAB_IMG_FRAME, 320/TAB_ITEM_COUNT *i, 0);
            TabImage *tabImg = [[TabImage alloc] initWithFrame:frame index:i];
            [self addSubview:tabImg];
            [tabImg release];
            [_items addObject:tabImg];
        }
        _lastItemIndex = -1;
    }
    return self;
}

- (void)selectedItemFrom:(SInt32)oldIndex to:(SInt32)curIndex
{
    _lastItemIndex = curIndex;
    if (oldIndex >= 0)
    {
        [[_items objectAtIndex:oldIndex] setSelected:NO];
    }
    if (curIndex >= 0) 
    {
        [[_items objectAtIndex:curIndex] setSelected:YES];
    }
}

//touches began
-(void)dispatchFirstTouchAtPoint:(CGPoint)touchPoint forEvent:(UIEvent *)event
{
    CGFloat index = floor(touchPoint.x / TAB_ITEM_WIDTH);
    if ([_delegate respondsToSelector:@selector(touchesBeganAt:)]) 
    {
        [_delegate touchesBeganAt:index];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	for (UITouch *touch in touches) {
		[self dispatchFirstTouchAtPoint:[touch locationInView:self] forEvent:nil];
	}	
}

//touches moved
-(void)dispatchTouchEvent:(UIView *)theView toPosition:(CGPoint)position
{
    CGFloat index = floor(position.x / TAB_ITEM_WIDTH);
//    if (_lastItemIndex != index)
//    {
        if ([_delegate respondsToSelector:@selector(tabbarIsMovedFrom:to:)])
        {
            [_delegate tabbarIsMovedFrom:_lastItemIndex to:index];
        }
//    }
//    _lastItemIndex = index;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	for (UITouch *touch in touches) {
		[self dispatchTouchEvent:[touch view] toPosition:[touch locationInView:self]];
	}
}
//touches ended
-(void)dispatchTouchEndEvent:(UIView *)theView toPosition:(CGPoint)position
{
    CGFloat index = floor(position.x / TAB_ITEM_WIDTH);
    if ([_delegate respondsToSelector:@selector(tabbarIsEndedAt:)])
    {
        [_delegate tabbarIsEndedAt:index];
    }
    [self selectedItemFrom:_lastItemIndex to:index];
    _lastItemIndex = index;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
		// Sends to the dispatch method, which will make sure the appropriate subview is acted upon
		[self dispatchTouchEndEvent:[touch view] toPosition:[touch locationInView:self]];
	}
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [_items release];
    [super dealloc];
}

@end
