//
//  EcoComsumableItemsBottomBtnView.m
//  ProgressDemo
//
//  Created by Vivien on 2017/12/23.
//  Copyright © 2017年 ecovacs. All rights reserved.
//

#import "EcoComsumableItemsBottomBtnView.h"
#define EcoComsumableItemsBottomBtnTAG   500

@interface EcoComsumableItemsBottomBtnView()
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) UIView *btnsView;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;
@end

@implementation EcoComsumableItemsBottomBtnView

- (void)initViews
{
    [super initViews];
    [self addSubview:self.btnsView];
    self.borderColor = UIColorFromRGB(0x005eb8);
    _borderWidth = 2;
}


- (void)setTitleArr:(NSArray *)titleArr
{
    _titleArr = [[NSArray alloc]initWithArray:titleArr];
    [self addSubviews];
}

- (void)setBorderColor:(UIColor *)color
{
    _borderColor = color;
    _btnsView.layer.borderColor = _borderColor.CGColor;
}
- (void)setBorderWidth:(CGFloat)width
{
    _borderWidth = width;
}

- (void)bottomBtnClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if(self.bottomBtnClicked){
        self.bottomBtnClicked((int)btn.tag - EcoComsumableItemsBottomBtnTAG);
    }
}

- (void)addSubviews
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    
    [_titleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *tempBtn = [[UIButton alloc]init];
        tempBtn.tag = EcoComsumableItemsBottomBtnTAG + idx;
        [tempBtn addTarget:self action:@selector(bottomBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [tempBtn setTitle:_titleArr[idx] forState:UIControlStateNormal];
        [tempBtn setTitleColor:_borderColor forState:UIControlStateNormal];
        [_btnsView addSubview:tempBtn];
        UIView *lineView = [[UIView alloc]init];
        lineView.tag = EcoComsumableItemsBottomBtnTAG*2 + idx;
        lineView.backgroundColor = _borderColor;
        [_btnsView addSubview:lineView];
    }];
    
}
- (void)setLayout
{
    if ( _titleArr.count == 0 ) {
        return;
    }
    
    WS(ws);
    _btnsView.layer.borderWidth = _borderWidth;
    [_btnsView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws);
        make.left.mas_equalTo(ws).offset(kWidthPro(100));
        make.right.mas_equalTo(ws).offset(-kWidthPro(100));
        make.height.mas_equalTo(kHeightPro(145));
    }];
    
    //设置按钮
    CGFloat btnWidth = _btnsView.frame.size.width/(1.0*_titleArr.count);
    [_titleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [self viewWithTag:EcoComsumableItemsBottomBtnTAG + idx];
        [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(_btnsView);
            make.left.mas_equalTo(_btnsView).offset(btnWidth*idx);
            make.width.mas_equalTo(btnWidth);
        }];
        
        UIView *lineView = [self viewWithTag:EcoComsumableItemsBottomBtnTAG*2 +idx ];
        [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_btnsView).offset(kWidthPro(12));
            make.bottom.mas_equalTo(_btnsView).offset(-kWidthPro(12));
            make.width.mas_equalTo(_borderWidth);
            make.left.mas_equalTo(btn.mas_right);
        }];
    }];

}

- (UIView *)btnsView
{
    if (!_btnsView) {
        _btnsView = [[UIView alloc]init];
        _btnsView.layer.cornerRadius = 10;
        _btnsView.layer.borderWidth = _borderWidth;
        _btnsView.layer.masksToBounds = YES;
    }
    return  _btnsView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setLayout];
}
@end
