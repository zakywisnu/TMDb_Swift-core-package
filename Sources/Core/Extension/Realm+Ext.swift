//
//  File.swift
//  
//
//  Created by Ahmad Zaky on 05/04/21.
//

import Foundation
import Cleanse
import RealmSwift

public extension Realm {
    struct Module: Cleanse.Module {
        public static func configure(binder: Binder<Singleton>) {
            binder.bind(Realm.self).to { () -> Realm in
                if let realm = try? Realm() {
                    return realm
                } else {
                    fatalError(DatabaseError.invalidInstance.localizedDescription)
                }
            }
        }
    }
}
