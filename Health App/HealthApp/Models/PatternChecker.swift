//
//  PatternChecker.swift
//  HealthApp
//
//  Created by Tina Torabinejad on 10/9/23.
//
//
// Team Members' Name:
// Tina Torabinejad <ttorabinejad@csu.fullerton.edu> 889504171
// Richard Hayes <rhayes_98@csu.fullerton.edu> 887389708
// Alejandro Ramos Jr <ramosalejandro444@csu.fullerton.edu> 887819191
// Wesley Chok <chokwj@csu.fullerton.edu> 886884907

import UIKit


class PatternChecker 
{
    
    //creating two patterns for email and phone numbers
    
    private var pattern_email = try! NSRegularExpression(
        
        pattern: #"^[a-zA-Z0-9_\-\\.@]+$"#,
        options: []
    )
    
    private var pattern_name = try! NSRegularExpression(
        
        pattern: #"^[a-zA-Z \\\s+\\]+$"#,
        options: []
    
    )
    
    
    private func checkString(string: String, pattern: NSRegularExpression) -> Bool
    {
        if string.isEmpty {
            return true
        }
        
        let match = pattern.matches(in: string, range: NSRange(0 ..< string.count))
        let matches = !match.isEmpty
        
        return matches
    }
    
    public func checkEmailString(_ email: String) -> Bool
    {
        return self.checkString(string: email, pattern: self.pattern_email)
    }
    
    public func checkNameString(_ name: String) -> Bool
    {
        return self.checkString(string: name, pattern: self.pattern_name)
    }
}
