//
//  CustomAssistantConfigurationService.swift
//  voicify-assistant-sdk
//
//  Created by James McCarthy on 1/26/23.
//

import UIKit

public class CustomAssistantConfigurationService
{
    public var customAssistantConfiguration: CustomAssistantConfigurationResponse? = nil
        
    public func getCustomAssistantConfiguration(configurationId: String? = "", serverRootUrl: String, appId: String, appKey: String) async throws -> CustomAssistantConfigurationResponse{
        if let configId = configurationId {
            guard let getConfigurationURL = URL(string: "\(serverRootUrl)/api/CustomAssistantConfiguration/\(configId)?applicationId=\(appId)&applicationSecret=\(appKey)") else { fatalError("Missing URL") }
            let customAssistantRequest = generateGetRequest(url: getConfigurationURL)
            let session = URLSession.shared
            let (data, response) = try await session.data(for: customAssistantRequest)
            guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200
            else {
                throw ValidationError.Invalid
            }
            if(!data.isEmpty)
            {
                let decoder = JSONDecoder()
                let configurationResponse = try decoder.decode(CustomAssistantConfigurationResponse.self, from: data)
                print("service call")
                print(configurationResponse.applicationId)
                return configurationResponse
            }
            else{
                throw ValidationError.Invalid
            }
        }
        else{
            throw ValidationError.Invalid
        }
        
    }
    enum ValidationError: Error {
            case Invalid
        }
}

func generateGetRequest(url: URL) -> URLRequest{
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    return request
}

