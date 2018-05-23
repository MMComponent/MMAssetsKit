//
//  Target_Assets.m
//  MMAssetsKit
//
//  Created by boxytt on 2018/5/23.
//

#import "Target_Assets.h"
#import "AssetViewController.h"

@implementation Target_Assets

- (UIViewController*)Action_assetsViewController:(NSDictionary*)params {
    return [[AssetViewController alloc] init];
}

@end
