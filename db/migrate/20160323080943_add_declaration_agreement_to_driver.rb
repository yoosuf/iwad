class AddDeclarationAgreementToDriver < ActiveRecord::Migration
  def change
    add_column :drivers, :declaration_agreement, :integer, default:0

  end
end
