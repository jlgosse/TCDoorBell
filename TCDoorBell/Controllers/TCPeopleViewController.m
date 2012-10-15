//
//  TCPeopleViewController.m
//  TCDoorBell
//
//  Created by Joshua Gosse on 2012-10-13.
//  Copyright (c) 2012 Shopify. All rights reserved.
//

#import "TCPeopleViewController.h"
#import "TCPerson.h"

#pragma mark - Implementation

#define kTCCellIdentifier @"TCPeopleViewCell"

#define kTCNumericCellWidth		240.0f
#define kTCNumericCellHeight	240.0f
#define kTCNumericSectionInset	12.0f

@implementation TCPeopleViewController {
	UICollectionView *_collectionView;
}

#pragma mark - Views

- (void)loadView
{
	[super loadView];
	
	// generate a flow layout to provide to the collection view
	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	[flowLayout setItemSize:CGSizeMake(kTCNumericCellWidth, kTCNumericCellHeight)];
	[flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
	[flowLayout setSectionInset:UIEdgeInsetsMake(kTCNumericSectionInset, kTCNumericSectionInset, kTCNumericSectionInset, kTCNumericSectionInset)];
	
	// add a collection view, allow it to take up the entirety of the display
	_collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
	_collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	[_collectionView setShowsVerticalScrollIndicator:YES];
	[_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kTCCellIdentifier];
	
	// assign the controller as the delegate and datasource of the collection view
	_collectionView.delegate = self;
	_collectionView.dataSource = self;
	
	[self.view addSubview:_collectionView];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	// data structure for storing the list of employees
	_people = [[NSMutableArray alloc] init];
	
	for (int i = 0; i < 100; i++) {
		TCPerson *person = [[TCPerson alloc] init];
		person.name = [NSString stringWithFormat:@"%d", i];
		[_people addObject:person];
	}
	
	[_collectionView reloadData];
}

#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	
}

#pragma mark - UICollectionView DataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	TCPerson *person = [_people objectAtIndex:indexPath.row];
	UICollectionViewCell *collectionViewCell = [_collectionView dequeueReusableCellWithReuseIdentifier:kTCCellIdentifier forIndexPath:indexPath];
	
	UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
	backgroundView.backgroundColor = [UIColor whiteColor];
	collectionViewCell.backgroundView = backgroundView;

	UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
	label.text = person.name;

	return collectionViewCell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return [_people count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}

@end
