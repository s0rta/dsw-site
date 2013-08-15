require 'digest/md5'
require 'time'

module Zerista
  class Client

    include HTTParty

    debug_output $stderr

    def initialize(subdomain, key_id, signing_key)
      @subdomain = subdomain
      @key_id = key_id
      @signing_key = signing_key
    end

    def create_event(attrs)
      get_params = { 'format' => 'json_7' }
      post_params = { 'event[subject]'    => attrs[:name],
                      'event[mceEditor]'  => attrs[:description],
                      'event[start]'      => attrs[:start_time].iso8601,
                      'event[finish]'     => attrs[:end_time].iso8601,
                      'event[track_id]'   => attrs[:track_id],
                      'client_id'         => attrs[:client_id],
                      'location[item_attributes][display_value]' => attrs[:location_name],
                      'location_address[street]' => attrs[:address],
                      'location_address[street2]' => nil,
                      'location_address[city]' => attrs[:city],
                      'location_address[state]' => attrs[:state],
                      'location_address[country_code]' => 'US',
                      'event[max_attendees]' => attrs[:max_attendees]
        }
      post_params.delete_if { |k, v| !v }
      signature = signature_for_params(get_params, post_params)
      self.class.post "https://#{@subdomain}.zerista.com/event", query: get_params, body: post_params.merge(sig: signature)
    end

    def delete_event_by_client_id(client_id)
      get_params = { 'format' => 'json_7' }
      post_params = { 'client_id' => client_id }
      signature = signature_for_params(get_params, post_params)
      self.class.delete "https://#{@subdomain}.zerista.com/event", query: get_params, body: post_params.merge(sig: signature)
    end

    def update_event_by_client_id(client_id, attrs)
      get_params = { 'format' => 'json_7', 'client_id' => client_id }
      post_params = { 'event[subject]'    => attrs[:name],
                      'event[mceEditor]'  => attrs[:description],
                      'event[start]'      => attrs[:start_time].try(:iso8601),
                      'event[finish]'     => attrs[:end_time].try(:iso8601),
                      'event[track_id]'   => attrs[:track_id],
                      'client_id'         => attrs[:client_id],
                      'location[item_attributes][display_value]' => attrs[:location_name],
                      'location_address[street]' => attrs[:address],
                      'location_address[street2]' => nil,
                      'location_address[city]' => attrs[:city],
                      'location_address[state]' => attrs[:state],
                      'location_address[country_code]' => 'US'
        }
      post_params.delete_if { |k, v| !v }
      signature = signature_for_params(get_params, post_params)
      self.class.put "https://#{@subdomain}.zerista.com/event", query: get_params, body: post_params.merge(sig: signature)
    end

    def list_events(terms = '', limit = 100)
      get_params = { 'format' => 'json_7', 'terms' => terms, 'limit' => limit }
      signature = signature_for_params(get_params, {})
      self.class.get "https://#{@subdomain}.zerista.com/event", query: get_params, body: {sig: signature}
    end

    def signature_for_params(get_params, post_params)
      get_params['key_id'] = @key_id
      sorted_get_params = Hash[get_params.sort_by {|k,v| k }]
      get_param_string = sorted_get_params.inject('') { |acc, (k, v)| acc + "#{k}=#{v}"}
      sorted_post_params = Hash[post_params.sort_by {|k,v| k }]
      post_param_string = sorted_post_params.inject('') { |acc, (k, v)| acc + "#{k}=#{v}"}
      digest_string = get_param_string + post_param_string + @signing_key
      Digest::MD5.hexdigest digest_string
    end

  end
end
