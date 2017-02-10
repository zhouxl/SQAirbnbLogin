//
//  SQLoginBoxView.m
//  SQAirbnbLogin
//
//  Created by 小六 on 09/02/2017.
//  Copyright © 2017 小六. All rights reserved.
//

#import "SQLoginBoxView.h"
#import "SQOptionView.h"
#include "Masonry.h"

@interface SQLoginBoxView ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *platLoginLabel;
@property (nonatomic, strong) UILabel *emailLoginLabel;
@property (nonatomic, strong) SQOptionView *optionsView;
@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation SQLoginBoxView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    self.contentView.alpha = 1;
    self.loginButton.alpha = 1;
}

#pragma mark - delegate -

- (void)appear {
    self.alpha = 1;
    [self.platLoginLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.offset(50);
    }];
    [self.loginButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailLoginLabel.mas_bottom).offset(10);
        make.left.right.offset(0);
        make.height.mas_equalTo(44);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        
        self.platLoginLabel.alpha = 1;
        self.optionsView.alpha = 1;
        self.emailLoginLabel.alpha = 1;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)disappear {
    
    [self.platLoginLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
    }];
    [self.loginButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.left.right.offset(0);
        make.height.mas_equalTo(44);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        [self layoutIfNeeded];
        self.optionsView.alpha = 0;
        self.platLoginLabel.alpha = 0;
        self.emailLoginLabel.alpha = 0;
    } completion:^(BOOL finished) {
        self.alpha = 0;
        if (self.showLoginView) {
            self.showLoginView();
        }
    }];
}

- (UIView *)contentView {
    if ( !_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
        [self addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.top.offset(0);
            make.bottom.right.offset(-15);
        }];
    }
    return _contentView;
}

- (UILabel *)platLoginLabel {
    if ( !_platLoginLabel) {
        _platLoginLabel = [[UILabel alloc] init];
        _platLoginLabel.font = [UIFont systemFontOfSize:16];
        _platLoginLabel.textColor = [UIColor whiteColor];
        _platLoginLabel.text = NSLocalizedString(@"通过以下方式快速登录：", nil);
        [self.contentView addSubview:_platLoginLabel];
        [_platLoginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(50);
            make.left.offset(0);
        }];
    }
    return _platLoginLabel;
}

- (SQOptionView *)optionsView {
    if (!_optionsView) {
        _optionsView = [[SQOptionView alloc] init];
        SQOptionItem *sina = [SQOptionItem itemWithTitle:NSLocalizedString(@"新浪", nil) color:[UIColor colorWithRed:130/255.0 green:171/255.0 blue:186/255.0 alpha:1]];
        SQOptionItem *qq = [SQOptionItem itemWithTitle:@"QQ" color:[UIColor colorWithRed:130/255.0 green:171/255.0 blue:186/255.0 alpha:1]];
        SQOptionItem *weixin = [SQOptionItem itemWithTitle:NSLocalizedString(@"微信", nil) color:[UIColor colorWithRed:130/255.0 green:171/255.0 blue:186/255.0 alpha:1]];
        [_optionsView addOptions:@[sina, qq, weixin]];
        [self.contentView addSubview:_optionsView];
        [_optionsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.platLoginLabel.mas_bottom).offset(10);
            make.left.right.offset(0);
            make.height.mas_equalTo(141);
        }];
    }
    return _optionsView;
}

- (UILabel *)emailLoginLabel {
    if ( !_emailLoginLabel) {
        _emailLoginLabel = [[UILabel alloc] init];
        _emailLoginLabel.font = [UIFont systemFontOfSize:16];
        _emailLoginLabel.textColor = [UIColor whiteColor];
        _emailLoginLabel.text = NSLocalizedString(@"或用邮箱登录：", nil);
        [self.contentView addSubview:_emailLoginLabel];
        [_emailLoginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.optionsView.mas_bottom).offset(28);
            make.left.offset(0);
        }];
    }
    return _emailLoginLabel;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.backgroundColor = [UIColor whiteColor];
        _loginButton.layer.cornerRadius = 3;
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_loginButton setTitle:NSLocalizedString(@"邮箱地址", nil) forState:UIControlStateNormal];
        _loginButton.contentEdgeInsets = UIEdgeInsetsMake(0, 16, 0, 0);
        _loginButton.contentHorizontalAlignment= UIControlContentHorizontalAlignmentLeft;
        [_loginButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(disappear) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_loginButton];
        [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.top.equalTo(self.emailLoginLabel.mas_bottom).offset(10);
            make.height.mas_equalTo(44);
        }];
    }
    return _loginButton;
}
@end
