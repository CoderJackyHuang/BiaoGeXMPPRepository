//
//  HYBUserCell.m
//  BiaoGeIMProject
//
//  Created by sixiaobo on 14/11/1.
//  Copyright (c) 2014年 edu. All rights reserved.
//

#import "HYBUserCell.h"
#import "HYBUserModel.h"

@interface HYBUserCell ()

@property (weak, nonatomic) IBOutlet HYBLoadImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *badgeImageView;
@property (weak, nonatomic) IBOutlet UILabel *badgeNumberLabel;

@end

@implementation HYBUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headImageView.width = 50;
    self.headImageView.height = 50;
    
    return;
}

- (void)configureCellWithModel:(HYBUserModel *)model {
    self.headImageView.isCircle = YES;
    NSString *imgName = [NSString stringWithFormat:@"head_temp%ld.jpg", model.userId.integerValue % 18];
    self.headImageView.image = kImageWithName(imgName);
    self.userNicknameLabel.text = model.userNickname;
    self.userDescriptionLabel.text = model.userDescription;
    
    NSTimeInterval registerDate = model.registerDate.floatValue / 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:registerDate];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"MM-dd HH:mm";
    self.dateTimeLabel.text = [formater stringFromDate:date];
    
    return;
}

- (void)updateBadgeNumber:(NSUInteger)badgeNumber {
    if (badgeNumber <= 0) {
        self.badgeImageView.hidden = YES;
        self.badgeNumberLabel.hidden = YES;
    } else {
        self.badgeNumberLabel.hidden = NO;
        self.badgeImageView.hidden = NO;
        self.badgeNumberLabel.text = [NSString stringWithFormat:@"%lu", badgeNumber];
    }
    return;
}

@end
