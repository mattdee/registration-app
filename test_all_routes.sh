#!/bin/bash

# Function to perform a cURL request and return HTTP status code
perform_curl() {
  local url=$1
  local method=$2
  local data=$3

  if [ "$method" == "GET" ]; then
    curl -X GET "$url" -o /dev/null -w "%{http_code}\n"
  elif [ "$method" == "POST" ]; then
    curl -X POST "$url" $data -o /dev/null -w "%{http_code}\n"
  fi
}

# Base URL for the application
BASE_URL="http://localhost:3000"

# Test loading registration form
perform_curl "$BASE_URL/" "GET"

# Test creating a new registration
perform_curl "$BASE_URL/" "POST" "-F 'name=Test User' -F 'email=testuser@example.com' -F 'notes=This is a test note'"

# Test listing all registrations
perform_curl "$BASE_URL/registrations" "GET"

# Test deleting all registrations
perform_curl "$BASE_URL/registrations/deleteAll" "POST"

# Create another registration to test search and update/delete by ID
curl -X POST "$BASE_URL/" \
     -F 'name=Search User' \
     -F 'email=searchuser@example.com' \
     -F 'notes=This is a test note for search' \
     -o /dev/null -w "%{http_code}\n"

# Test searching for a registration by name
SEARCH_RESPONSE=$(curl -X GET "$BASE_URL/registrations?search=Search User")
echo "Search Response: $SEARCH_RESPONSE"

# Extract ID from the search response
REGISTRATION_ID=$(echo $SEARCH_RESPONSE | grep -oP '(?<="_id":")[^"]+')
echo "Extracted Registration ID: $REGISTRATION_ID"

# Test loading update form
perform_curl "$BASE_URL/registrations/update/$REGISTRATION_ID" "GET"

# Test updating a registration
perform_curl "$BASE_URL/registrations/update/$REGISTRATION_ID" "POST" "-F 'name=Updated User' -F 'email=updated@example.com' -F 'notes=This is an updated note'"

# Test deleting a specific registration
perform_curl "$BASE_URL/registrations/delete/$REGISTRATION_ID" "POST"

# Test the test page
perform_curl "$BASE_URL/test" "GET"
