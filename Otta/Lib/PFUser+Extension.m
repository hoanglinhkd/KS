//
//  PFUser+Extension.m
//  Otta
//
//  Created by Gambogo on 12/9/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "PFUser+Extension.h"

@implementation PFUser (Extension)

-(void) setName:(NSString*) displayName
{
    [self setObject:displayName forKey:@"name"];
}

-(NSString*) name
{
    NSString *nameValue = [self objectForKey:@"name"];
    if (nameValue.length <= 0) {
        return [NSString stringWithFormat:@"%@ %@", self[@"firstName"], self[@"lastName"]];
    }
    
    return nameValue;
}

-(void) setFacebookUserTokenId:(NSString*)facebookUserTokenIdValue
{
    [self setObject:facebookUserTokenIdValue forKey:@"facebookUserTokenId"];
}

-(NSString*) facebookUserTokenId
{
    return [self objectForKey:@"facebookUserTokenId"];
}

-(void) setIsFriend:(BOOL)isFriendValue
{
    [self setObject:[NSNumber numberWithBool:isFriendValue] forKey:@"isFriend"];
}

-(BOOL) isFriend
{
    return [[self objectForKey:@"isFriend"] boolValue];
}

-(void) setIsSelected:(BOOL)isSelectedValue
{
    [self setObject:[NSNumber numberWithBool:isSelectedValue] forKey:@"isSelected"];
}

-(BOOL) isSelected
{
    return [[self objectForKey:@"isSelected"] boolValue];
}

-(void) setFirstName:(NSString*)firstNameValue
{
    [self setObject:firstNameValue forKey:@"firstName"];
}

-(NSString*) firstName
{
    return [self objectForKey:@"firstName"];
}

-(void) setLastName:(NSString*)lastNameValue
{
    [self setObject:lastNameValue forKey:@"lastName"];
}

-(NSString*) lastName
{
    return [self objectForKey:@"lastName"];
}

-(void) setPhone:(NSString*)phone
{
    [self setObject:phone forKey:@"phone"];
}

-(NSString*) phone
{
    return [self objectForKey:@"phone"];
}
@end
