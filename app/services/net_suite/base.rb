class NetSuite::Base
  def initialize
    credentials       = NetSuite::Credentials.last
    @refresh_token    = credentials.refresh_token
    @access_token     = credentials.access_token
    @access_token_exp = credentials.access_token_expiry
  end

  def get_query_data uri, query
    url = URI(uri)

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["prefer"] = "transient"
    request["Authorization"] = "Bearer #{ @access_token }"
    request["Content-Type"] = "application/json"

    request.body = JSON.dump( query )
    response = https.request(request)

    if response.code == '401' && @access_token_exp.past?
      refersh_token(:get_query_data, uri, query)
    else
      JSON.parse response.read_body
    end
  end

  def refersh_token( callback_name, *args)
    url = URI("https://6983452.suitetalk.api.netsuite.com/services/rest/auth/oauth2/v1/token")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Authorization"] = "Basic #{Base64.strict_encode64("#{ENV['NS_CLIENT_ID']}:#{ENV['NS_CLIENT_SECRET']}")}"
    request["Content-Type"] = "application/x-www-form-urlencoded"
    request.body = "grant_type=refresh_token&refresh_token=#{@refresh_token}"

    response = https.request(request)

    if response.code == '200'
      data = JSON.parse(response.read_body)
      @access_token = data['access_token']
      @access_token_exp = data['expires_in'].to_i.seconds.after

      NetSuite::Credentials.last.update(access_token: @access_token, access_token_expiry: @access_token_exp)

      add_NS_log(response.code, 'Access token refreshed successfully')
      send(callback_name, *(args))
    else
      log_error_and_notify_admin(response, 'Cannot refresh token')
    end
  end

  def generate_refersh_token code
    url = URI("https://6983452.suitetalk.api.netsuite.com/services/rest/auth/oauth2/v1/token")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Authorization"] = "Basic #{Base64.strict_encode64("#{ENV['NS_CLIENT_ID']}:#{ENV['NS_CLIENT_SECRET']}")}"
    request["Content-Type"] = "application/x-www-form-urlencoded"
    request["Cookie"] = "NS_ROUTING_VERSION=LAGGING"
    request.body = "code=#{code}&redirect_uri=#{CGI.escape(ENV['NS_REDIRECT_URI'])}&grant_type=authorization_code"

    response = https.request(request)

    if response.code == '200'
      data = JSON.parse(response.read_body)

      @refresh_token    = data['refresh_token']
      @access_token     = data['access_token']
      @access_token_exp = data['expires_in'].to_i.seconds.after

      NetSuite::Credentials.last.update(access_token: @access_token, access_token_expiry: @access_token_exp, refresh_token: @refresh_token)
      add_NS_log(response.code, 'Refresh token generated successfully')
    else
      log_error_and_notify_admin(response, 'Cannot generate refresh token')
      false
    end
  end

  def log_error_and_notify_admin response, message = '', order_id = nil
    log = Spree::NetSuiteLog.new()

    data = JSON.parse(response.read_body)
    error_text = data['error'].present? ? data['error'].humanize : ''

    log.response = "#{message}#{'.' if message.present?} #{error_text}"

    log.status_code = response&.code
    log.order_id =  order_id if order_id.present?
    log.save

    NetSuiteNotificationMailer.error_email(log.response).deliver
  end

  def add_NS_log status_code, message, order_id = nil
    log = Spree::NetSuiteLog.new()
    log.status_code = status_code
    log.response    = message
    log.order_id    = order_id if order_id.present?
    log.save
  end
end

# touched on 2025-05-22T19:17:03.909852Z
# touched on 2025-05-22T20:40:34.394125Z
# touched on 2025-05-22T23:27:59.561255Z
# touched on 2025-05-22T23:45:40.786712Z