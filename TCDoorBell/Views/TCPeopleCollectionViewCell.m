//
//  TCPeopleCollectionViewCell.m
//  TCDoorBell
//
//  Created by Joshua Gosse on 2012-10-15.
//  Copyright (c) 2012 Shopify. All rights reserved.
//

#import "TCPeopleCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation TCPeopleCollectionViewCell

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		self.backgroundColor = [UIColor whiteColor];
		
		_imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		_imageView.contentMode = UIViewContentModeScaleAspectFit;
		_imageView.backgroundColor = [UIColor grayColor];
		[self addSubview:_imageView];
		
		_labelName = [[UILabel alloc] initWithFrame:CGRectZero];
		_labelName.backgroundColor = [UIColor clearColor];
		_labelName.font = [UIFont systemFontOfSize:kTCNumericPeopleCellFontSize];
		_labelName.textColor = [UIColor darkGrayColor];
		_labelName.textAlignment = NSTextAlignmentCenter;
		[self addSubview:_labelName];
    }
    return self;
}

#pragma mark - Layout

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	CGRect bounds = self.bounds;
	
	CGFloat xOffset = CGRectGetMinX(bounds) + kTCNumericCellPadding;
	CGFloat width = CGRectGetWidth(bounds) - kTCNumericCellPadding * 2.0f;
	
	_imageView.frame = CGRectMake(xOffset,
								  CGRectGetMinY(bounds) + kTCNumericCellPadding,
								  width,
								  CGRectGetHeight(bounds) - kTCNumericCellPadding * 2.0f - _labelName.font.lineHeight);
	
	_labelName.frame = CGRectMake(xOffset,
								  CGRectGetMaxY(_imageView.frame),
								  width,
								  _labelName.font.lineHeight);
}

@end
