//
//  APIClientTests.swift
//  MarvelTests
//
//  Created by Vivek Jayakumar on 03/02/22.
//

import Combine
import XCTest
import Resolver
@testable import Marvel

class APIClientTests: XCTestCase {
    let targetURL = URL(string: "https://www.google.com")!
    private var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        cancellables = []
    }

    override func tearDownWithError() throws {
        BlockTestProtocolHandler.removeHandlers(byHost: targetURL.host!)
    }

   
    func testSuccessfulResponse() {
        let sampleJSON: Data? = "{ \"message\": \"success\"}".data(using: .utf8)

        BlockTestProtocolHandler
            .register(url: targetURL) { (request: URLRequest) -> (
                response: HTTPURLResponse,
                data: Data?
            ) in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: BlockTestProtocolHandler.httpVersion,
                headerFields: nil
            )!
            return (response, sampleJSON)
            }

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [
            BlockTestProtocolHandler.self
        ]

        let apiClient = APIClient(configuration: config)

        let fetchCompleted = XCTestExpectation(description: "Success Fetch Completed")
        defer {
            self.wait(for: [fetchCompleted], timeout: 7)
        }

        var object: SampleCodable?
        var error: Error?

        apiClient.request(type: SampleCodable.self, endpoint: SampleEndpoint())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(encounteredError):
                    error = encounteredError
                }
                XCTAssertNil(error)
                XCTAssertEqual(object?.message, "success")
                fetchCompleted.fulfill()
            }, receiveValue: { value in
                object = value
            })
            .store(in: &cancellables)
    }

    func testFailureResponse() {
        BlockTestProtocolHandler
            .register(url: targetURL) { (request: URLRequest) -> (
                response: HTTPURLResponse,
                data: Data?
            ) in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 404,
                httpVersion: BlockTestProtocolHandler.httpVersion,
                headerFields: nil
            )!
            return (response, nil)
            }

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [
            BlockTestProtocolHandler.self
        ]

        let apiClient = APIClient(configuration: config)

        let fetchFailed = XCTestExpectation(description: "Failure Fetch Completed")
        defer {
            self.wait(for: [fetchFailed], timeout: 7)
        }

        var object: SampleCodable?
        var error: Error?

        apiClient.request(type: SampleCodable.self, endpoint: SampleEndpoint())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(encounteredError):
                    error = encounteredError
                }
                XCTAssertNotNil(error)
                if let apiError = error as? APIError {
                    XCTAssertEqual(apiError, APIError.failedRequest(statusCode: 404))
                }
                XCTAssertNil(object)
                fetchFailed.fulfill()
            }, receiveValue: { value in
                object = value
            })
            .store(in: &cancellables)
    }

    func testJSONParsingFailure() {
        let sampleJSON: Data? = "{ \"fakemessage\": \"success\"}".data(using: .utf8)

        BlockTestProtocolHandler
            .register(url: targetURL) { (request: URLRequest) -> (
                response: HTTPURLResponse,
                data: Data?
            ) in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: BlockTestProtocolHandler.httpVersion,
                headerFields: nil
            )!
            return (response, sampleJSON)
            }

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [
            BlockTestProtocolHandler.self
        ]

        let apiClient = APIClient(configuration: config)

        let fetchFailed = XCTestExpectation(description: "Failure Fetch Completed")
        defer {
            self.wait(for: [fetchFailed], timeout: 7)
        }

        var object: SampleCodable?
        var error: Error?

        apiClient.request(type: SampleCodable.self, endpoint: SampleEndpoint())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(encounteredError):
                    error = encounteredError
                }
                XCTAssertNotNil(error)

                if let apiError = error as? APIError,
                   case APIError.invalidResponse = apiError
                {
                    // success
                } else {
                    XCTFail("Invalid response was expected")
                }

                XCTAssertNil(object)
                fetchFailed.fulfill()
            }, receiveValue: { value in
                object = value
            })
            .store(in: &cancellables)
    }
}
