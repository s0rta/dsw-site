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

    def create_event(name, description, start_time, end_time, client_id, track_id)
      get_params = { 'format' => 'json_7' }
      post_params = { 'event[subject]'    => name,
                      'event[mceEditor]'  => description,
                      'event[start]'      => start_time.iso8601,
                      'event[finish]'     => end_time.iso8601,
                      'event[track_id]'   => track_id,
                      'client_id'         => client_id
        }
      signature = signature_for_params(get_params, post_params)
      self.class.post "https://#{@subdomain}.zerista.com/event", query: get_params, body: post_params.merge(sig: signature)
    end

    def delete_event_by_client_id(client_id)
      get_params = { 'format' => 'json_7' }
      post_params = { 'client_id' => client_id }
      signature = signature_for_params(get_params, post_params)
      self.class.delete "https://#{@subdomain}.zerista.com/event", query: get_params, body: post_params.merge(sig: signature)
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
