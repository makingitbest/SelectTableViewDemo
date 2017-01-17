//
//  ChooseModelCell.m
//  SelectTableViewDemo
//
//  Created by WangQiao on 17/1/12.
//  Copyright © 2017年 WangQiao. All rights reserved.
//

#import "ChooseModelCell.h"
#import "UIView+SetRect.h"
#import "ChooseModel.h"

@interface ChooseModelCell ()

@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIView      *lineView;

@end

@implementation ChooseModelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.titleLabel          = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, Width - 15, 50)];
        self.titleLabel.font     = [UIFont systemFontOfSize:14];
        self.textLabel.textColor = [UIColor grayColor];
        [self addSubview:self.titleLabel];
        
        self.iconImageView         = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        self.iconImageView.centerX = Width - 25;
        self.iconImageView.centerY = 50 /2.0f;
        self.iconImageView.image   = [UIImage imageNamed:@"meixz"];
        self.iconImageView.highlightedImage = [UIImage imageNamed:@"xuanze"];
        [self addSubview:self.iconImageView];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 0.5)];
        self.lineView.backgroundColor = [UIColor lightGrayColor];
        self.lineView.top  = 49.5f;
        [self addSubview:self.lineView];
    }
    
    return self;
}

- (void)loadContent {
    
    ChooseModel *model = self.data;
    
    self.titleLabel.text = model.title;
    model.isSelected ? (self.iconImageView.highlighted = YES) : (self.iconImageView.highlighted = NO);
    
}

@end
