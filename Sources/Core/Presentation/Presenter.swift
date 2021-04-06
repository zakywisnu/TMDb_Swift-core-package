//
//  File.swift
//  
//
//  Created by Ahmad Zaky on 19/02/21.
//

import SwiftUI
import Combine

public class Presenter<Request, Response, Interactor: UseCase>: ObservableObject where Interactor.Request == Request, Interactor.Response == Response {
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let _useCase: Interactor
    private let _request: Request
    
    @Published public var item: Response?
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    public init(useCase: Interactor, request: Request) {
        _useCase = useCase
        _request = request
    }
    
    public func execute() {
        isLoading = true
        _useCase.execute(request: _request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure (let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { item in
                self.item = item
            })
            .store(in: &cancellables)
    }
    
    
}
