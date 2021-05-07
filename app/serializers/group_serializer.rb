class GroupSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :users
end
