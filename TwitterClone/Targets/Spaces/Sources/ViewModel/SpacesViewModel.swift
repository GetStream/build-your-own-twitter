//
//  SpacesViewModel.swift
//  Spaces
//
//  Created by Stefan Blos on 14.02.23.
//  Copyright © 2023 Stream.io Inc. All rights reserved.
//

import HMSSDK
import Chat
import StreamChat
import StreamChatSwiftUI

public class SpacesViewModel: ObservableObject {
    
    @Injected(\.chatClient) var chatClient
    
    @Published var ownTrack: HMSAudioTrack?
    @Published var otherTracks: Set<HMSAudioTrack> = []
    
    @Published var isAudioMuted = false
    
    @Published var isInSpace = false
    
    var hmsSDK = HMSSDK.build()
    
    @Published var spaces: [Space] = []
    
    init() {
        let query = ChannelListQuery(
            filter: .and([
                .equal(.type, to: .messaging),
                .containMembers(userIds: [chatClient.currentUserId ?? "stefan"])
            ])
        )
        
        let controller = chatClient.channelListController(query: query)
        
        controller.synchronize { error in
            if let error = error {
                // TODO: proper error handling
                print("Error querying channels: \(error.localizedDescription)")
            }
            
            self.spaces = Array(controller.channels)
                .filter({ channel in
                    channel.extraData.keys.contains("spaceChannel")
                })
                .map { Space.from($0) }
        }
    }
    
    @MainActor
    func joinSpace() async {
        do {
            // TODO: Use real channel Ids
            let channelCid = "messaging:call-test-channel"
            let channelId = try ChannelId(cid: channelCid)
            let call = try await chatClient.createCall(with: UUID().uuidString, in: channelId)
            // TODO: how to get the token? (we could use chatclient)
            let token = call.token
            // TODO: how to get the name correctly
            // TODO: how to join audio only
            let config = HMSConfig(userName: "Stefan", authToken: token)
            
            hmsSDK.join(config: config, delegate: self)
            isInSpace = true
        } catch {
            print(error.localizedDescription)
            isInSpace = false
        }
    }
    
    func leaveSpace() {
        hmsSDK.leave { [weak self] success, error in
            guard success, error != nil else {
                self?.ownTrack = nil
                self?.otherTracks = []
                self?.isInSpace = false
                return
            }
            
            if let error {
                print(error.localizedDescription)
                self?.isInSpace = false
            }
        }
    }
    
    func toggleAudioMute() {
        isAudioMuted.toggle()
        hmsSDK.localPeer?.localAudioTrack()?.setMute(isAudioMuted)
    }
    
    // TODO: make this return a Result<> with different error types for the errors and display that to users
    func createSpace(title: String, description: String, happeningNow: Bool, date: Date) {
        // create new channel
        guard let userId = chatClient.currentUserId else {
            print("ERROR: chat client doesn't have a userId")
            return
        }
        
        guard let channelController = try? chatClient.channelController(
            createChannelWithId: ChannelId(type: .messaging, id: UUID().uuidString),
            name: title,
            members: [userId],
            isCurrentUserMember: true,
            messageOrdering: .bottomToTop,
            // Potantially invite other users who could be part of it
            invites: [],
            extraData: [
                "spaceChannel": .bool(true),
                "description": .string(description),
                "spaceState": .string(happeningNow ? SpaceState.running.rawValue : SpaceState.planned.rawValue),
                "startTime": .string(date.ISO8601Format())
            ]
        ) else {
            print("Channel creation failed")
            return
        }
        
        // TODO: listen to errors and act accordingly
        channelController.synchronize { error in
            if let error {
                print("Synchronize error: \(error.localizedDescription)")
            }
        }
    }
}
