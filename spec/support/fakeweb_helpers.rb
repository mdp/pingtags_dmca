module FakewebHelpers
  # Make sure nothing gets out (IMPORTANT)
  FakeWeb.allow_net_connect = false

  # Turns a fixture file name into a full path
  def fixture_file(filename)
    return '' if filename == ''
    File.read(RAILS_ROOT + '/spec/fixtures/' + filename)
  end

  # Convenience methods for stubbing URLs to fixtures
  def stub_get(url, filename)
    FakeWeb.register_uri(:get, url, :body => fixture_file(filename))
  end

  def stub_post(url, filename)
    FakeWeb.register_uri(:post, url, :body => fixture_file(filename))
  end

  def stub_any(url, filename)
    FakeWeb.register_uri(:any, url, :body => fixture_file(filename))
  end

  
end
