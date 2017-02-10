//
//  SQOptionView.m
//  SQAirbnbLogin
//
//  Created by 小六 on 09/02/2017.
//  Copyright © 2017 小六. All rights reserved.
//

#import "SQOptionView.h"
#import "Masonry.h"

@implementation SQOptionItem

+ (instancetype)itemWithTitle:(NSString *)title color:(UIColor *)color {
    
    NSAssert(title.length > 0 || color != nil, @"SQOptionItem:请设置标题或颜色");
    
    SQOptionItem *item = [[SQOptionItem alloc] init];
    item.title = title;
    item.color = color;
    return item;
}

@end

#pragma mark - SQOptionView

@interface SQOptionView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, assign, getter=isUnfolded) BOOL unfolded; //展开的
@property (nonatomic, assign) NSInteger itemCount;

@end

@implementation SQOptionView

- (void)addOptions:(NSArray<SQOptionItem *> *)options {
    UIButton *preButton = nil;
    self.clipsToBounds = YES;
    _itemCount = options.count;
    for (SQOptionItem *item in options) {
        UIButton *button = [self customButtomWithItem:item];
        button.tag = [options indexOfObject:item];
        [self.scrollView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.width.equalTo(self.mas_width);
            make.height.mas_equalTo(44);
            if (!preButton) {
                make.top.offset(0);
            }else {
                make.top.equalTo(preButton.mas_bottom).offset(10);
            }
        }];
        preButton = button;
    }
    self.moreButton.alpha = 1;
}


- (UIButton *)customButtomWithItem:(SQOptionItem *)item {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:item.title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = item.color;
    button.adjustsImageWhenHighlighted = NO;
    [button addTarget:self action:@selector(itemButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark - action

- (void)itemButtonPressed:(UIButton *)button {
    if (self.clickItem) {
        self.clickItem(button.tag);
    }
}

- (void)moreButtonPressed {
    if (self.isUnfolded) { // 当前展开，收缩
        self.unfolded = NO;
        [self.moreButton setTitle:@"更多选项" forState:UIControlStateNormal];
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(141);
        }];
        [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(98);
        }];
    }else {
        self.unfolded = YES;
        [self.moreButton setTitle:@"更少选项" forState:UIControlStateNormal];
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(54*_itemCount+33);
        }];
        [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(54*_itemCount - 10);
        }];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.superview layoutIfNeeded];
    }];
}

#pragma mark - get

- (UIScrollView *)scrollView {
    if ( !_scrollView ) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.clipsToBounds = YES;
        [self addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.offset(0);
            make.height.mas_equalTo(98);
        }];
    }
    return _scrollView;
}

- (UIButton *)moreButton {
    if ( !_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setTitleColor:SQHEX(0x666666) forState:UIControlStateNormal];
        [_moreButton setTitle:@"更多选项..." forState:UIControlStateNormal];
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_moreButton addTarget:self action:@selector(moreButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_moreButton];
        [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.top.equalTo(self.scrollView.mas_bottom).offset(10);
            make.height.mas_equalTo(33);
        }];
    }
    return _moreButton;
}

@end
