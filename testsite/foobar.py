def application(env, start_response):
    print("hello testing")
    start_response("200 OK", [("Content-Type", "text/html")])
    return [b"Hello World"]
