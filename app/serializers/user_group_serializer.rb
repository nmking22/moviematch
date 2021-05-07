class UserGroupSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :user_id, :group_id
end
