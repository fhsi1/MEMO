//
//  Memo+CoreDataProperties.m
//  Memo
//
//  Created by Yujean Cho on 2022/08/02.
//
//

#import "Memo+CoreDataProperties.h"

@implementation Memo (CoreDataProperties)

+ (NSFetchRequest<Memo *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Memo"];
}

@dynamic content;
@dynamic insertDate;

@end
