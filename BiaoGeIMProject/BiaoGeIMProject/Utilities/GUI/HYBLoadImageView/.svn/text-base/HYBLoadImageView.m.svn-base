//
//  HYBLoadImageView.m
//  CloudShopping
//
//  Created by ljy-335 on 14-8-1.
//  Copyright (c) 2014年 uni2uni. All rights reserved.
//

#import "HYBLoadImageView.h"
#import "UIImageView+WebCache.h"

@interface HYBLoadImageView ()

@end

@implementation HYBLoadImageView

+ (void)initialize {
    [SDWebImageManager.sharedManager.imageDownloader setValue:@"PersonalShoppingMall" forHTTPHeaderField:@"AppName"];
    SDWebImageManager.sharedManager.imageDownloader.executionOrder = SDWebImageDownloaderLIFOExecutionOrder;
    return;
}

- (id)init {
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame {
    // 默认不显示
    return [self initWithFrame:frame showLoading:NO];
}

- (id)initWithFrame:(CGRect)frame showLoading:(BOOL)showLoading {
    if (self = [super initWithFrame:frame]) {
        _showLoading = showLoading;
        // 这里关闭掉
        _showLoading = NO;
        self.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

- (void)setImageWithURLString:(NSString *)urlString placeholder:(NSString *)placeholder {
    if (urlString == nil || ![urlString isKindOfClass:[NSString class]]) {
        self.image = kImageWithName(placeholder);
        return;
    }
    [self sd_setImageWithURL:[NSURL URLWithString:urlString]
            placeholderImage:kImageWithName(placeholder)
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                       if (error == nil) {
                           self.image = image;
                       }
    }];
    return;
}

@end