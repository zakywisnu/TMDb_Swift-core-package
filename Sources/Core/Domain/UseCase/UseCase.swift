//
//  File.swift
//  
//
//  Created by Ahmad Zaky on 19/02/21.
//

import Combine

public protocol UseCase {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
