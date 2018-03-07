//
//  EcoComsumableItemLeftView.m
//  ProgressDemo
//
//  Created by Vivien on 2017/12/23.
//  Copyright © 2017年 ecovacs. All rights reserved.
//

#import "EcoComsumableItemLeftView.h"
// 将常数转换为度数
#define  DEGREES(degrees)  ((M_PI * (degrees))/ 180.f)
#define  kAnimationDuration 1

@interface EcoComsumableItemLeftView()<CAAnimationDelegate>

@property (nonatomic, strong) CAShapeLayer *shapeLayer;//底部陪衬的Layer
@property (nonatomic, strong) CAShapeLayer *progressLayer;//具体表示值的Layer
@property (nonatomic, strong) UIColor *currentStrokcolor;//当前progressLayer Stroke Color
@property (nonatomic, strong) UIBezierPath *path ;//
@property (nonatomic, strong) UILabel *titleLabel; //顶部提示
@property (nonatomic, strong) UILabel *hintLabel;//底部的提示Label
@property (nonatomic, strong) UILabel *percentLabel;//% Label
@property (nonatomic, strong) UILabel *bottomTitleLabel;//XX剩余
@property (nonatomic, copy) NSString *percentText;

@property (nonatomic, strong) UILabel *zeroLabel; //0%Label
@property (nonatomic, strong) UILabel *hundredLabel; //100%Label
@property (nonatomic, strong) UILabel *numberLabel; //中间数字的Label,动画时会随着变动

//动画用
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int valueProgeress;//


@end
@implementation EcoComsumableItemLeftView


- (void)initViews
{
    [super initViews];
    
    _percentText = @"%";
    
    _progressStrokeColor = UIColorFromRGB(0x005eb8);
    _warningStoreColor = UIColorFromRGB(0xe40046);
    _currentStrokcolor = _progressStrokeColor;
    _warnValue = 5;
    
    [self addSubview:self.hintLabel];
    [self addSubview:self.numberLabel];
    [self addSubview:self.hundredLabel];
    [self addSubview:self.zeroLabel];
    [self addSubview:self.percentLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.bottomTitleLabel];
    
}


- (void)setLayout
{
    WS(ws);

    [_hintLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws);
        make.height.mas_equalTo(kHeightPro(88));
        make.bottom.mas_equalTo(ws);
    }];
    [_numberLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(ws);
        make.height.mas_equalTo(kHeightPro(231));
    }];
    
    
    [_hundredLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_numberLabel.mas_centerY).mas_offset(kWidthPro(440));
        make.centerX.mas_equalTo(_numberLabel).offset(-kWidthPro(270));
    }];
    
    [_zeroLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.mas_equalTo(_hundredLabel);
        make.centerX.mas_equalTo(_numberLabel).offset(kWidthPro(270));
    }];
    
    [_percentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_numberLabel);
        make.centerX.mas_equalTo(_numberLabel).offset(kWidthPro(216));
    }];
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_numberLabel).offset(-kWidthPro(178));
        make.centerX.mas_equalTo(_numberLabel);
    }];
    
    [_bottomTitleLabel  mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.centerX.mas_equalTo(_numberLabel);
         make.bottom.mas_equalTo(_zeroLabel);
    }];
    
//    NSLog(@"self.center:%@,self.height:%f",NSStringFromCGPoint(self.center),self.frame.size.height);
    if (self.center.x == 0) {
        return;
    }else{
        if (!_shapeLayer) {
            [self.path addArcWithCenter:_numberLabel.center radius:kWidthPro(900)/2 startAngle:DEGREES(420) endAngle:DEGREES(120) clockwise:NO];
            self.shapeLayer.path = _path.CGPath;
        }
    }
}

- (void)setZeroText:(NSString *)str
{
    _zeroLabel.text = str;
}
- (void)setHundredText:(NSString *)str
{
    _hundredLabel.text = str;
}
- (void)setBottomTitleText:(NSString *)text
{
    _bottomTitleLabel.hidden = NO;
    _bottomTitleLabel.text = text;
}
- (void)setBottomHintText:(NSString *)str
{
    _hintLabel.text = str;
}

- (void)setTopLeftValue:(int )hour
{
    NSString *str = [NSString stringWithFormat:@"预计剩余%d小时",hour];
    [self setTopHintText:str];
}
- (void)setTopHintText:(NSString *)text
{
    _titleLabel.hidden = NO;
    _titleLabel.text = text;
}

- (void)setLeftValue:(int)leftValue
{
    _leftValue = leftValue;
    if (_leftValue <= _warnValue) {
        _currentStrokcolor = _warningStoreColor;
        _numberLabel.textColor = _warningStoreColor;
    }else{
        _currentStrokcolor = _progressStrokeColor;
        _numberLabel.textColor = UIColorFromRGB(0x253746);
    }
}

- (void)startAnimationWithProgress:(int)number
{
    NSLog(@"startAnimationWithProgress:%d,tag:%ld",number,(long)self.tag);
    _valueProgeress = 0;
     [self setLeftValue:number];
    
    [_timer invalidate];
    _timer = nil;
    
    [_progressLayer removeFromSuperlayer];
    _progressLayer = nil;
    
    float end = 100.0;
    CGFloat  value = _leftValue/end;
    
    //Add shape animation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = kAnimationDuration ;
    animation.fromValue = 0;
    animation.toValue = @(value);
    animation.delegate = self;
    [self.progressLayer addAnimation:animation forKey:@"Progress"];
    _progressLayer.strokeColor =  _currentStrokcolor.CGColor;
    
    CFTimeInterval timerInterval = kAnimationDuration*1.00f/ABS(_leftValue);
    
    // 创建定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:timerInterval
                                              target:self
                                            selector:@selector(animationEvent)
                                            userInfo:nil
                                             repeats:YES];
}

- (void)animationEvent
{
    _valueProgeress++;
    [_numberLabel setText: [NSString stringWithFormat:@"%d",_valueProgeress]];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [_numberLabel setText:[NSString stringWithFormat:@"%d",_leftValue]];
    [_timer invalidate];
    _timer = nil;
}


#pragma mark ———— 视图初始化
- (UILabel *)hintLabel
{
    if (_hintLabel == nil)
    {
        _hintLabel = [[UILabel alloc]init];
        _hintLabel.text = @"建议：当XX剩余低于5%，请及时更换XX噢～";//Str_Material_Hint;
        _hintLabel.textAlignment = NSTextAlignmentCenter;
        _hintLabel.numberOfLines = 0;
        _hintLabel.font = [UIFont  systemFontOfSize: kWidthPro(40)];
        [_hintLabel setTextColor:UIColorFromRGB(0x253746)];
    }
    return _hintLabel;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont  systemFontOfSize: kWidthPro(50)];
        [_titleLabel setTextColor:UIColorFromRGB(0x253746)];
        [_titleLabel sizeToFit];
        _titleLabel.hidden = YES;
    }
    return _titleLabel;
}
- (UILabel *)bottomTitleLabel
{
    if (!_bottomTitleLabel) {
        _bottomTitleLabel = [[UILabel alloc]init];
        _bottomTitleLabel.textAlignment = NSTextAlignmentCenter;
        _bottomTitleLabel.font = [UIFont  systemFontOfSize: kWidthPro(50)];
        [_bottomTitleLabel setTextColor:UIColorFromRGB(0x253746)];
        [_bottomTitleLabel sizeToFit];
        _bottomTitleLabel.text = @"XX剩余";
//        _bottomTitleLabel.hidden = YES;
    }
    return _bottomTitleLabel;
}

- (UILabel *)percentLabel
{
    if (!_percentLabel) {
        _percentLabel = [[UILabel alloc]init];
        _percentLabel.text = @"%";
        _percentLabel.textAlignment = NSTextAlignmentCenter;
        _percentLabel.font = [UIFont  systemFontOfSize: kWidthPro(74)];
        [_percentLabel setTextColor:UIColorFromRGB(0x253746)];
        [_percentLabel sizeToFit];
    }
    return _percentLabel;
}

- (UILabel *)zeroLabel
{
    if (!_zeroLabel) {
        _zeroLabel = [[UILabel alloc]init];
        _zeroLabel.text = @"0%";
        _zeroLabel.textAlignment = NSTextAlignmentCenter;
        _zeroLabel.font = [UIFont  systemFontOfSize: kWidthPro(50)];
        [_zeroLabel setTextColor:UIColorFromRGB(0x253746)];
    }
    return _zeroLabel;
}


- (UILabel *)hundredLabel
{
    if (!_hundredLabel) {
        _hundredLabel = [[UILabel alloc]init];
        _hundredLabel.text = @"100%";
        _hundredLabel.textAlignment = NSTextAlignmentCenter;
        _hundredLabel.font = [UIFont  systemFontOfSize: kWidthPro(50)];
        [_hundredLabel setTextColor:UIColorFromRGB(0x253746)];
    }
    return _hundredLabel;
}


- (UIBezierPath *)path
{
    if (!_path) {
        _path = [UIBezierPath bezierPath];
    }
    return _path;
}

- (CAShapeLayer *)shapeLayer
{
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer.strokeColor = UIColorFromRGB(0xdfe1d3).CGColor;
        _shapeLayer.lineWidth  =  kWidthPro(32);
        _shapeLayer.lineCap = kCALineCapRound;
        [self.layer insertSublayer:_shapeLayer atIndex:0];
    }
    return _shapeLayer;
}

- (UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.text = @"0";
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.font = [UIFont  boldSystemFontOfSize: kWidthPro(224)]; 
        [_numberLabel setTextColor:UIColorFromRGB(0x253746)];
        [_numberLabel sizeToFit];
    }
    return _numberLabel;
}

- (CAShapeLayer *)progressLayer
{
    if (!_progressLayer) {
        // 创建CAShapeLayer
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.frame = _shapeLayer.bounds;
        _progressLayer.position = _shapeLayer.position;
        // 修改CAShapeLayer的线条相关值
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.lineWidth = kWidthPro(32);
        _progressLayer.lineCap = kCALineCapRound;
        _progressLayer.strokeStart = DEGREES(0);
        _progressLayer.strokeEnd = 0.f;
        // _progressLayer.strokeColor = RGBColor(0x3c, 0x9c, 0xfe).CGColor;
        // 建立贝塞尔曲线与CAShapeLayer之间的关联
        _progressLayer.path = self.path.CGPath;
        // 添加并显示
        [self.layer insertSublayer:_progressLayer above:self.shapeLayer];
    }
    return _progressLayer;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setLayout];
}

@end

