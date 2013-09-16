//
//  SSProgressBar.m
//  SSProgressBar
//
//  Created by 束 永兴 on 13-9-13.
//  Copyright (c) 2013年 Candy. All rights reserved.
//

#import "SSProgressBar.h"
#import <QuartzCore/QuartzCore.h>

#define SSProgressBarInset 1

@implementation SSProgressBar
{
    float preProgress;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initProgressBar];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initProgressBar];
}

- (void)setProgressTintColor:(UIColor *)progressTintColor
{
    SAFE_ARC_RELEASE(progressTintColor);
    _progressTintColor = SAFE_ARC_RETAIN(progressTintColor);
}

- (UIColor *)progressTintColor
{
    if (!_progressTintColor) {
        [self setProgressTintColor:[UIColor greenColor]];
    }
    return _progressTintColor;
}

- (void)setTrackTintColor:(UIColor *)trackTintColor
{
    SAFE_ARC_RELEASE(trackTintColor);
    _trackTintColor = SAFE_ARC_RETAIN(trackTintColor);
}

- (UIColor *)trackTintColor
{
    if (!_trackTintColor) {
        [self setTrackTintColor:[UIColor blackColor]];
    }
    return _trackTintColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    SAFE_ARC_RETAIN(cornerRadius);
    _cornerRadius = SAFE_ARC_RETAIN(cornerRadius);
}

- (CGFloat)cornerRadius
{
    return _cornerRadius;
}

- (void)setInnerRadius:(CGFloat)innerRadius
{
    _innerRadius = SAFE_ARC_RETAIN(innerRadius);
}

- (CGFloat)innerRadius
{
    return _innerRadius;
}

- (void)setProgress:(float)progress
{
    SAFE_ARC_RETAIN(progress);
    _progress = SAFE_ARC_RETAIN(progress);
    if (_progress > _maxValue) {
        _progress = _maxValue;
    }
}

- (CGFloat)progress
{
    return _progress;
}

- (void)setOrientation:(SSProgressBarOrientation)orientation
{
    _orientation = SAFE_ARC_RETAIN(orientation);
}

- (SSProgressBarOrientation)orientation
{
    return _orientation;
}

- (void)initProgressBar
{
    _minValue = 0.0f;
    _maxValue = 1.0f;
    _orientation = SSProgressBarOrientationHorizontalLeft;
    self.progress = 0.0f;
    preProgress = self.progress;
    self.cornerRadius = 0.0f;
    self.innerRadius = 0.0f;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if (self.trackImage) {
        [self drawTrackImageBackgroundWithRect:rect];
    } else {
        [self drawBackgroundWithRect:rect];
    }
    if (self.progress > 0) {
        CGRect innerRect;
        switch (_orientation) {
            case SSProgressBarOrientationHorizontalLeft:
                innerRect = CGRectMake(SSProgressBarInset, SSProgressBarInset, rect.size.width * self.progress - 2*SSProgressBarInset, rect.size.height - 2*SSProgressBarInset);
                break;
            case SSProgressBarOrientationHorizontalRight:
                innerRect = CGRectMake(rect.size.width - SSProgressBarInset - (rect.size.width * self.progress - 2*SSProgressBarInset), SSProgressBarInset, rect.size.width * self.progress - 2*SSProgressBarInset, rect.size.height - 2*SSProgressBarInset);
                break;
            case SSProgressBarOrientationVerticalTop:
                innerRect = CGRectMake(SSProgressBarInset, SSProgressBarInset, rect.size.width - 2*SSProgressBarInset, rect.size.height *self.progress - 2*SSProgressBarInset);
                break;
            case SSProgressBarOrientationVerticalBottom:
                innerRect = CGRectMake(SSProgressBarInset, rect.size.height - SSProgressBarInset - (rect.size.height *self.progress - 2*SSProgressBarInset), rect.size.width - 2*SSProgressBarInset, rect.size.height *self.progress - 2*SSProgressBarInset);
                break;
            default:
                innerRect = CGRectMake(SSProgressBarInset, SSProgressBarInset, rect.size.width * self.progress - 2*SSProgressBarInset, rect.size.height - 2*SSProgressBarInset);
                break;
        }
        if (self.progressImage) {
            [self drawProgressImageWithRect:innerRect];
//            [self drawOverGlassWithRect:innerRect];
        } else {
            [self drawProgressBarWithRect:innerRect];
        }
    }
}

// Draw the background track
- (void)drawBackgroundWithRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *roundRect = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, rect.size.width, rect.size.height) cornerRadius:_cornerRadius];
    [roundRect addClip];
    
    CGContextSaveGState(context);
    {
        [self.trackTintColor set];
        UIBezierPath *roundRect = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, rect.size.width, rect.size.height) cornerRadius:_cornerRadius];
        [roundRect fill];
    }
    CGContextRestoreGState(context);
}

//Draw progressbar
- (void)drawProgressBarWithRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    {
        [self.progressTintColor set];
        UIBezierPath *roundRect = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(rect.origin.x+SSProgressBarInset, rect.origin.y+SSProgressBarInset, rect.size.width - 2*SSProgressBarInset, rect.size.height - 2*SSProgressBarInset) cornerRadius:_innerRadius];
        [roundRect fill];
    }
    CGContextRestoreGState(context);
}

//Draw glass over progressview
//demo
- (void)drawOverGlassWithRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat colors[8] = {
        .18, .74, 1, 1,
        1,  1,  1,  0.75
    };
    fillRectWithLinearGradient(ctx, rect, colors, 2, nil);
}

//Draw track background image
- (void)drawTrackImageBackgroundWithRect:(CGRect)rect
{
    UIImage *imgBg = self.trackImage;
    imgBg = [imgBg stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    UIImageView *igvBg = [[UIImageView alloc] initWithFrame:rect];
    [igvBg setImage:imgBg];
    [self addSubview:igvBg];
}

//Draw progress track image
- (void)drawProgressImageWithRect:(CGRect)rect;
{
    UIImage *imgPgsBg = self.progressImage;
    imgPgsBg = [imgPgsBg stretchableImageWithLeftCapWidth:0 topCapHeight:0];

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, rect.size.width, rect.size.height, 8, 4 * rect.size.width, colorSpace, 1);
    NSLog(@"context = %@", context);
    CGRect arect = CGRectMake(0, 0, rect.size.width, rect.size.height);
    
    CGContextBeginPath(context);
    addRoundedRectToPath(context, arect, 5, 5);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), imgPgsBg.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIImage *rounedImage = [[UIImage alloc] initWithCGImage:imageMasked];
    CGImageRelease(imageMasked);
    
    CGRect igvPgsRect = CGRectMake(rect.origin.x +SSProgressBarInset, rect.origin.y + SSProgressBarInset, rect.size.width - 2*SSProgressBarInset, rect.size.height - 2*SSProgressBarInset);
    UIImageView *igvPgs = [[UIImageView alloc] initWithFrame:igvPgsRect];
    igvPgs.layer.cornerRadius = _innerRadius;
    igvPgs.layer.backgroundColor = [UIColor clearColor].CGColor;
    [igvPgs setImage:rounedImage];
    [self addSubview:igvPgs];
}

//Draw round
static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
                                 float ovalHeight)
{
    float fw,fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

static void fillRectWithLinearGradient(CGContextRef context, CGRect rect, CGFloat colors[], int numberOfColors, CGFloat locations[]) {
	CGContextSaveGState(context);
	
	if(!CGContextIsPathEmpty(context))
		CGContextClip(context);
	
	CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
	CGPoint start = CGPointMake(0, 0);
	CGPoint end = CGPointMake(0, rect.size.height);
	
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(space, colors, locations, numberOfColors);
	CGContextDrawLinearGradient(context, gradient, end, start, 0);
	CGContextRestoreGState(context);
	
	CGColorSpaceRelease(space);
	CGGradientRelease(gradient);
}

@end
