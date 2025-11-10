require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let(:user) { User.create!(username: "teste", first_name: "Test", surnames: "User", email: "teste@example.com", password: "123456") }

  before do
    sign_in user
  end

  describe "POST #create" do
    it "cria um grupo válido" do
      expect {
        post :create, params: { group: { name: "Novo Grupo", header: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'teste.png'), 'image/jpeg') } }
      }.to change(Group, :count).by(1)
      expect(response).to redirect_to(group_path(Group.last))
    end

    it "não cria grupo sem nome" do
      expect {
        post :create, params: { group: { name: "" } }
      }.not_to change(Group, :count)
      expect(response).to render_template(:new)
    end
  end
end
