class FriendshipsController < ApplicationController
    before_action :set_other_user

    def new; end

    def create
        @friendship = Friendship.create(user: current_user, other_user: @other_user)
    end

    def destroy
        @friendship = Friendship.find_by(other_user_id: params[:id])
        @friendship.destroy!

        flash[:success] = "You're no longer friends"
        redirect_to "/"
    end

    private

    def set_other_user
        @other_user = User.find(params[:user_id])
    end
end
