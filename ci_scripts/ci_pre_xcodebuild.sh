#!/bin/sh

#  ci_pre_xcodebuild.sh
#  MovieNetwork
#
#  Created by Victorien Druon on 21/03/2024.
#  

echo "Stage: PRE-Xcode Build is activated .... "

cd $CI_WORKSPACE/ci_scripts || exit 1

printf "{\"SUPBASE_URL\":\"%s\",\"SUPABASE_ANON_KEY\":\"%s\",\"TMDB_ACCESS_TOKEN\":\"%s\"}" "$SUPABASE_URL" "$SUPABASE_ANON_KEY" "$TMDB_ACCESS_TOKEN" >> ../MovieNetwork/env.json

echo "Wrote env.json file."

echo "Stage: PRE-Xcode Build is DONE .... "

exit 0
