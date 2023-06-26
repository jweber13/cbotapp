# app/services/openai_service.rb
require "ruby/openai"

def fetch_chat(prompt)
  api_key = ENV["OPENAI_ACCESS_TOKEN"]
  prompt_to_send = "you are a coach and you must motivate me to put down my phone and keep training. answer my question first, keep your response short, and remind me that I must train: " + prompt
  client = OpenAI::Client.new(access_token: ENV["OPENAI_ACCESS_TOKEN"])

  response = client.chat(
    parameters: {
      model: "gpt-3.5-turbo",
      messages: [{ role: "user", content: prompt_to_send }],
      max_tokens: 500
    })
  return response["choices"][0]["message"]["content"]
end
