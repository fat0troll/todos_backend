module RequestsSpecHelper
    def json
      JSON.parse(response.body)
    end
  end