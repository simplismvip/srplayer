//
//  NetWork.h
//  SRPlayer
//
//  Created by jh on 2022/8/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIView.h>
#import <IJKMediaFrameworkWithSSL/IJKMediaFrameworkWithSSL.h>
NS_ASSUME_NONNULL_BEGIN

@interface NetWork : NSObject

- (void)initWithURL:(NSURL *)url;
@property(atomic, strong) NSURL *url;
@property(atomic, strong) UIView *view;
@property(atomic, retain) id<IJKMediaPlayback> player;
@end

NS_ASSUME_NONNULL_END
