module Posts
    class ReactionsController < BaseController

        def create
            @reaction = current_user.reactions.create(post: @post, name: params[:name])
        end

        def count 
            @count = Post.reactions.count
        end
    end
end