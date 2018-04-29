require 'aws-sdk-lambda'  # v2: require 'aws-sdk'
require 'json'


class LambdaService
  Access_Key_ID = "<AWS-Access_key_id>"
  Secret_Access_Key = "<AWS-Secret_key>"

  def initialize
      @client ||= Aws::Lambda::Client.new(region: 'us-east-2',
                                          access_key_id: Access_Key_ID,
                                          secret_access_key: Secret_Access_Key)
      @address = "GA2RUJ3CVD6LSCRQCN2FBEMR7X675WQA4R6I7IIHJ6KNIHIMHXPAPVXL"
  end
  # Get the 10 most recent items
  def send_lumnes
    req_payload = {:address => @address}
    payload = JSON.generate(req_payload)

    @client.invoke({
                       function_name: 'SendLumnes',
                       invocation_type: 'RequestResponse',
                       log_type: 'None',
                       payload: payload
                   })

  end

  def get_current_lumnes
    req_payload = { :address => @address }
    payload = JSON.generate(req_payload)

    @client.invoke({
                       function_name: 'GetBalance',
                       invocation_type: 'RequestResponse',
                       log_type: 'None',
                       payload: payload
                   })
  end
end

