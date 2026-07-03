module Kapellmeister::Base
  def configuration
    @configuration ||= self::Configuration.new
  end

  def report(data)
    responder.new(data)
  end

  def configure
    yield(configuration)
  end

  def logger
    @logger ||= configuration.logger
  end

  def requests
    @requests ||= generate_routes(self::ROUTES).transform_values! do |value|
      value.except!(:use_wrapper)
    end
  end

  def responder
    @responder ||= defined?(self::Responder) ? self::Responder : Kapellmeister::Responder
  end

  def self.routes_scheme_parse(path)
    template = ERB.new(File.read(path)).result
    parsed = YAML.safe_load(template, aliases: true, permitted_classes: [Symbol, Date, Time])
    (parsed || {}).deep_symbolize_keys
  rescue Errno::ENOENT
    warn 'No such file or directory', path
    {}
  end
end

def generate_routes(json_scheme)
  json_scheme.dup.each_with_object({}) do |(key, value), scheme|
    scheme[key] = value.delete(:scheme) if (value.is_a?(Hash) && value.key?(:scheme)) || value.is_a?(String)
    next if value.nil? || value.empty?

    generate_routes(value).map { |deep_key, deep_value| mapping(deep_key, deep_value, key, scheme) }
  end
rescue TypeError
  raise "It seems like wrong routes scheme. #{json_scheme}"
end

def mapping(deep_key, deep_value, key, scheme)
  old_path = deep_value[:path].presence || deep_key.to_s
  name = old_path.to_s.split('/').map { |part| part.gsub(/%<.*?>/, '') }.reject(&:empty?)
  use_name_wrapper, use_path_wrapper = use_wrappers?(deep_value.delete(:wrappers))

  deep_value[:path] = use_path_wrapper ? [key, old_path].join('/') : old_path
  new_key = if name.size == 1 && !use_name_wrapper
              deep_key
            else
              use_name_wrapper ? [key, deep_key].join('_').to_sym : deep_key
            end
  scheme[new_key] = deep_value
end

def use_wrappers?(wrappers)
  default = [true, false]
  return default if wrappers.nil?

  if wrappers.key?(:all)
    all = to_bool!(wrappers[:all])
    default = [all, all]
  else
    default = [to_bool!(wrappers[:name]), default[1]] if wrappers.key?(:name)
    default = [default[0], to_bool!(wrappers[:path])] if wrappers.key?(:path)
  end

  default
end

def to_bool!(value)
  convert_options = { 'true' => true, true => true, 'false' => false, false => false }

  convert_options[value]
end
