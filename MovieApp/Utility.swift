//
//  Utility.swift
//  MovieApp
//
//  Created by YASH COMPUTERS on 27/08/19.
//  Copyright © 2019 ambrish. All rights reserved.
//

import Foundation

class Util {
    static func getToken() throws -> String {
        let userDef = UserDefaults.standard
        guard let token = userDef.object(forKey: "token") as? String  else {
            throw TokenError.NoTokenFound
        }
        if token.isEmpty {
            throw TokenError.NoTokenFound
        }
        
        return token
    }
    static func saveToken(token:String) throws {
        if token.isEmpty {
           throw TokenError.ErrorInSavingToken(token: token)
        }
        let userDef = UserDefaults.standard
        userDef.setValue(token, forKey: "token")
        userDef.synchronize()
    }
    
    static func saveExpiry(expiryUTC:String)  {
        if expiryUTC.isEmpty {

            print("expiry date in empty")
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//
        let dt = dateFormatter.date(from: expiryUTC)
        guard let date1 = dt else {
            fatalError()
        }
        let dateStrInUTC = dateFormatter.string(from: date1)
//        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.dateFormat = "h:mm a"
//
//        let dateStr = dateFormatter.string(from: dt!)
        let userDef = UserDefaults.standard
        userDef.setValue(dateStrInUTC, forKey: "expiry")
        
        userDef.synchronize()
    }
    static func getExpiryDate() -> Date? {
        let userDef = UserDefaults.standard
        guard let dateStr = userDef.object(forKey: "expiry") as? String  else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        guard let date = dateFormatter.date(from: dateStr) else{
            fatalError()
        }
        return date
        
    }
    static func isTokenValid() -> Bool{
        guard let expiryDat = getExpiryDate()  else {
            return false
        }
        let result = Date().compare(expiryDat)
        if  result == ComparisonResult.orderedAscending {
            return true
        }
        return false
    }
}

enum TokenError : Error {
    case NoTokenFound
    case TokenExpired(at:String)
    case ErrorInSavingToken(token:String)
}
