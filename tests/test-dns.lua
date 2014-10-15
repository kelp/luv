return require('lib/tap')(function (test)

  test("Get all local http addresses", function (print, p, expect, uv)
    assert(uv.getaddrinfo(nil, "http", nil, expect(function (err, res)
      p(res, #res)
      assert(not err, err)
      assert(res[1].port == 80)
    end)))
  end)

  test("Get only ipv4 tcp adresses for luvit.io", function (print, p, expect, uv)
    assert(uv.getaddrinfo("luvit.io", nil, {
      socktype = "STREAM",
      family = "INET",
    }, expect(function (err, res)
      assert(not err, err)
      p(res, #res)
      assert(#res == 1)
    end)))
  end)

  if require('ffi').os ~= "Windows" then
    test("Get only ipv6 tcp adresses for luvit.io", function (print, p, expect, uv)
      assert(uv.getaddrinfo("luvit.io", nil, {
        socktype = "STREAM",
        family = "INET6",
      }, expect(function (err, res)
        assert(not err, err)
        p(res, #res)
        assert(#res == 1)
      end)))
    end)
  end

  test("Get ipv4 and ipv6 tcp adresses for luvit.io", function (print, p, expect, uv)
    assert(uv.getaddrinfo("luvit.io", nil, {
      socktype = "STREAM",
    }, expect(function (err, res)
      assert(not err, err)
      p(res, #res)
      assert(#res > 0)
    end)))
  end)

  test("Get all adresses for luvit.io", function (print, p, expect, uv)
    assert(uv.getaddrinfo("luvit.io", nil, nil, expect(function (err, res)
      assert(not err, err)
      p(res, #res)
      assert(#res > 0)
    end)))
  end)

  test("Lookup local ipv4 address", function (print, p, expect, uv)
    assert(uv.getnameinfo({
      family = "INET",
    }, expect(function (err, hostname, service)
      p{err=err,hostname=hostname,service=service}
      assert(not err, err)
      assert(hostname)
      assert(service)
    end)))
  end)

  test("Lookup local 127.0.0.1 ipv4 address", function (print, p, expect, uv)
    assert(uv.getnameinfo({
      ip = "127.0.0.1",
    }, expect(function (err, hostname, service)
      p{err=err,hostname=hostname,service=service}
      assert(not err, err)
      assert(hostname)
      assert(service)
    end)))
  end)

  test("Lookup local ipv6 address", function (print, p, expect, uv)
    assert(uv.getnameinfo({
      family = "INET6",
    }, expect(function (err, hostname, service)
      p{err=err,hostname=hostname,service=service}
      assert(not err, err)
      assert(hostname)
      assert(service)
    end)))
  end)

  test("Lookup local ::1 ipv6 address", function (print, p, expect, uv)
    assert(uv.getnameinfo({
      ip = "::1",
    }, expect(function (err, hostname, service)
      p{err=err,hostname=hostname,service=service}
      assert(not err, err)
      assert(hostname)
      assert(service)
    end)))
  end)

  test("Lookup local port 80 service", function (print, p, expect, uv)
    assert(uv.getnameinfo({
      port = 80,
      family = "INET6",
    }, expect(function (err, hostname, service)
      p{err=err,hostname=hostname,service=service}
      assert(not err, err)
      assert(hostname)
      assert(service == "http")
    end)))
  end)

end)
