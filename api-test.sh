#!/bin/bash

# Function to execute the first curl command
function stream_response() {
    curl http://localhost:11434/api/generate -d '{
        "model": "mistral",
        "prompt": "Why is the sky blue?",
        "options": {
            "seed": 12,
            "temperature": 0.5
        }
    }' '.response'
}

# Function to execute the second curl command
function get_model() {
    curl http://localhost:11434/api/generate -d '{
        "model": "mistral"
    }'
}

function chat_response() {
    curl http://localhost:11434/api/chat -d '{
        "model": "mistral",
        "messages": [
            {
                "role": "user",
                "content": "why are dogs so cute?"
            }
        ]
    }'
}

function list_local_models() {
    curl http://localhost:11434/api/tags
}

function show_model_info() {
    curl http://localhost:11434/api/show -d '{
        "name": "mistral"
    }'
}

function delete_model() {
    curl -X DELETE http://localhost:11434/api/delete -d '{
        "name": "mistral"
    }'
}

function pull_model() {
    curl http://localhost:11434/api/pull -d '{
        "name": "mistral"
    }'
}

function gen_embeddings() {
    curl http://localhost:11434/api/embeddings -d '{
        "model": "mistral",
        "prompt": "Here is an artical about llamas..."
    }'
}

function openai_chat() {
    curl http://localhost:11434/v1/chat/completions \
        -H "Content-Type: application/json" \
        -d '{
            "model": "mistral",
            "messages": [
                {
                    "role": "system",
                    "content": "You are a helpful assistant."
                },
                {
                    "role": "user",
                    "content": "Hello!"
                }
            ]
        }'
}
# Check the provided flag and execute the corresponding function
case "$1" in
    --stream)
        stream_response
        ;;
    --getmodel)
        get_model
        ;;
    --chat)
        chat_response
        ;;
    --list_local_models)
        list_local_models
        ;;
    --show_model_info)
        show_model_info
        ;;
    --delete_model)
        delete_model
        ;;
    --pull_model)
        pull_model
        ;;
    --gen_embeddings)
        gen_embeddings
        ;;
    --openai_chat)
        openai_chat
        ;;
    *)
        echo "Usage: $0 --stream | --getmodel"
        echo "       --stream   Stream Genrated Response"
        echo "       --getmodel Get Model"
        echo "       --chat     Execute the chat response"
        echo "       --list_local_models     List local models"
        echo "       --show_model_info     Show model info"
        echo "       --delete_model     Delete model"
        echo "       --pull_model     Pull model"
        echo "       --gen_embeddings     Generate embeddings"
        echo "       --openai_chat     OpenAI Chat"
        exit 1
        ;;
esac