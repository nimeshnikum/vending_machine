class AddDefaultRoles < ActiveRecord::Migration[6.1]
  def change
    %w[seller buyer].each do |role|
      Role.create(name: role)
    end
  end
end
