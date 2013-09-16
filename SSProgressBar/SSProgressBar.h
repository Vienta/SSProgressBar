//
//  SSProgressBar.h
//  SSProgressBar
//
//  Created by 束 永兴 on 13-9-13.
//  Copyright (c) 2013年 Candy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SSProgressBarOrientation) {
    SSProgressBarOrientationHorizontalLeft,     //水平方向 从左开始
    SSProgressBarOrientationHorizontalRight,    //水平方向 从右开始
    SSProgressBarOrientationVerticalTop,        //垂直方向 从上开始
    SSProgressBarOrientationVerticalBottom,     //垂直方向 从下开始
};

@interface SSProgressBar : UIView
{
    UIColor *_progressTintColor;
    UIColor *_trackTintColor;
    CGFloat _cornerRadius;
    CGFloat _innerRadius;
    float _progress;
    float _maxValue;
    float _minValue;
    SSProgressBarOrientation _orientation;
}

@property (nonatomic) float progress;
@property (nonatomic, SAFE_ARC_PROP_RETAIN) UIColor *progressTintColor;
@property (nonatomic, SAFE_ARC_PROP_RETAIN) UIColor *trackTintColor;
@property (nonatomic, SAFE_ARC_PROP_RETAIN) UIImage *progressImage;
@property (nonatomic, SAFE_ARC_PROP_RETAIN) UIImage *trackImage;
@property (nonatomic) SSProgressBarOrientation orientation;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) CGFloat innerRadius;

@end
