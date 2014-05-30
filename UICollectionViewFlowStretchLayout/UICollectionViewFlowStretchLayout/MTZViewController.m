//
//  MTZViewController.m
//  UICollectionViewFlowStretchLayout
//
//  Created by Matt Zanchelli on 5/29/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//

#import "MTZViewController.h"

#define CELL_SIZE 100

@interface MTZViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

// The collection view.
@property (strong, nonatomic) UICollectionView *cv;

// The collection view layout.
@property (strong, nonatomic) UICollectionViewFlowLayout *layout;

@end

@implementation MTZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	// Seed RNG.
	srand48(time(0));
	
	// Collection view and layout.
	self.layout = [[UICollectionViewFlowLayout alloc] init];
	self.cv = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
	[self.cv registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
	self.cv.delegate = self;
	self.cv.dataSource = self;
	self.cv.backgroundColor = [UIColor redColor];
	[self.view addSubview:self.cv];
	
	// Control the width of the collection view for testing.
	UIToolbar *controls = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width, 44)];
	[self.view addSubview:controls];
	UISlider *widthSlider = [[UISlider alloc] initWithFrame:CGRectMake(10, 7, 748, 30)];
	widthSlider.translatesAutoresizingMaskIntoConstraints = NO;
	[controls addSubview:widthSlider];
	[controls addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(10)-[slider]-(10)-|" options:NSLayoutFormatDirectionLeftToRight metrics:nil views:@{@"slider": widthSlider}]];
	[widthSlider addTarget:self action:@selector(sliderDidChange:) forControlEvents:UIControlEventValueChanged];
	widthSlider.value = 1.0f;
}

- (IBAction)sliderDidChange:(UISlider *)sender
{
	CGFloat width = MAX(CELL_SIZE, sender.value * self.view.bounds.size.width);
	self.cv.frame = CGRectMake(0, 0, width, self.view.bounds.size.height);
}


#pragma mark - UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
	return NO;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return 10;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
				  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
	cell.backgroundColor = [UIColor colorWithRed:drand48() green:drand48() blue:drand48() alpha:1.0f];
	return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
		   viewForSupplementaryElementOfKind:(NSString *)kind
								 atIndexPath:(NSIndexPath *)indexPath
{
	return nil;
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return CGSizeMake(CELL_SIZE, CELL_SIZE);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
	return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
	return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
	return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
	return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
	return CGSizeZero;
}

@end
