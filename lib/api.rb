require 'http'

module MC
  class Call
    def self.find(conf_uid, uid)
      puts "Fetching call #{uid}"
      Client.request(:getCallData, conferenceUID: conf_uid, callUID: uid)
    end
  end

  class Conference
    def self.all
      puts "Fetching conferences"
      expired + canceled + upcoming
    end

    def self.expired
      puts "..Expired"
      Client.request(:getExpiredConference)["conference"]
    end

    def self.canceled
      puts "..Canceled"
      Client.request(:getCanceledConference)["conference"]
    end

    def self.upcoming
      puts "..Upcoming"
      Client.request(:getUpcomingConference)["conference"]
    end
  end

  class Client
    def self.request(method, uids={})
      query = {
        type: "json",
        customer: ENV["CUSTOMER_KEY"],
        key: ENV["CUSTOMER_SECRET"]
      }
      query = query.merge(uids)
      query_string = Rack::Utils.build_query(query)
      uri = URI("http://myaccount.maestroconference.com/_access/#{method}?#{query_string}")
      response = HTTP.get(uri)
      JSON.parse(response.body)["value"]
    end
  end
end
