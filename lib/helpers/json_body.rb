module JsonBody
  def json_body(request)
    request.body.rewind
    JSON.parse request.body.read
  end
end
