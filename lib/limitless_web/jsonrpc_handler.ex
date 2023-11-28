defmodule LimitlessWeb.JSONRPCHandler do
  use JSONRPC2.Server.Handler

  def handle_request("hello", [name]) do
    "Hello, #{name} I am a jsonrpc phoenix elixer web server!"
  end

  # Add other methods as needed...
end
