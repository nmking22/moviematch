class ServiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :watchmode_id, :logo
end
