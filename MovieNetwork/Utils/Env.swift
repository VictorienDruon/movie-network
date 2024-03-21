//
//  Env.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 21/03/2024.
//

import Foundation

enum Env {
    private static func env() -> [String: Any] {
        guard let path = Bundle.main.path(forResource: "env", ofType: "json") else {
            fatalError("env.json is missing.")
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return try JSONSerialization.jsonObject(with: data) as! [String: Any]
        } catch {
            fatalError("Failed to serialize env.json.")
        }
    }

    static var supabaseUrl: URL {
        return URL(string: env()["SUPABASE_URL"] as! String)!
    }

    static var supabaseAnonKey: String {
        return env()["SUPABASE_ANON_KEY"] as! String
    }

    static var tmdbAccessToken: String {
        return env()["TMDB_ACCESS_TOKEN"] as! String
    }
}
