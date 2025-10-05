module Posts
    class ReactionsController < BaseController

        def create
            @reaction = current_user.reactions.create(post: @post, name: params[:name])
        end

        def count 
            @count = Post.reactions.count
        end

        def destroy
            @Reaction = Reaction.find_by(id: params[:id])
            @Reaction.destroy!

        end
    end
end