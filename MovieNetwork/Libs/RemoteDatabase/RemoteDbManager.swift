//
//  RemoteDbManager.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 26/02/2024.
//

import Foundation
import Supabase

@MainActor
final class RemoteDbManager {
    static let shared = RemoteDbManager()
    let database: PostgrestClient
    let auth: AuthClient

    private init() {
        let supabase = SupabaseClient(supabaseURL: Env.supabaseUrl, supabaseKey: Env.supabaseAnonKey)
        database = supabase.database
        auth = supabase.auth
    }
}
