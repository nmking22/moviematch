class AddLogoToServices < ActiveRecord::Migration[6.1]
  def change
    add_column :services, :logo, :string
  end
end
